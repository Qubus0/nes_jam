// ref: https://godotshaders.com/shader/simple-circle-transition-2/
shader_type canvas_item;
render_mode unshaded;

uniform vec2 origin = vec2(.5, .5);
uniform float circle_size : hint_range(0.0, 1.05);
uniform vec2 screen_size;

void fragment() {
	float ratio = screen_size.x / screen_size.y;
	float dist = distance(origin, vec2(mix(origin.x, UV.x, ratio), UV.y));
	COLOR.a = step(circle_size, dist);
}