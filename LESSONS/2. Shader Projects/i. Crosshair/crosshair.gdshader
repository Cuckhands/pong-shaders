shader_type canvas_item;

/** Sets the crosshair color, including the opacity */
uniform vec4 color: source_color = vec4(1);
/** Sets the center dot thickness */
uniform float dot_size: hint_range(0.0, 1.0) = 0.5;

group_uniforms Ring;
/** Sets how far the ring is from the center */
uniform float circle_distance: hint_range(0.0, 1.0) = 0.75;
/** Sets the ring thickness */
uniform float ring_thickness: hint_range(0.0, 1.0) = 0.15;
/** Creates negative space between the vertical and horizontal axes. */
uniform float cross_cutout_width: hint_range(0.0, 1.0) = 0.25;

group_uniforms Cross;
/** Sets the cross thickness */
uniform float cross_thickness: hint_range(0.0, 1.0) = 0.1;
/** Does nothing for now */
uniform float cross_horizontal_distance: hint_range(0.0, 1.0) = 0.25;
/** Does nothing for now */
uniform float cross_vertical_distance: hint_range(0.0, 1.0) = 0.25;
/** Does nothing for now */
uniform float cross_horizontal_length: hint_range(0.0, 1.0) = 0.5;
/** Does nothing for now */
uniform float cross_vertical_length: hint_range(0.0, 1.0) = 0.5;
/** Swaps the cross for a T-shape. */
uniform bool t_crosshair = false;


float create_circles(vec2 uv) {
	// Find the sizes of the circles, including the center dot
	float center_circle = step(distance(vec2(0.5), uv), dot_size * 0.1);
	float outer_circle = step(distance(vec2(0.5), uv), circle_distance * 0.5);
	float inner_circle = step(distance(vec2(0.5), uv), circle_distance * 0.5 - (ring_thickness * 0.5));
	
	// Find the cross to be cut out
	float vertical_bar = step(distance(uv.x, 0.5), cross_cutout_width * 0.5);
	float horizontal_bar = step(distance(uv.y, 0.5), cross_cutout_width * 0.5);
	float cross_cutout = vertical_bar + horizontal_bar;
	
	// Remove the cutout while retaining the center dot
	return max(center_circle, outer_circle - inner_circle - cross_cutout);
}

float create_cross(vec2 uv) {
	float horizontal_bar = step(distance(uv.y, 0.5), cross_thickness * 0.5);
	float vertical_bar = step(distance(uv.x, 0.5), cross_thickness * 0.5);
	
	float cross_bars = clamp(vertical_bar + horizontal_bar, 0, 1);
	
	// Remove the top bar from the crosshair, if necessary
	if (t_crosshair) {
		cross_bars *= step(0.5 - (cross_thickness * 0.5), uv.y);
	}
	
	return cross_bars;
}

void fragment() {
	COLOR = color;
	
	// Combine the dot, ring, and cross to make a full crosshair
	COLOR.a *= clamp(create_circles(UV) + create_cross(UV), 0, 1);
}