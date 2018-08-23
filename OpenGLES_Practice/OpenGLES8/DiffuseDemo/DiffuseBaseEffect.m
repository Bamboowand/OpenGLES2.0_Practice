//
//  DiffuseBaseEffect.m
//  OpenGLES8
//
//  Created by ChenWei on 2018/8/23.
//  Copyright © 2018年 Jacob. All rights reserved.
//

#import "DiffuseBaseEffect.h"

@implementation DiffuseBaseEffect
- (GLuint)compileShader:(NSString *)shaderName shaderType:(GLenum)shaderType {
    NSString *shaderPath = [[NSBundle mainBundle] pathForResource:shaderName ofType:nil];
    NSError *error = nil;
    NSString *shaderString = [NSString stringWithContentsOfFile:shaderPath encoding:NSUTF8StringEncoding error:&error];
    
    if ( !shaderString ) {
        NSLog(@"Error loading shader: %@", error.localizedDescription);
        exit(1);
    }
    int shaderStingLength = (int)[shaderString length];
    const char *shaderUTF8 = [shaderString UTF8String];
    GLuint shaderHandler = glCreateShader(shaderType);
    glShaderSource(shaderHandler, 1, &shaderUTF8, &shaderStingLength);
    
    glCompileShader(shaderHandler);
    GLint compileSuccess;
    glGetShaderiv(shaderHandler, GL_COMPILE_STATUS, &compileSuccess);
    if ( compileSuccess == GL_FALSE) {
        GLchar message[256];
        glGetShaderInfoLog(shaderHandler, sizeof(message), 0, &message[0]);
        NSString *messageString = [NSString stringWithUTF8String:message];
        NSLog(@"%@", messageString);
        exit(1);
    }
    return shaderHandler;
}

- (void)compileVertexShader:(NSString *)vertexShader fragmentShader:(NSString *)fragmentShader {
    GLuint vertexShaderName = [self compileShader:vertexShader shaderType:GL_VERTEX_SHADER];
    GLuint fragmentShaderName = [self compileShader:fragmentShader shaderType:GL_FRAGMENT_SHADER];
    _shaderProgram = glCreateProgram();
    glAttachShader(_shaderProgram, vertexShaderName);
    glAttachShader(_shaderProgram, fragmentShaderName);
    
    glBindAttribLocation(_shaderProgram, DiffuseVertexAttributPosition, "a_Position");
    glBindAttribLocation(_shaderProgram, DiffuseVertexAttributColor, "a_Color");
    
    glLinkProgram(_shaderProgram);
    
    GLint linkSuccess;
    glGetProgramiv(_shaderProgram, GL_LINK_STATUS, &linkSuccess);
    if ( linkSuccess == GL_FALSE) {
        GLchar message[256];
        glGetProgramInfoLog(_shaderProgram, sizeof(message), 0, &message[0]);
        NSString *messageString = [NSString stringWithUTF8String:message];
        NSLog(@"%@", messageString);
        exit(1);
    }
}

- (instancetype)initWithVertexShader:(NSString *)vertexShader fragmentShader:(NSString *)fragmentShader {
    if ( self = [super init] ) {
        [self compileVertexShader:vertexShader fragmentShader:fragmentShader];
    }
    return self;
}

- (void)prepareToDraw {
    glUseProgram(_shaderProgram);
}
@end
