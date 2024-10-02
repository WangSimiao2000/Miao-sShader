#version 120

// 雾

varying vec4 color;
varying vec4 texcoord; // 纹理坐标

void main(){
    gl_Position = ftransform();
    color = gl_Color;
    texcoord = gl_TextureMatrix[0] * gl_MultiTexCoord0;
}