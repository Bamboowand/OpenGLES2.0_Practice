//
//  JJBaseEffect.m
//  OpenGLES6
//
//  Created by ChenWei on 2018/8/21.
//  Copyright © 2018年 Jacob. All rights reserved.
//

#import "JJBaseEffect.h"

@implementation JJBaseEffect {
    GLuint modelViewMatrixUniform_;
}
- (instancetype)initWithVertexShader:(NSString *)vertexShader
                      fragmentShader:(NSString *)fragmentShader {
    if ( self = [super init] ) {
        [self compileVertexShader:vertexShader fragmentShader:fragmentShader];
    }
    return self;
}

- (void)compileVertexShader:(NSString *)vertexShader fragmentShader:(NSString *)fragmentShader {
    GLuint vertexShaderName = [self compileShader:vertexShader shader:GL_VERTEX_SHADER];
    GLuint fragmentShaderName = [self compileShader:fragmentShader shader:GL_FRAGMENT_SHADER];
    
    _shaderProgram = glCreateProgram();
    glAttachShader(_shaderProgram, vertexShaderName);
    glAttachShader(_shaderProgram, fragmentShaderName);
    
    glEnableVertexAttribArray(JJBaseVertexAttributPosition);
    glBindAttribLocation(_shaderProgram, JJBaseVertexAttributPosition, "a_Position");
    
    glEnableVertexAttribArray(JJBaseVertexAttributColor);
    glBindAttribLocation(_shaderProgram, JJBaseVertexAttributColor, "a_Color");
    
    glLinkProgram(_shaderProgram);
    
    modelViewMatrixUniform_ = glGetUniformLocation(_shaderProgram, "u_ModelViewMartrix");
    
    GLint linkingSuccess;
    glGetProgramiv(_shaderProgram, GL_LINK_STATUS, &linkingSuccess);
    if ( linkingSuccess == GL_FALSE ) {
        GLchar messages[256];
        glGetProgramInfoLog(_shaderProgram, sizeof(messages), 0, &messages[0]);
        NSString *messageString = [NSString stringWithUTF8String:messages];
        NSLog(@"%@", messageString);
        exit(1);
    }
}

- (GLuint)compileShader:(NSString *)shaderName shader:(GLenum)shaderType {
    NSString *shaderPath = [[NSBundle mainBundle] pathForResource:shaderName ofType:nil];
    NSError *error = nil;
    NSString *shaderString = [NSString stringWithContentsOfFile:shaderPath encoding:NSUTF8StringEncoding error:&error];
    
    if ( !shaderString ) {
        NSLog(@"%@", error.localizedDescription);
        exit(1);
    }
    int shaderStringLength = (int)[shaderString length];
    const char *shaderUTF8 = [shaderString UTF8String];
    GLuint shaderHandler = glCreateShader(shaderType);
    glShaderSource(shaderHandler, 1, &shaderUTF8, &shaderStringLength);
    glCompileShader(shaderHandler);
    
    GLint compileSucess;
    glGetShaderiv(shaderHandler, GL_COMPILE_STATUS, &compileSucess);
    if ( compileSucess == GL_FALSE ) {
        GLchar messages[256];
        glGetShaderInfoLog(shaderHandler, sizeof(messages), 0, &messages[0]);
        NSString *messageString = [NSString stringWithUTF8String:messages];
        NSLog(@"%@", messageString);
        exit(1);
    }
    return shaderHandler;
}

- (void)prepareToDraw {
    glUseProgram(_shaderProgram);
    glUniformMatrix4fv(modelViewMatrixUniform_, 1, 0, _modelViewMatrix.m);
}
@end
