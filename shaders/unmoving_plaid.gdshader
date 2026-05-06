shader_type canvas_item;

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

void fragment() {
	// Get absolute screen pixel coordinate
	vec2 screen_pixel = (SCREEN_UV / SCREEN_PIXEL_SIZE) - (translation_speed * TIME) - offset;
	
	// Tile the background
	vec2 bg_uv = screen_pixel / (texture_size * tile_scale);
	bg_uv = fract(bg_uv);
	
	// Apply the background texture and mask out the alpha channel from the
	// Sprite2D texture or Polygon2D shape that this shader is attached to
	vec4 bg_color = texture(background_texture, bg_uv);
	float mask = texture(TEXTURE, UV).a;
	COLOR = vec4(bg_color);
}