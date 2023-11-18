shader_type canvas_item;

void fragment() {
	vec2 moving_uv = vec2(UV.x-TIME*3.f, UV.y);
	vec4 in_tex = texture(TEXTURE, moving_uv);
	COLOR = in_tex;
}
