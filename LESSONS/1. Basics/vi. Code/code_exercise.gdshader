shader_type canvas_item;

uniform float amount_hidden: hint_range(0.0, 1.0, 0.05) = 0.5;
uniform sampler2D test_texture;

void fragment() {
	float diagonal = (UV.x + UV.y) / 2.0;
	COLOR.a *= step(amount_hidden, diagonal);
	vec4 test = texture(test_texture, UV);
	COLOR.rgb = test.xyz;
}
