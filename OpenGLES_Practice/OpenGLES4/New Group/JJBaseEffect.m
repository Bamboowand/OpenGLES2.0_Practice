//
//  JJBaseEffect.m
//  OpenGLES4
//
//  Created by ChenWei on 2018/8/19.
//  Copyright © 2018年 Jacob. All rights reserved.
//

#import "JJBaseEffect.h"

@implementation JJBaseEffect {
    
}
- (instancetype)initWithVertexShader:(NSString *)vertexShader fragmentShader:(NSString *)fragmentShader {
    if ( self = [super init] ) {
        [self compileVertexShader:vertexShader fragmentShader:fragmentShader];
    }
    return self;
}

- (void)prepareToDraw {
    glUseProgram(_programHandler);
}

#pragma mark - Compile Shader Methods
- (void)compileVertexShader:(NSString *)vertexShader fragmentShader:(NSString *)fragmentShader {
    GLuint vertexShaderName = [self compileShader:vertexShader shaderType:GL_VERTEX_SHADER];
    GLuint fragmentShaderName = [self compileShader:fragmentShader shaderType:GL_FRAGMENT_SHADER];
    
    _programHandler = glCreateProgram();
    glAttachShader(_programHandler, vertexShaderName);
    glAttachShader(_programHandler, fragmentShaderName);
    
    glBindAttribLocation(_programHandler, JJVertexAttributPosition, "a_Position");
    glBindAttribLocation(_programHandler, JJVertexAttributColor, "a_Color");
    
    glLinkProgram(_programHandler);
    
    GLint linkSuccess;
    glGetProgramiv(_programHandler, GL_LINK_STATUS, &linkSuccess);
    if ( linkSuccess == GL_FALSE ) {
        GLchar messages[256];
        glGetProgramInfoLog(_programHandler, sizeof(messages), 0, &messages[0]);
        NSString *messageString = [NSString stringWithUTF8String:messages];
        NSLog(@"%@",messageString);
        exit(1);
    }
    
}

- (GLuint)compileShader:(NSString *)shaderName shaderType:(GLenum)shaderType {
    NSString *shaderPath = [[NSBundle mainBundle] pathForResource:shaderName ofType:nil];
    
    NSError *error = nil;
    NSString *shaderString = [NSString stringWithContentsOfFile:shaderPath encoding:NSUTF8StringEncoding error:&error];
    if ( !shaderString ) {
        NSLog(@"Error loading shader :%@", error.localizedDescription);
        exit(1);
    }
    int shaderStringLength = (int)[shaderString length];
    
    GLuint shaderHandler = glCreateShader(shaderType);
    const char *shaderUTF8 = [shaderString UTF8String];
    glShaderSource(shaderHandler, 1, &shaderUTF8, &shaderStringLength);
    
    glCompileShader(shaderHandler);
    GLint compileSuccess;
    glGetShaderiv(shaderHandler, GL_COMPILE_STATUS, &compileSuccess);
    if ( compileSuccess == GL_FALSE ) {
        GLchar messages[256];
        glGetShaderInfoLog(shaderHandler, sizeof(messages), 0, &messages[0]);
        NSString *messageString = [NSString stringWithUTF8String:messages];
        NSLog(@"%@", messageString);
        exit(1);
    }
    
    return shaderHandler;
    
    
}
@end
