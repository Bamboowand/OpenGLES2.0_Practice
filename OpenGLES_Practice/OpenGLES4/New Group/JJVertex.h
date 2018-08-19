//
//  JJVertex.h
//  OpenGLES4
//
//  Created by ChenWei on 2018/8/19.
//  Copyright © 2018年 Jacob. All rights reserved.
//

#ifndef JJVertex_h
#define JJVertex_h
typedef enum {
    JJVertexAttributPosition = 0,
    JJVertexAttributColor
} JJVertexAttributes;

typedef struct {
    GLfloat Position[3];
    GLfloat Color[4];
} JJVertex;

#endif /* JJVertex_h */
