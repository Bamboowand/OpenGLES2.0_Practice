//
//  DiffuseVertex.h
//  OpenGLES8
//
//  Created by ChenWei on 2018/8/23.
//  Copyright © 2018年 Jacob. All rights reserved.
//

#ifndef DiffuseVertex_h
#define DiffuseVertex_h

typedef enum {
    DiffuseVertexAttributPosition = 0,
    DiffuseVertexAttributColor
} DiffuseVertexAttributes;

typedef struct{
    GLfloat Position[3];
    GLfloat Color[4];
} DiffuseVertex;

#endif /* DiffuseVertex_h */
