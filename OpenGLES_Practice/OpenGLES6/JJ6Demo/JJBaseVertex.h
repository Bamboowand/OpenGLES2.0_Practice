//
//  JJBaseVertex.h
//  OpenGLES5
//
//  Created by ChenWei on 2018/8/21.
//  Copyright © 2018年 Jacob. All rights reserved.
//

#ifndef JJBaseVertex_h
#define JJBaseVertex_h

typedef enum{
    JJBaseVertexAttributPosition = 0,
    JJBaseVertexAttributColor
} JJBaseVertexAttributes;

typedef struct{
    GLfloat Position[3];
    GLfloat Color[4];
} JJBaseVertex;

#endif /* JJBaseVertex_h */
