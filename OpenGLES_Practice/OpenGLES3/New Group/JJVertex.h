//
//  JJVertex.h
//  OpenGLES3
//
//  Created by ChenWei on 2018/8/18.
//  Copyright © 2018年 Jacob. All rights reserved.
//

#ifndef JJVertex_h
#define JJVertex_h
typedef enum {
    JJVertexAttribPosition = 0,
    JJVertexAttribColor
} JJVertexAttributes;

typedef struct {
    GLfloat Position[3];
    GLfloat Color[4];
} JJVertex;


#endif /* JJVertex_h */

