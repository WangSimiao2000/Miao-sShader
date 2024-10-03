#version 120

varying vec2 TexCoords; // 纹理坐标
varying vec3 Normal; // 法线
varying vec4 Color; // 顶点颜色

void main() {
    gl_Position = ftransform();
    TexCoords = gl_MultiTexCoord0.st;
    Normal = gl_NormalMatrix * gl_Normal; // 法线变换: 从世界空间变换到视图空间
    Color = gl_Color; // 对于植物类方块: gl_color是生物群系对应的顶点颜色(例如草地, 树叶等在不同生物群系中颜色不同)
}