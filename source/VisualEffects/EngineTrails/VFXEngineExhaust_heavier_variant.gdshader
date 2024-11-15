shader_type canvas_item;

uniform sampler2D noise_texture:filter_linear,repeat_enable;
uniform sampler2D tint_gradient:filter_linear;
uniform float speed :hint_range(1.0, 10.0, 0.1) = 1.0;

//void vertex() {
	//vec2 uv = vec2(UV.x + TIME * speed, 0.0);
	//float noise = mix((texture(noise_texture, uv).r + 0.75),  texture(noise_texture, uv*1.3257).r + 0.75, 0.5);
	//VERTEX.x *= (noise);
//}

void fragment() {
	vec2 uv = vec2(UV.x * 0.25 + TIME * speed, UV.y);
	vec2 uv_left_center = vec2(1.0-UV.x, UV.y * 2.0 - 1.0);
	float length_form_center = 1.0 - min(length(uv_left_center), 1.0);
	float core = 1.0 - min(length(uv_left_center)*2.0, 1.0);
	float blend_half_circle = length_form_center * length_form_center;
	vec4 color_out = mix((texture(noise_texture, uv) + 0.75),  texture(noise_texture, uv * 1.1273) + 0.75, 0.5) *  blend_half_circle;

	COLOR.rgb = texture(tint_gradient, vec2(color_out.r, 0.5) ).rgb;
	COLOR.a = color_out.r;
	color_out = (texture(noise_texture, uv) + 1.75) * core*core;
	COLOR.rgb = mix(COLOR.rgb, texture(tint_gradient, vec2(color_out.r, 0.5) ).rgb, 0.5);

}
