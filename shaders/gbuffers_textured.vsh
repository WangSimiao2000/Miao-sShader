#version 120

// 不受光线影响的纹理

varying vec4 color;
varying vec4 texcoord; // 纹理坐标

void main(){
    vec4 position = gl_ModelViewMatrix * gl_Vertex;
    gl_Position = gl_ProjectionMatrix * position;
    gl_FogFragCoord = length(position.xyz);
    gl_Position = ftransform();
    color = gl_Color;
    texcoord = gl_TextureMatrix[0] * gl_MultiTexCoord0;
}