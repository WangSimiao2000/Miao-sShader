#version 120

// 雾

uniform sampler2D texture;// 主纹理
uniform sampler2D lightmap;// 光照贴图

varying vec4 color;
varying vec4 texcoord; // 纹理坐标
varying vec4 lmcoord; // 光度图坐标

void main(){
    gl_FragData[0] = texture2D(texture, texcoord.st)* texture2D(lightmap, lmcoord.st)*color;
}