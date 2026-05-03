shader_type canvas_item;

uniform sampler2D background_texture;
uniform vec2 texture_size = vec2(256.0);
uniform float tile_scale = 1.0;

void fragment() {
	// Get absolute screen pixel coordinate
	vec2 screen_pixel = SCREEN_UV * (1.0 / SCREEN_PIXEL_SIZE);
	
	// Tile the background
	vec2 bg_uv = screen_pixel / texture_size * tile_scale;
	bg_uv = fract(bg_uv);
	
	vec4 bg_color = texture(background_texture, bg_uv);
	float mask = texture(TEXTURE, UV).a;
	COLOR = mix(vec4(0.0), bg_color, mask);
}