//
//  AmbientSimpleEffect.m
//  OpenGLES7
//
//  Created by ChenWei on 2018/8/22.
//  Copyright © 2018年 Jacob. All rights reserved.
//

#import "AmbientSimpleEffect.h"

@implementation AmbientSimpleEffect {
    GLuint modelViewMatrixUniform_;
    GLuint projectionMatrixUniform_;
    
    // Texture
    GLuint textureUniform_;
    
    // Ambient Light
    GLuint lightColorUniform_;
    GLuint lightAmbientIntensityUniform_;
}

- (instancetype)initWithVertexShader:(NSString *)vertexShader
                      fragmentShader:(NSString *)fragmentShader {
    if ( self = [super init] ) {
        [self compileVertexShader:vertexShader fragmentShader:fragmentShader];
        _modelViewMatrix = GLKMatrix4Identity;
        _projectionMatrix = GLKMatrix4Identity;
    }
    return self;
}

-(void)prepareToDraw {
    glUseProgram(_shaderProgram);
    glUniformMatrix4fv(modelViewMatrixUniform_, 1, 0, self.modelViewMatrix.m);
    glUniformMatrix4fv(projectionMatrixUniform_, 1, 0, self.projectionMatrix.m);
    
    
    // Texture
    glActiveTexture(GL_TEXTURE1);
    glBindTexture(GL_TEXTURE_2D, self.texture);
    glUniform1f(textureUniform_, 1);
    
    // Ambient Light
    glUniform3f(lightColorUniform_, 1, 1, 1);
    glUniform1f(lightAmbientIntensityUniform_, 0.8);
    
}

- (void)compileVertexShader:(NSString *)vertexShader fragmentShader:(NSString *)fragmentShader {
    GLuint vertexShaderName = [self compileShader:vertexShader shaderType:GL_VERTEX_SHADER];
    GLuint fragmentShaderName = [self compileShader:fragmentShader shaderType:GL_FRAGMENT_SHADER];
    _shaderProgram = glCreateProgram();
    glAttachShader(_shaderProgram, vertexShaderName);
    glAttachShader(_shaderProgram, fragmentShaderName);
    
    glBindAttribLocation(_shaderProgram, AmbientVertexAttributPosition, "a_Position");
    glBindAttribLocation(_shaderProgram, AmbientVertexAttributColor, "a_Color");
    glBindAttribLocation(_shaderProgram, AmbientVertexAttributTexCoord, "a_TexCoord");
    
    glLinkProgram(_shaderProgram);
    
    modelViewMatrixUniform_ = glGetUniformLocation(_shaderProgram, "u_ModelViewMatrix");
    projectionMatrixUniform_ = glGetUniformLocation(_shaderProgram, "u_ProjectionMatrix");
    textureUniform_ = glGetUniformLocation(_shaderProgram, "u_Texture");
    
    //Setup Ambient Light
    lightColorUniform_ = glGetUniformLocation(_shaderProgram, "u_Light.Color");
    lightAmbientIntensityUniform_ = glGetUniformLocation(_shaderProgram, "u_Light.AmbientIntensity");
    
    GLint linkingSuccess;
    glGetProgramiv(_shaderProgram, GL_LINK_STATUS, &linkingSuccess);
    if ( linkingSuccess == GL_FALSE ) {
        GLchar messages[256];
        glGetProgramInfoLog(_shaderProgram, sizeof(messages), 0, &messages[0]);
        NSString *messagesString = [NSString stringWithUTF8String:messages];
        NSLog(@"%@", messagesString);
        exit(1);
    }
}

- (GLuint)compileShader:(NSString *)shaderName shaderType:(GLenum)shaderType {
    NSString *shaderPath = [[NSBundle mainBundle] pathForResource:shaderName ofType:nil];
    NSError *error = nil;
    NSString *shaderString = [NSString stringWithContentsOfFile:shaderPath encoding:NSUTF8StringEncoding error:&error];
    if ( !shaderString ) {
        NSLog(@"Error loading shader: %@", error.localizedDescription);
        exit(1);
    }
    int shaderStringLength = (int)[shaderString length];
    const char *shaderUTF8 = [shaderString UTF8String];
    GLuint shaderHandler = glCreateShader(shaderType);
    glShaderSource(shaderHandler, 1, &shaderUTF8, &shaderStringLength);
    glCompileShader(shaderHandler);
    
    GLint compileSuccess;
    glGetShaderiv(shaderHandler, GL_COMPILE_STATUS, &compileSuccess);
    if ( compileSuccess == GL_FALSE ) {
        GLchar messages[256];
        glGetShaderInfoLog(shaderHandler, sizeof(messages), 0, &messages[0]);
        NSString *messagesString = [NSString stringWithUTF8String:messages];
        NSLog(@"%@", messagesString);
        exit(1);
    }
    return shaderHandler;
}

@end
