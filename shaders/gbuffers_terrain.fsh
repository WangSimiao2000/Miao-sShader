#version 120

varying vec2 TexCoords;
varying vec3 Normal;
varying vec4 Color;

uniform sampler2D texture;

void main(){
    vec4 albedo = texture2D(texture, TexCoords) * Color; // 从纹理中获取颜色并乘以生物群系颜色
    /* DRAWBUFFERS:01 */
    gl_FragData[0] = albedo; // 颜色
    gl_FragData[1] = vec4(Normal * 0.5f + 0.5f, 1.0f); // 法线颜色(将其从[-1, 1]映射到[0, 1])
}