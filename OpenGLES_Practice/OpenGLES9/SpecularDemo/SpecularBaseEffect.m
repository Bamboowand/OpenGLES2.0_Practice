//
//  SpecularBaseEffect.m
//  OpenGLES9
//
//  Created by ChenWei on 2018/8/25.
//  Copyright © 2018年 Jacob. All rights reserved.
//

#import "SpecularBaseEffect.h"

@implementation SpecularBaseEffect {
    GLuint modelViewMatrixUniform_;
    GLuint projectionMatrixUniform_;
    GLuint textureUniform_;
    GLuint lightColorUniform_;
    GLuint lightAmbientIntensityUniform_;
    GLuint lightDiffuseIntensityUniform_;
    GLuint lightDirectionUniform_;
    GLuint matSpecularIntensityUniform_;
    GLuint shininessUniform_;
}

- (void)prepareToDraw {
    glUseProgram(_programHandler);
    glUniformMatrix4fv(modelViewMatrixUniform_, 1, 0, self.modelViewMatrix.m);
    glUniformMatrix4fv(projectionMatrixUniform_, 1, 0, self.projectionMatrix.m);
    
    // Ambient
    glUniform3f(lightColorUniform_, 1, 1, 1);
    glUniform1f(lightAmbientIntensityUniform_, 0.1);
    
    // Diffuse
    GLKVector3 lightDirection = GLKVector3Normalize(GLKVector3Make(0, 1, -1));
    glUniform3f(lightDirectionUniform_, lightDirection.x, lightDirection.y, lightDirection.z);
    glUniform1f(lightDiffuseIntensityUniform_, 0.8);
    
    // Specular
    glUniform1f(matSpecularIntensityUniform_, 2.0);
    glUniform1f(shininessUniform_, 128.0);
    
    // Texture
    glActiveTexture(GL_TEXTURE1);
    glBindTexture(GL_TEXTURE_2D, self.texture);
    glUniform1f(textureUniform_, 1);
}

- (instancetype)initWithVertexShader:(NSString *)vertexShader fragmentShader:(NSString *)fragmentShader {
    if ( self = [super init] ) {
        [self compileWithVertexShader:vertexShader fragmentShader:fragmentShader];
        self.modelViewMatrix = GLKMatrix4Identity;
        self.projectionMatrix = GLKMatrix4Identity;
    }
    return self;
}

- (void)compileWithVertexShader:(NSString *)vertexShader fragmentShader:(NSString *)fragmentShader {
    GLuint vertexShaderName = [self compileShader:vertexShader shaderType:GL_VERTEX_SHADER];
    GLuint fragmentShaderName = [self compileShader:fragmentShader shaderType:GL_FRAGMENT_SHADER];
    _programHandler = glCreateProgram();
    glAttachShader(_programHandler, vertexShaderName);
    glAttachShader(_programHandler, fragmentShaderName);
    
    glBindAttribLocation(_programHandler, SpecularVertexAttributPosition, "a_Position");
    glBindAttribLocation(_programHandler, SpecularVertexAttributColor, "a_Color");
    glBindAttribLocation(_programHandler, SpecularVertexAttributTexCoord, "a_TexCoord");
    glBindAttribLocation(_programHandler, SpecularVertexAttributNormal, "a_Normal");
    
    glLinkProgram(_programHandler);
    
    modelViewMatrixUniform_ = glGetUniformLocation(_programHandler, "u_ModelViewMatrix");
    projectionMatrixUniform_ = glGetUniformLocation(_programHandler, "u_ProjectionMatrix");
    textureUniform_ = glGetUniformLocation(_programHandler, "u_Texture");
    
    lightColorUniform_ = glGetUniformLocation(_programHandler, "u_Light.Color");
    lightAmbientIntensityUniform_ = glGetUniformLocation(_programHandler, "u_Light.AmbientIntensity");
    
    lightDiffuseIntensityUniform_ = glGetUniformLocation(_programHandler, "u_Light.DiffuseIntensity");
    lightDirectionUniform_ = glGetUniformLocation(_programHandler, "u_Light.Direction");
    
    matSpecularIntensityUniform_ = glGetUniformLocation(_programHandler, "u_MatSpecularIntensity");
    shininessUniform_ = glGetUniformLocation(_programHandler, "u_Shininess");
    
    
    GLint linkSuccess;
    glGetProgramiv(_programHandler, GL_LINK_STATUS, &linkSuccess);
    
    if ( linkSuccess == GL_FALSE ) {
        GLchar messages[256];
        glGetProgramInfoLog(_programHandler, sizeof(messages), 0, &messages[0]);
        NSString *messagesString = [NSString stringWithUTF8String:messages];
        NSLog(@"%@", messagesString);
    }
}

- (GLuint)compileShader:(NSString *)shaderName shaderType:(GLenum)shaderType {
    NSString *shaderPath = [[NSBundle mainBundle] pathForResource:shaderName ofType:nil];
    NSError *error = nil;
    NSString *shaderString = [NSString stringWithContentsOfFile:shaderPath encoding:NSUTF8StringEncoding error:&error];
    if ( !shaderString ) {
        NSLog(@"Error loading shader: %@", shaderString);
        exit(1);
    }
    int shaderStringLength = (int)[shaderString length];
    const char* shaderUTF8 = [shaderString UTF8String];
    GLuint shaderHandler = glCreateShader(shaderType);
    glShaderSource(shaderHandler, 1, &shaderUTF8, &shaderStringLength);
    
    glCompileShader(shaderHandler);
    
    GLint compileSucess;
    glGetShaderiv(shaderHandler, GL_COMPILE_STATUS, &compileSucess);
    if ( compileSucess == GL_FALSE ) {
        GLchar messages[256];
        glGetShaderInfoLog(shaderHandler, sizeof(messages), 0, &messages[0]);
        NSString *messagesString = [NSString stringWithUTF8String:messages];
        NSLog(@"%@", messagesString);
    }
    return shaderHandler;
}

@end
