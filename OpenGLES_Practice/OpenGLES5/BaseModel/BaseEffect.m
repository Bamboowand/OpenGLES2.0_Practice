//
//  BaseEffect.m
//  OpenGLES5
//
//  Created by ChenWei on 2018/8/19.
//  Copyright © 2018年 Jacob. All rights reserved.
//

#import "BaseEffect.h"

@implementation BaseEffect {
    GLuint modelViewMatrixUniform_;
    GLuint projectionMatrixUniform_;
}

- (GLuint)compileShader:(NSString *)shader withShadeType:(GLenum)shaderType {
    NSString *shaderPath = [[NSBundle mainBundle] pathForResource:shader ofType:nil];
    NSError *error = nil;
    NSString *shaderString = [NSString stringWithContentsOfFile:shaderPath encoding:NSUTF8StringEncoding error:&error];
    if ( !shaderString ) {
        NSLog(@"Error loading shader :%@", error.localizedDescription);
        exit(1);
    }
    
    int shaderStringLength = (int)[shaderString length];
    const char* shaderUTF8 = [shaderString UTF8String];
    GLuint shaderHandler = glCreateShader(shaderType);
    
    glShaderSource(shaderHandler, 1, &shaderUTF8, &shaderStringLength);
    glCompileShader(shaderHandler);
    
    GLint compileSuccess;
    glGetShaderiv(shaderHandler, GL_COMPILE_STATUS, &compileSuccess);
    if ( compileSuccess == GL_FALSE ) {
        GLchar messages[255];
        glGetShaderInfoLog(shaderHandler, sizeof(messages), 0, &messages[0]);
        NSString *messageString = [NSString stringWithUTF8String:messages];
        NSLog(@"%@", messageString);
        exit(1);
    }
    return shaderHandler;
}

- (void)compileVertexShader:(NSString *)vertexShader fragmentShader:(NSString *)fragmentShader {
    GLuint vertexShaderName = [self compileShader:vertexShader withShadeType:GL_VERTEX_SHADER];
    GLuint fragmentShaderName = [self compileShader:fragmentShader withShadeType:GL_FRAGMENT_SHADER];
    
    _shaderProgram = glCreateProgram();
    glAttachShader(_shaderProgram, vertexShaderName);
    glAttachShader(_shaderProgram, fragmentShaderName);
    
    glBindAttribLocation(_shaderProgram, BaseVertexAttribPosition, "a_Position");
    glBindAttribLocation(_shaderProgram, BaseVertexAttribColor, "a_Color");
    
    glLinkProgram(_shaderProgram);
    
    self.modelViewMatrix = GLKMatrix4Identity;
    modelViewMatrixUniform_ = glGetUniformLocation(_shaderProgram, "u_ModelViewMatrix");
    projectionMatrixUniform_ = glGetUniformLocation(_shaderProgram, "u_ProjectionMatrix");
    
    GLint linkSucess; 
    glGetProgramiv(_shaderProgram, GL_LINK_STATUS, &linkSucess);
    if ( linkSucess == GL_FALSE ) {
        GLchar messages[255];
        glGetProgramInfoLog(_shaderProgram, sizeof(messages), 0, messages);
        NSString *messageString = [NSString stringWithUTF8String:messages];
        NSLog(@"%@", messageString);
        exit(1);
    }
}

- (instancetype)initWithVertexShader:(NSString *)vertexShader
                      fragmentShader:(NSString *)fragmentShader {
    if ( self = [super init] ) {
        [self compileVertexShader:vertexShader fragmentShader:fragmentShader];
    }
    return self;
}

- (void)prepareToDraw {
    glUseProgram(_shaderProgram);
    glUniformMatrix4fv(modelViewMatrixUniform_, 1, 0, self.modelViewMatrix.m);
    glUniformMatrix4fv(projectionMatrixUniform_, 1, 0, self.projectionMatrix.m);
}

@end
