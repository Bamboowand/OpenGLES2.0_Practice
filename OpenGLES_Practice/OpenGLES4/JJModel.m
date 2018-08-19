//
//  JJModel.m
//  OpenGLES4
//
//  Created by ChenWei on 2018/8/19.
//  Copyright © 2018年 Jacob. All rights reserved.
//

#import "JJModel.h"
#import "JJBaseEffect.h"

@implementation JJModel {
    char *name_;
    GLuint vao_;
    GLuint vertexBuffer_;
    GLuint indexBuffer_;
    unsigned int vertexCount_;
    unsigned int indexCount_;
    
    JJBaseEffect *shader_;
    
}

- (instancetype)initWithName:(char *)name shader:(JJBaseEffect *)shader vertices:(JJVertex *)vertices vertexCount:(unsigned int)vertexCount indices:(GLubyte *)indices indexCount:(unsigned int)indexCount {
    if ( self = [super init] ) {
        name_ = name;
        vertexCount_ = vertexCount;
        indexCount_ = indexCount;
        shader_ = shader;
        
        glGenVertexArraysOES(1, &vao_);
        glBindVertexArrayOES(vao_);
        
        // Generate vertex buffer
        glGenBuffers(1, &vertexBuffer_);
        glBindBuffer(GL_ARRAY_BUFFER, vertexBuffer_);
        glBufferData(GL_ARRAY_BUFFER, vertexCount * sizeof(JJVertex), vertices, GL_STATIC_DRAW);
        
        // Generate indx buffer
        glGenBuffers(1, &indexBuffer_);
        glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, indexBuffer_);
        glBufferData(GL_ELEMENT_ARRAY_BUFFER, indexCount * sizeof(GLubyte), indices, GL_STATIC_DRAW);
        
        // Enable Vertex attributes
        glEnableVertexAttribArray(JJVertexAttribPosition);
        glVertexAttribPointer(JJVertexAttribPosition, 3, GL_FLOAT, GL_FALSE, sizeof(JJVertex), (const GLvoid *)offsetof(JJVertex, Position));
        glEnableVertexAttribArray(JJVertexAttribColor);
        glVertexAttribPointer(JJVertexAttribColor, 4, GL_FLOAT, GL_FALSE, sizeof(JJVertex), (const GLvoid *)offsetof(JJVertex, Color));
        
        glBindVertexArrayOES(0);
        glBindBuffer(GL_ARRAY_BUFFER, 0);
        glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, 0);
        
    }
    
    return self;
}

- (void)render {
    [shader_ prepareToDraw];
    glBindVertexArrayOES(vao_);
    glDrawElements(GL_TRIANGLES, indexCount_, GL_UNSIGNED_BYTE, 0);
    glBindVertexArrayOES(0);
}

@end
