shader_type spatial;
render_mode blend_mix, cull_back;

/**
 * This texture sets the background of the [b]Sprite2D[/b] or [b]Polygon2D[/b].
 * It will appear broken in the editor until you assign a [b]Texture Size[/b].
 */
uniform sampler2D background_texture: source_color;
/**
 * This vec2 sets the draw size of the assigned [b]Background Texture[/b].
 * Manual assignment of size is recommended, but it [i]is[/i] possible to do so at initialization.
 * The GDScript may look something like this:
 * [code]# Assign the shader texture its size if not already defined
if material is ShaderMaterial:
	material = material.duplicate()
	var bg_tex = material.get_shader_parameter("background_texture")
	if bg_tex:
		var tx_size = material.get_shader_parameter("texture_size")
		if tx_size == Vector2(0,0):
			material.set_shader_parameter("texture_size", bg_tex.get_size())
 * [/code]
 */
uniform vec2 texture_size;
/**
 * This float scales the assigned [b]Texture Size[/b]'s tile size.
 * Increasing this value makes the texture larger while decreasing shrinks it.
 */
uniform float tile_scale = 1.0;
/**
 * This vec2 shifts the assigned texture by the given value(s).
 */
uniform vec2 offset;
/**
 * This vec2 translates the assigned texture by the given value(s) over time.
 */
uniform vec2 translation_speed;

/**
 * Reference to the mesh's texture, to be assigned via code or in the editor
 */
uniform sampler2D albedo_texture : source_color;

void fragment() {
	// Get the absolute screen pixel coordinate of this fragment.
	// SCREEN_UV goes from (0,0) top‑left to (1,1) bottom‑right.
	// Multiply by VIEWPORT_SIZE to get actual pixel position.
	// Then subtract scrolling offset and manual offset.
	vec2 screen_pixel = (SCREEN_UV * VIEWPORT_SIZE) - (translation_speed * TIME) - offset;

	// Avoid division by zero if texture_size is (0,0).
	vec2 safe_size = max(texture_size, vec2(0.001));

	// Calculate how many tiles away from the origin this pixel is.
	// Example: if tile is 100px wide, pixel 0 → 0.0, pixel 150 → 1.5
	vec2 raw_uv = screen_pixel / (safe_size * tile_scale);

	// Take only the fractional part to wrap around.
	// This turns 1.5 into 0.5, creating the repeating tile.
	vec2 bg_uv = fract(raw_uv);

	// Normally the GPU uses derivatives (rate of change) of bg_uv to pick mipmap levels.
	// But fract() creates a sudden jump at tile edges (from 0.999 to 0.000).
	// That jump makes the derivative spike, forcing a blurry (low‑res) mip.
	// The blur appears as a grey line between tiles.
	// To fix this, we feed the GPU derivatives from raw_uv (which changes smoothly),
	// so it never sees the jump.
	vec2 derivative_dx = dFdx(raw_uv);
	vec2 derivative_dy = dFdy(raw_uv);
	vec4 bg_color = textureGrad(background_texture, bg_uv, derivative_dx, derivative_dy);

	// Output final color.
	ALBEDO = bg_color.rgb;
	ALPHA = bg_color.a;
}