#version 120

// 受光线影响的纹理

varying vec4 color;
varying vec4 texcoord; // 纹理坐标
varying vec4 lmcoord; // 光度图坐标

void main(){
    gl_Position = ftransform();
    color = gl_Color;
    texcoord = gl_TextureMatrix[0] * gl_MultiTexCoord0;
    lmcoord = gl_TextureMatrix[1] * gl_MultiTexCoord1;
}