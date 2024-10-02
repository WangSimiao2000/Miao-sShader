#version 120

#define SHADOW_MAP_BIAS 0.85

uniform float far; 
uniform mat4 gbufferProjectionInverse; // G-buffer的投影矩阵的逆矩阵
uniform mat4 gbufferModelViewInverse; // G-buffer的模型视图矩阵的逆矩阵
uniform mat4 shadowModelView; // 阴影的模型视图矩阵
uniform mat4 shadowProjection; // 阴影的投影矩阵
uniform sampler2D shadow; // 阴影贴图
uniform sampler2D depthtex0; // 绘制G-buffer时的深度缓冲
uniform sampler2D gcolors; // G-buffer的颜色缓冲

varying vec4 texcoord;

float shadowMapping(vec4 worldPosition, float dist){
    if(dist > 0.9){
        return 0.0; // 超出阴影贴图的范围
    }
    
    vec4 shadowPosition = shadowModelView * worldPosition; // 从世界空间转换到阴影空间
    shadowPosition = shadowProjection * shadowPosition; // 从阴影空间转换到裁剪空间
    float distb = sqrt(shadowPosition.x * shadowPosition.x + shadowPosition.y * shadowPosition.y); // 计算距离
    float distortFactor = (1.0 - SHADOW_MAP_BIAS) + distb * SHADOW_MAP_BIAS; // 计算扭曲因子
    shadowPosition.xy /= distortFactor; // 扭曲
    shadowPosition /= shadowPosition.w; // 透视除法
    shadowPosition = shadowPosition * 0.5 + 0.5; // 归一化
    float shadowDepth = texture2D(shadow, shadowPosition.st).z; // 从阴影贴图中获取深度值
    float shade = 0.0; // 阴影值
    if(shadowDepth < shadowPosition.z - 0.0005){ // 如果当前片元在阴影中, -0.0005是因为阴影贴图的深度值有可能有一点偏差
        shade = 1.0; // 阴影值为0.5
    }
    shade -= clamp((dist - 0.7) * 5.0, 0.0, 1.0);
    shade = clamp(shade, 0.0, 1.0);
    return shade;
}

void main(){
    float depth = texture2D(depthtex0, texcoord.st).x; // 从G-buffer的深度缓冲中获取深度值
    vec4 viewPosition = gbufferProjectionInverse * vec4(texcoord.st * 2.0 - 1.0, depth * 2.0 - 1.0, 1.0); // 从G-buffer的深度缓冲中获取视图空间的位置
    vec4 worldPosition = gbufferModelViewInverse * viewPosition; // 从视图空间转换到世界空间
    float dist = length(worldPosition.xyz) / far; // 距离
    float shade = shadowMapping(worldPosition, dist); // 阴影值
    

    /* DRAWBUFFERS:0 */
    gl_FragData[0] = texture2D(gcolors, texcoord.st);
    gl_FragData[0].rgb *= 1.0 - shade * 0.5; // 乘以阴影值
}