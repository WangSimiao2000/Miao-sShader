#version 120

// 不受光线影响的纹理

uniform int fogMode; // 根据数值确定是否受雾影响
uniform sampler2D texture;// 主纹理

varying vec4 color;
varying vec4 texcoord; // 纹理坐标

void main(){
    gl_FragData[0] = texture2D(texture, texcoord.st)* color;
    if(fogMode == 9729){
        gl_FragData[0].rgb = mix(gl_Fog.color.rgb, gl_FragData[0].rgb, clamp((gl_Fog.end - gl_FogFragCoord) / (gl_Fog.end - gl_Fog.start), 0.0, 1.0));
    }else if(fogMode == 2048){
        gl_FragData[0].rgb = mix(gl_Fog.color.rgb, gl_FragData[0].rgb, clamp(exp(-gl_FogFragCoord * gl_Fog.density), 0.0, 1.0));
    }
}