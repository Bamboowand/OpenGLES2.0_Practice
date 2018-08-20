//
//  BaseModel.m
//  OpenGLES5
//
//  Created by ChenWei on 2018/8/20.
//  Copyright © 2018年 Jacob. All rights reserved.
//

#import "BaseModel.h"
#import "BaseEffect.h"

@implementation BaseModel {
    char *name_;
    GLuint vao_;
    GLuint vertexBuffer_;
    GLuint indexBuffer_;
    unsigned int vertexCount_;
    unsigned int indexCount_;
    
}

- (instancetype)initWithName:(char *)name shader:(BaseEffect *)shader verteices:(BaseVertex *)verteices vertexCount:(unsigned int)vertexCount indeices:(GLubyte *)indeices indexCount:(unsigned int)indexCount {
    if( self = [super init] ) {
        name_ = name;
        _shader = shader;
        vertexCount_ = vertexCount;
        indexCount_ = indexCount;
        
        self.position = GLKVector3Make(0, 0, 0);
        self.rotationX = 0;
        self.rotationY = 0;
        self.rotationZ = 0;
        self.scale = 1.0;
        
        
        // Generate Vertex array object
        glGenVertexArraysOES(1, &vao_);
        glBindVertexArrayOES(vao_);
        
        // Generate vertex buffer
        glGenBuffers(1, &vertexBuffer_);
        glBindBuffer(GL_ARRAY_BUFFER, vertexBuffer_);
        glBufferData(GL_ARRAY_BUFFER, sizeof(BaseVertex) * vertexCount_, verteices, GL_STATIC_DRAW);
        
        // Generate index buffer
        glGenBuffers(1, &indexBuffer_);
        glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, indexBuffer_);
        glBufferData(GL_ELEMENT_ARRAY_BUFFER, sizeof(GLubyte) * indexCount, indeices, GL_STATIC_DRAW);
        
        // Enable vertex attributes
        glEnableVertexAttribArray(BaseVertexAttribPosition);
        glVertexAttribPointer(BaseVertexAttribPosition, 3, GL_FLOAT, GL_FALSE, sizeof(BaseVertex), (const GLvoid *)offsetof(BaseVertex, Position));
        
        glEnableVertexAttribArray(BaseVertexAttribColor);
        glVertexAttribPointer(BaseVertexAttribColor, 4, GL_FLOAT, GL_FALSE, sizeof(BaseVertex), (const GLvoid *)offsetof(BaseVertex, Color));
        
        glBindVertexArrayOES(0);
        glBindBuffer(GL_ARRAY_BUFFER, 0);
        glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, 0);
        
    }
    return self;
}

- (GLKMatrix4)modelMatrix {
    GLKMatrix4 modelMatrix = GLKMatrix4Identity;
    modelMatrix = GLKMatrix4Translate(modelMatrix, self.position.x, self.position.y, self.position.z);
    modelMatrix =  GLKMatrix4Rotate(modelMatrix, self.rotationX, 1, 0, 0);
    modelMatrix =  GLKMatrix4Rotate(modelMatrix, self.rotationY, 0, 1, 0);
    modelMatrix =  GLKMatrix4Rotate(modelMatrix, self.rotationZ, 0, 0, 1);
    modelMatrix = GLKMatrix4Scale(modelMatrix, self.scale, self.scale, self.scale);
    return modelMatrix;
}

- (void)renderWithParentModelViewMatrix:(GLKMatrix4)parentModleViewMatri {
    GLKMatrix4 modelViewMatrix = GLKMatrix4Multiply(parentModleViewMatri, [self modelMatrix]);
    
    _shader.modelViewMatrix = modelViewMatrix;
    [_shader prepareToDraw];
    glBindVertexArrayOES(vao_);
    glDrawElements(GL_TRIANGLES, indexCount_, GL_UNSIGNED_BYTE, 0);
    glBindVertexArrayOES(0);
}

- (void)updateWithDelta:(NSTimeInterval)dt {
    
}

@end
