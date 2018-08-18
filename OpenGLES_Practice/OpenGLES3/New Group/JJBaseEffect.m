//
//  JJBaseEffect.m
//  OpenGLES3
//
//  Created by ChenWei on 2018/8/18.
//  Copyright © 2018年 Jacob. All rights reserved.
//

#import "JJBaseEffect.h"
#import "JJVertex.h"

@implementation JJBaseEffect {
    GLuint programHandle_;
}

- (instancetype)initWithVertexShader:(NSString *)vertexShader
                      fragmentShader:(NSString *)fragmentShader {
    if ( self = [super init] ) {
        [self compileVertexShader:vertexShader fragmentShader:fragmentShader];
    }
    return self;
}

- (void)prepareToDraw {
    glUseProgram(programHandle_);
}

- (GLuint)compileShader:(NSString *)shaderName withType:(GLenum)shaderType {
    NSString *shaderPath = [[NSBundle mainBundle] pathForResource:shaderName ofType:nil];
    NSError *error = nil;
    NSString *shaderString = [NSString stringWithContentsOfFile:shaderPath encoding:NSUTF8StringEncoding error:&error];
    if ( !shaderString ) {
        NSLog(@"Error loading shader :%@", error.localizedDescription);
        exit(1);
    }
    
    GLuint shaderHandler = glCreateShader(shaderType);
    const char *shaderStringUTF8 = [shaderString UTF8String];
    int shaderStringLength = (int)[shaderString length];
    
    glShaderSource(shaderHandler, 1, &shaderStringUTF8, &shaderStringLength);
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

- (void)compileVertexShader:(NSString *)vertexShader
             fragmentShader:(NSString *)fragmentShader {
    GLuint vertexShaderName = [self compileShader:vertexShader withType:GL_VERTEX_SHADER];
    GLuint fragmentShaderName = [self compileShader:fragmentShader withType:GL_FRAGMENT_SHADER];
    
    programHandle_ = glCreateProgram();
    glAttachShader(programHandle_, vertexShaderName);
    glAttachShader(programHandle_, fragmentShaderName);
    
    glBindAttribLocation(programHandle_, JJVertexAttribPosition, "a_Position");
    glBindAttribLocation(programHandle_, JJVertexAttribColor, "a_Color");
    
    glLinkProgram(programHandle_);
    
    GLint linkSuccess;
    glGetShaderiv(programHandle_, GL_LINK_STATUS, &linkSuccess);
    if ( linkSuccess == GL_FALSE ) {
        GLchar message[2500];
        glGetProgramInfoLog(programHandle_, sizeof(message), 0, &message[0]);
        NSString *messageString = [NSString stringWithUTF8String:message];
        NSLog(@"%@", messageString);
        exit(1);
    }
}

@end
