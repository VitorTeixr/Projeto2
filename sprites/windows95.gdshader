shader_type canvas_item;

uniform float time : hint_range(0.0, 1.0); // Para animar o efeito, se necessário
uniform float scanline_intensity : hint_range(0.0, 1.0) = 0.5; // Intensidade das linhas de varredura
uniform float vignette_intensity : hint_range(0.0, 1.0) = 0.5; // Intensidade da vinheta
uniform vec2 resolution = vec2(512.0, 512.0); // Resolução da tela

void fragment() {
    vec2 uv = FRAGCOORD.xy / resolution.xy;
    vec4 color = texture(TEXTURE, uv);
    
    // Efeito de Scanline
    float scanline = sin(uv.y * resolution.y * 3.14159) * scanline_intensity;
    color.rgb -= scanline;
    
    // Efeito de Vinheta
    vec2 position = uv - 0.5;
    float len = length(position);
    float vignette = smoothstep(0.4, 0.7, len);
    color.rgb *= mix(vec3(1.0), vec3(0.0), vignette * vignette_intensity);
    
    // Cor Final
    COLOR = color;
}
