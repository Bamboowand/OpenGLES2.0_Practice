//
//  SpecularBaseModel.m
//  OpenGLES9
//
//  Created by ChenWei on 2018/8/25.
//  Copyright © 2018年 Jacob. All rights reserved.
//

#import "SpecularBaseModel.h"
#import "SpecularBaseEffect.h"

@implementation SpecularBaseModel {
    char *name_;
    GLuint vao_;
    GLuint vertexBuffer_;
    GLuint indexBuffer_;
    unsigned int vertexCount_;
    unsigned int indexCount_;
}

- (instancetype)initWithName:(char *)name shader:(SpecularBaseEffect *)shader verteices:(SpecularVertex *)verteices vertexCount:(unsigned int)vertexCount indeices:(GLubyte *)indeices indexCount:(unsigned int)indexCount {
    if ( self = [super init] ) {
        name_ = name;
        vertexCount_ = vertexCount;
        indexCount_ = indexCount;
        _shader = shader;
        
        _position = GLKVector3Make(0, 0, 0);
        _rotationX = 0;
        _rotationY = 0;
        _rotationZ = 0;
        _scale = 1.0;
        
        
        glGenVertexArraysOES(1, &vao_);
        glBindVertexArrayOES(vao_);
        
        glGenBuffers(1, &vertexBuffer_);
        glBindBuffer(GL_ARRAY_BUFFER, vertexBuffer_);
        glBufferData(GL_ARRAY_BUFFER, sizeof(SpecularVertex) * vertexCount_, verteices, GL_STATIC_DRAW);
        
        glGenBuffers(1, &indexBuffer_);
        glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, indexBuffer_);
        glBufferData(GL_ELEMENT_ARRAY_BUFFER, sizeof(GLubyte) * indexCount_, indeices, GL_STATIC_DRAW);
        
        glEnableVertexAttribArray(SpecularVertexAttributPosition);
        glVertexAttribPointer(SpecularVertexAttributPosition, 3, GL_FLOAT, GL_FALSE, sizeof(SpecularVertex), (const GLvoid *)offsetof(SpecularVertex, Position));
        
        glEnableVertexAttribArray(SpecularVertexAttributColor);
        glVertexAttribPointer(SpecularVertexAttributColor, 4, GL_FLOAT, GL_FALSE, sizeof(SpecularVertex), (const GLvoid *)offsetof(SpecularVertex, Color));
        
        glEnableVertexAttribArray(SpecularVertexAttributTexCoord);
        glVertexAttribPointer(SpecularVertexAttributTexCoord, 2, GL_FLOAT, GL_FALSE, sizeof(SpecularVertex), (const GLvoid *)offsetof(SpecularVertex, TexCoord));
        
        glEnableVertexAttribArray(SpecularVertexAttributNormal);
        glVertexAttribPointer(SpecularVertexAttributNormal, 3, GL_FLOAT, GL_FALSE, sizeof(SpecularVertex), (const GLvoid *)offsetof(SpecularVertex, Normal));
        
        glBindVertexArrayOES(0);
        glBindBuffer(GL_ARRAY_BUFFER, 0);
        glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, 0);
    }
    return self;
}

- (void)renderWithParentModelViewMatrix:(GLKMatrix4)parentModelViewMatrix {
    GLKMatrix4 modelViewMatrix = GLKMatrix4Multiply(parentModelViewMatrix, [self modelViewMatrix]);
    _shader.modelViewMatrix = modelViewMatrix;
    [_shader prepareToDraw];
    glBindVertexArrayOES(vao_);
    glDrawElements(GL_TRIANGLES, indexCount_, GL_UNSIGNED_BYTE, 0);
    glBindVertexArrayOES(0);
}

- (GLKMatrix4)modelViewMatrix {
    GLKMatrix4 modelViewMatrix = GLKMatrix4Identity;
    modelViewMatrix = GLKMatrix4Translate(modelViewMatrix, self.position.x, self.position.y, self.position.z);
    modelViewMatrix = GLKMatrix4Rotate(modelViewMatrix, self.rotationX, 1, 0, 0);
    modelViewMatrix = GLKMatrix4Rotate(modelViewMatrix, self.rotationY, 0, 1, 0);
    modelViewMatrix = GLKMatrix4Rotate(modelViewMatrix, self.rotationZ, 0, 0, 1);
    modelViewMatrix = GLKMatrix4Scale(modelViewMatrix, self.scale, self.scale, self.scale);
    return modelViewMatrix;
}

- (void)updateWithDelta:(NSTimeInterval)dt {
    
}

- (void)loadTexture:(NSString *)fileName {
    NSString *path = [[NSBundle mainBundle] pathForResource:fileName ofType:nil];
    NSError *error = nil;
    NSDictionary *options = @{ GLKTextureLoaderOriginBottomLeft : @YES };
    GLKTextureInfo *info = [GLKTextureLoader textureWithContentsOfFile:path options:options error:&error];
    
    if ( info == nil) {
        NSLog(@"Error loading texture: %@", error.localizedDescription);
        exit(1);
    }
    else {
        self.texture = info.name;
    }
    
}

@end
