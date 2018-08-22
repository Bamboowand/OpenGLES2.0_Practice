//
//  AmbientVertex.h
//  OpenGLES7
//
//  Created by ChenWei on 2018/8/22.
//  Copyright © 2018年 Jacob. All rights reserved.
//

#ifndef AmbientVertex_h
#define AmbientVertex_h

typedef enum {
    AmbientVertexAttributPosition = 0,
    AmbientVertexAttributColor
} AmbientVertexAttributes;

typedef struct{
    GLfloat Position[3];
    GLfloat Color[4];
} AmbientVertex;

#endif /* AmbientVertex_h */
