//
//  BaseVertex.h
//  OpenGLES_Practice
//
//  Created by ChenWei on 2018/8/19.
//  Copyright © 2018年 Jacob. All rights reserved.
//

#ifndef BaseVertex_h
#define BaseVertex_h

typedef enum {
    BaseVertexAttribPosition = 0,
    BaseVertexAttribColor
} BaseVertexAttributes;

typedef struct {
    GLfloat Position[3];
    GLfloat Color[4];
} BaseVertex;

#endif /* BaseVertex_h */
