//
//  DiffuseBaseModel.m
//  OpenGLES8
//
//  Created by ChenWei on 2018/8/23.
//  Copyright © 2018年 Jacob. All rights reserved.
//

#import "DiffuseBaseModel.h"
#import <OpenGLES/ES2/gl.h>
#import <OpenGLES/ES2/glext.h>
#import "DiffuseBaseEffect.h"

@implementation DiffuseBaseModel {
    char *name_;
    GLuint vao_;
    GLuint vertexBuffer_;
    GLuint indexBuffer_;
    unsigned int vertexCount_;
    unsigned int indexCount_;
}

- (instancetype)initWithName:(char *)name shader:(DiffuseBaseEffect *)shader verteices:(DiffuseVertex *)verteices vertexCount:(unsigned int)vertexCount indeices:(GLubyte *)indeices indexCount:(unsigned int)indexCount {
    if ( self = [super init] ) {
        name_= name;
        _shader = shader;
        vertexCount_ = vertexCount;
        indexCount_ = indexCount;
        
        glGenVertexArraysOES(1, &vao_);
        glBindVertexArrayOES(vao_);
        
        glGenBuffers(1, &vertexBuffer_);
        glBindBuffer(GL_ARRAY_BUFFER, vertexBuffer_);
        glBufferData(GL_ARRAY_BUFFER, sizeof(DiffuseVertex) * vertexCount, verteices, GL_STATIC_DRAW);
        
        glGenBuffers(1, &indexBuffer_);
        glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, indexBuffer_);
        glBufferData(GL_ELEMENT_ARRAY_BUFFER, sizeof(GLubyte) * indexCount, indeices, GL_STATIC_DRAW);
        
        glEnableVertexAttribArray(DiffuseVertexAttributPosition);
        glVertexAttribPointer(DiffuseVertexAttributPosition, 3, GL_FLOAT, GL_FALSE, sizeof(DiffuseVertex), (const GLvoid *)offsetof(DiffuseVertex, Position));
        
        glEnableVertexAttribArray(DiffuseVertexAttributColor);
        glVertexAttribPointer(DiffuseVertexAttributColor, 4, GL_FLOAT, GL_FALSE, sizeof(DiffuseVertex), (const GLvoid *)offsetof(DiffuseVertex, Color));
        
        glBindVertexArrayOES(0);
        glBindBuffer(GL_ARRAY_BUFFER, 0);
        glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, 0);
    }
    return self;
}

- (void)render {
    [_shader prepareToDraw];
    glBindVertexArrayOES(vao_);
    glDrawElements(GL_TRIANGLES, indexCount_, GL_UNSIGNED_BYTE, 0);
    glBindVertexArrayOES(0);
}

- (void)updateWithDelta:(NSTimeInterval)dt {
    
}

@end
