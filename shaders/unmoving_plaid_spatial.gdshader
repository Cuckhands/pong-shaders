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
	// Get absolute screen pixel coordinate
	vec2 screen_pixel = (SCREEN_UV * VIEWPORT_SIZE) - (translation_speed * TIME) - offset;
	vec2 safe_size = max(texture_size, vec2(0.001));
	
	// Tile the background
	vec2 raw_uv = screen_pixel / (safe_size * tile_scale);
	vec2 bg_uv = fract(raw_uv);
	vec2 grad_x = dFdx(raw_uv);
	vec2 grad_y = dFdy(raw_uv);
	
	// Apply the background texture and mask out the alpha channel from the
	// Sprite2D texture or Polygon2D shape that this shader is attached to
	vec4 bg_color = textureGrad(background_texture, bg_uv, grad_x, grad_y);
	ALPHA = bg_color.a * texture(albedo_texture, UV).a;
	ALBEDO = bg_color.rgb;
}