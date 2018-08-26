//
//  SpecularVertex.h
//  OpenGLES9
//
//  Created by ChenWei on 2018/8/25.
//  Copyright © 2018年 Jacob. All rights reserved.
//

#ifndef SpecularVertex_h
#define SpecularVertex_h
typedef enum {
    SpecularVertexAttributPosition = 0,
    SpecularVertexAttributColor,
    SpecularVertexAttributTexCoord,
    SpecularVertexAttributNormal
} SpecularVertexAttributes;

typedef struct{
    GLfloat Position[3];
    GLfloat Color[4];
    GLfloat TexCoord[2];
    GLfloat Normal[3];
} SpecularVertex;

#endif /* SpecularVertex_h */
