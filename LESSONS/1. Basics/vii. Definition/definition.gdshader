shader_type canvas_item;

void fragment() {
	// Called for every pixel the material is visible on.
	COLOR.a = step(distance(vec2(0.5),UV), 0.5);
}