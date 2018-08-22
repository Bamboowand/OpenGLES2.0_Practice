//
//  JJBaseModel.m
//  OpenGLES6
//
//  Created by ChenWei on 2018/8/21.
//  Copyright © 2018年 Jacob. All rights reserved.
//

#import <OpenGLES/ES2/gl.h>
#import <OpenGLES/ES2/glext.h>
#import "JJBaseModel.h"
#import "../JJ6Demo/JJBaseEffect.h"

@implementation JJBaseModel {
    char *name_;
    GLuint vao_;
    GLuint vertexBuffer_;
    GLuint indexBuffer_;
    unsigned int vertexCount_;
    unsigned int indexCount_;
}

- (instancetype)initWithName:(char *)name shader:(JJBaseEffect *)shader verteices:(JJBaseVertex *)verteices vertexCount:(unsigned int)vertexCount indeices:(GLubyte *)indeices indexCount:(unsigned int)indexCount {
    if ( self = [super init] ) {
        name_ = name;
        _shader = shader;
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
        glBufferData(GL_ARRAY_BUFFER, sizeof(JJBaseVertex) * vertexCount_, verteices, GL_STATIC_DRAW);
        
        glGenBuffers(1, &indexBuffer_);
        glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, indexBuffer_);
        glBufferData(GL_ELEMENT_ARRAY_BUFFER, sizeof(GLubyte) * indexCount_, indeices, GL_STATIC_DRAW);
        
        glEnableVertexAttribArray(JJBaseVertexAttributPosition);
        glVertexAttribPointer(JJBaseVertexAttributPosition, 3, GL_FLOAT, GL_FALSE, sizeof(JJBaseVertex), (const GLvoid *)offsetof(JJBaseVertex, Position));
        
        glEnableVertexAttribArray(JJBaseVertexAttributColor);
        glVertexAttribPointer(JJBaseVertexAttributColor, 4, GL_FLOAT, GL_FALSE, sizeof(JJBaseVertex), (const GLvoid *)offsetof(JJBaseVertex, Color));
        
        glEnableVertexAttribArray(JJBaseVertexAttributTexCoord);
        glVertexAttribPointer(JJBaseVertexAttributTexCoord, 2, GL_FLOAT, GL_FALSE, sizeof(JJBaseVertex), (const GLvoid *)offsetof(JJBaseVertex, TexCoord));
        
        
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
    modelViewMatrix = GLKMatrix4Rotate(modelViewMatrix, self.rotationY, 0, 1, 0);
    modelViewMatrix = GLKMatrix4Rotate(modelViewMatrix, self.rotationZ, 0, 0, 1);
    modelViewMatrix = GLKMatrix4Scale(modelViewMatrix, self.scale, self.scale, self.scale);
    return modelViewMatrix;
}

- (void)renderWithParentModelViewMatrix:(GLKMatrix4)parentModelViewMatrix {
    GLKMatrix4 modelViewMatrix = GLKMatrix4Multiply(parentModelViewMatrix, [self modelViewMatrix]);
    _shader.modelViewMatrix = modelViewMatrix;
    _shader.texture =self.texture;
    [_shader prepareToDraw];
    glBindVertexArrayOES(vao_);
    glDrawElements(GL_TRIANGLES, indexCount_, GL_UNSIGNED_BYTE, 0);
    glBindVertexArrayOES(0);
}

- (void)updateWithDelta:(NSTimeInterval)dt {
    
}

- (void)loadTexture:(NSString *)fileName {
    NSError *error = nil;
    NSString *path = [[NSBundle mainBundle] pathForResource:fileName ofType:nil];
    
    NSDictionary *options = @{ GLKTextureLoaderOriginBottomLeft: @YES };
    GLKTextureInfo *info = [GLKTextureLoader textureWithContentsOfFile:path options:options error:&error];
    if ( info == nil ) {
        NSLog(@"Error loading file: %@", error.localizedDescription);
    }
    else {
        self.texture = info.name;
    }
    
}

@end
