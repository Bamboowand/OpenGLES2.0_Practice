//
//  DiffuseBaseEffect.m
//  OpenGLES8
//
//  Created by ChenWei on 2018/8/23.
//  Copyright © 2018年 Jacob. All rights reserved.
//

#import "DiffuseBaseEffect.h"

@implementation DiffuseBaseEffect {
    GLuint modelViewMatrixUniform_;
    GLuint projectionMatrixUniform_;
    GLuint textureUniform_;
    GLuint lightColorUniform_;
    GLuint lightIntensityUniform_;
    GLuint lightDiffuseIntensityUniform_;
    GLuint lightDirectionUniform_;
}
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
    glBindAttribLocation(_shaderProgram, DiffuseVertexAttributTexCoord, "a_TexCoord");
    glBindAttribLocation(_shaderProgram, DiffuseVertexAttributNormal, "a_Normal");
    
    glLinkProgram(_shaderProgram);
    
    modelViewMatrixUniform_ = glGetUniformLocation(_shaderProgram, "u_ModelViewMatrix");
    projectionMatrixUniform_ = glGetUniformLocation(_shaderProgram, "u_ProjectionMatrix");
    textureUniform_ = glGetUniformLocation(_shaderProgram, "u_Texture");
    
    lightColorUniform_ = glGetUniformLocation(_shaderProgram, "u_Light.Color");
    lightIntensityUniform_ = glGetUniformLocation(_shaderProgram, "u_Light.AmbientIntensity");
    
    lightDiffuseIntensityUniform_ = glGetUniformLocation(_shaderProgram, "u_Light.DiffuseIntensity");
    lightDirectionUniform_ = glGetUniformLocation(_shaderProgram, "u_Light.Direction");
    
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
        self.modelViewMatrix = GLKMatrix4Identity;
        self.projectionMatrix = GLKMatrix4Identity;
    }
    return self;
}

- (void)prepareToDraw {
    glUseProgram(_shaderProgram);
    glUniformMatrix4fv(modelViewMatrixUniform_, 1, 0, self.modelViewMatrix.m);
    glUniformMatrix4fv(projectionMatrixUniform_, 1, 0, self.projectionMatrix.m);
    
    //Texture
    glActiveTexture(GL_TEXTURE1);
    glBindTexture(GL_TEXTURE_2D, self.texture);
    glUniform1f(textureUniform_, 1);
    
    //Ambient
    glUniform3f(lightColorUniform_, 1, 1, 1);
    glUniform1f(lightIntensityUniform_, 0.1);
    
    //Diffuse
    GLKVector3 lightDirection = GLKVector3Normalize(GLKVector3Make(0, 1, -1));
    glUniform3f(lightDirectionUniform_, lightDirection.x, lightDirection.y, lightDirection.z);
    glUniform1f(lightDiffuseIntensityUniform_, 0.7);
    
    
    
    
}
@end
