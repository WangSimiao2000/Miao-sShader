#version 120

varying vec2 TexCoords;

// Direction of the sun (not normalized!)
uniform vec3 sunPosition; // 太阳位置(未归一化!)

// The color textures which we wrote to
// 在gbuffers_terrain.fsh中写入的颜色纹理
uniform sampler2D colortex0;
uniform sampler2D colortex1;

/*
const int colortex0Format = RGBA16;
const int colortex1Format = RGBA16;
*/

const float sunPathRotation = -40.0f; // 太阳的倾斜

const float Ambient = 0.1f; // 环境光的强度

void main(){
    // Account for gamma correction
    vec3 Albedo = pow(texture2D(colortex0, TexCoords).rgb, vec3(2.2f)); // 反照率: 物体表面反射光的能力(0表示完全吸收, 1表示完全反射), 这里进行了gamma校正(以还原真实的亮度)
    // Get the normal
    vec3 Normal = normalize(texture2D(colortex1, TexCoords).rgb * 2.0f - 1.0f);// 法线: 从[0, 1]映射到[-1, 1], 并归一化
    // Compute cos theta between the normal and sun directions
    float NdotL = max(dot(Normal, normalize(sunPosition)), 0.0f); // 计算法线和太阳方向之间的点积, 即余弦值(因为两者已经归一化)
    // Do the lighting calculations
    vec3 Diffuse = Albedo * (NdotL + Ambient); // 漫反射: 反照率乘以余弦值加上环境光的和
    /* DRAWBUFFERS:0 */
    // Finally write the diffuse color
    gl_FragData[0] = vec4(Diffuse, 1.0f);
}