shader_type spatial;
render_mode unshaded;

uniform bool flip_x = false;
uniform bool use_screenspace = false;
uniform vec4 albedo_color: source_color = vec4(1,1,1,1);
uniform sampler2D albedo_texture: source_color, hint_default_white;

void vertex() {
	// For testing, lock to camera: it should match the player's view perfectly
	//render_mode cull_disabled, depth_test_disabled, depth_draw_always;
	//POSITION = vec4(VERTEX.x * 2.0, VERTEX.y * (0.75 + 0.25 * sin(TIME)), 0.0, 1.0);
}
uniform sampler2D textureL: source_color;
uniform sampler2D textureR: source_color;
void fragment() {
	vec2 uv;
	if (use_screenspace) {
		uv = SCREEN_UV;
	} else {
		uv = UV;
	}
	// Compatibility renderer (OpenGL) has flipped Y for viewport textures
	if (OUTPUT_IS_SRGB) {
		uv.y = 1.0 - uv.y;
	}
	if (flip_x) {
		uv = vec2(1.0 - uv.x, uv.y);
	}

	if(uint(VIEW_INDEX)==0u)
		ALBEDO = texture(textureL,uv).rgb;
	else
		ALBEDO = texture(textureR,uv).rgb;
	ALBEDO *= albedo_color.rgb * texture(albedo_texture, UV).rgb;
	
	// Place fragment code here.
}
