shader_type canvas_item;

uniform sampler2D hidden_texture;

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	// Called for every pixel the material is visible on.
	vec4 top_color = texture(TEXTURE, UV);
	vec4 bottom_color = texture(hidden_texture, UV);
	COLOR = mix(bottom_color, top_color, top_color.a);
}

//void light() {
//	// Called for every pixel for every light affecting the CanvasItem.
//	// Uncomment to replace the default light processing function with this one.
//}
