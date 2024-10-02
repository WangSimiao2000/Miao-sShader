#version 120

// 受光线影响的纹理

uniform sampler2D texture;// 主纹理

varying vec4 color;
varying vec4 texcoord; // 纹理坐标

void main(){
    gl_FragData[0] = texture2D(texture, texcoord.st)*color;
}