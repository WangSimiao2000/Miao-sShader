#version 120

varying vec2 TexCoords; // 纹理坐标

uniform sampler2D colortex0; // minecraft会使用内部着色器来处理缺失的程序, 内部着色器的颜色输出到colortex0纹理中

void main() {
    // Sample the color
   vec3 Color = texture2D(colortex0, TexCoords).rgb; // 从纹理中获取颜色
   // Convert to grayscale
   Color = vec3(dot(Color, vec3(0.333f))); // 灰度化
   // Output the color
   gl_FragColor = vec4(Color, 1.0f); // 最终将颜色输出到gl_FragColor
}