#version 120

varying vec2 TexCoords; // 纹理坐标

void main(){
    gl_Position = ftransform(); // ftransform() = gl_ModelViewProjectionMatrix * gl_Vertex 
    TexCoords = gl_MultiTexCoord0.st; // 添加.st是因为内置的纹理坐标gl_MultiTexCoord0是vec4类型的, 而我们只需要前两个分量
}