attribute vec4 a_Position;
attribute vec4 a_Color;
attribute vec2 a_TexCoord;
attribute vec3 a_Normal;

uniform highp mat4 u_ModelViewMatrix;
uniform highp mat4 u_ProjectionMatrix;

varying lowp vec4 frag_Color;
// Texture
varying lowp vec2 frag_TexCoord;

// Diffuse
varying lowp vec3 frag_Normal;

// Specular
varying lowp vec3 frag_Position;

void main(void) {
    frag_Color = a_Color;
    frag_TexCoord = a_TexCoord;
    frag_Normal = (u_ModelViewMatrix * vec4(a_Normal, 0.0)).xyz;
    frag_Position = (u_ModelViewMatrix * a_Position).xyz;
    gl_Position = u_ProjectionMatrix * u_ModelViewMatrix * a_Position;
}

