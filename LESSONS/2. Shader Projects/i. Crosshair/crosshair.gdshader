shader_type canvas_item;

uniform float dot_size: hint_range(0.0, 1.0) = 0.5;
uniform float circle_distance: hint_range(0.0, 1.0) = 0.75;
uniform float ring_thickness: hint_range(0.0, 1.0) = 0.15;
uniform float cutout_cross_thickness: hint_range(0.0, 1.0) = 0.25;

float create_circles(vec2 uv) {
	// Find the sizes of the circles, including the center dot
	float center_circle = step(distance(vec2(0.5), uv), dot_size * 0.1);
	float outer_circle = step(distance(vec2(0.5), uv), circle_distance * 0.5);
	float inner_circle = step(distance(vec2(0.5), uv), circle_distance * 0.5 - (ring_thickness * 0.5));
	
	// Calculates if the UV coord is within the bounds of the cross
	float left_half = step(0.5 - cutout_cross_thickness * 0.5, uv.x);
	float right_half = 1.0 - step(0.5 + cutout_cross_thickness * 0.5, uv.x);
	float top_half = 1.0 - step(0.5 + cutout_cross_thickness * 0.5, uv.y);
	float bottom_half = step(0.5 - cutout_cross_thickness * 0.5, uv.y);
	
	// Vertical Bar + Horizontal Bar
	float cutout_bars = (left_half * right_half) + (top_half * bottom_half);
	
	return max(center_circle, outer_circle - inner_circle - cutout_bars);
}

float create_cross(vec2 uv) {
	return 1.;
}

void fragment() {
	COLOR.rgb = vec3(1);
	
	COLOR.a = create_circles(UV);
}