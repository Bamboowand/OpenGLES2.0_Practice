//
//  AmbientModel.m
//  OpenGLES7
//
//  Created by ChenWei on 2018/8/22.
//  Copyright © 2018年 Jacob. All rights reserved.
//

#import "AmbientModel.h"
#import <OpenGLES/ES2/gl.h>
#import <OpenGLES/ES2/glext.h>
#import "AmbientSimpleEffect.h"

@implementation AmbientModel {
    char *name_;
    GLuint vao_;
    GLuint vertexBuffer_;
    GLuint indexBuffer_;
    unsigned int vertexCount_;
    unsigned int indexCount_;
}
- (instancetype)initWithName:(char *)name shader:(AmbientSimpleEffect *)shader verteices:(AmbientVertex *)verteices vertexCount:(unsigned int)vertexCount indeices:(GLubyte *)indeices index:(unsigned int)indexCount {
    if ( self = [super init] ) {
        name_ = name;
        _shaderProgram = shader;
        vertexCount_ = vertexCount;
        indexCount_ = indexCount;
        
        self.position = GLKVector3Make(0, 0, 0);
        self.rotationX = 0;
        self.rotationY = 0;
        self.rotationZ = 0;
        self.scale = 1.0;
        
        glGenVertexArraysOES(1, &vao_);
        glBindVertexArrayOES(vao_);
        
        glGenBuffers(1, &vertexBuffer_);
        glBindBuffer(GL_ARRAY_BUFFER, vertexBuffer_);
        glBufferData(GL_ARRAY_BUFFER, sizeof(AmbientVertex) * vertexCount_, verteices, GL_STATIC_DRAW);
        
        glGenBuffers(1, &indexBuffer_);
        glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, indexBuffer_);
        glBufferData(GL_ELEMENT_ARRAY_BUFFER, sizeof(GLubyte) * indexCount_, indeices, GL_STATIC_DRAW);
        
        glEnableVertexAttribArray(AmbientVertexAttributPosition);
        glVertexAttribPointer(AmbientVertexAttributPosition, 3, GL_FLOAT, GL_FALSE, sizeof(AmbientVertex), (const GLvoid *)offsetof(AmbientVertex, Position));
        
        glEnableVertexAttribArray(AmbientVertexAttributColor);
        glVertexAttribPointer(AmbientVertexAttributColor, 4, GL_FLOAT, GL_FALSE, sizeof(AmbientVertex), (const GLvoid *)offsetof(AmbientVertex, Color));
        
        glBindVertexArrayOES(0);
        glBindBuffer(GL_ARRAY_BUFFER, 0);
        glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, 0);
    
    }
    return self;
}

- (GLKMatrix4)modelViewMatrix {
    GLKMatrix4 modelViewMatrix = GLKMatrix4Identity;
    modelViewMatrix = GLKMatrix4Translate(modelViewMatrix, self.position.x, self.position.y, self.position.z);
    modelViewMatrix = GLKMatrix4Rotate(modelViewMatrix, self.rotationX, 1, 0, 0);
    modelViewMatrix = GLKMatrix4Rotate(modelViewMatrix, self.rotationX, 0, 1, 0);
    modelViewMatrix = GLKMatrix4Rotate(modelViewMatrix, self.rotationX, 0, 0, 1);
    modelViewMatrix = GLKMatrix4Scale(modelViewMatrix, self.scale, self.scale, self.scale);
    return modelViewMatrix;
}

- (void)renderWithParentModelViewMatrix:(GLKMatrix4)parentModelViewMatrix {
    _shaderProgram.modelViewMatrix = GLKMatrix4Multiply(parentModelViewMatrix, [self modelViewMatrix]);
    [_shaderProgram prepareToDraw];
    glBindVertexArrayOES(vao_);
    glDrawElements(GL_TRIANGLES, indexCount_, GL_UNSIGNED_BYTE, 0);
    glBindVertexArrayOES(0);
}

- (void)updateWithDelta:(NSTimeInterval)dt {
    
}
@end
