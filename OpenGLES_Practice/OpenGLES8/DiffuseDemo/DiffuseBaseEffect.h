//
//  DiffuseBaseEffect.h
//  OpenGLES8
//
//  Created by ChenWei on 2018/8/23.
//  Copyright © 2018年 Jacob. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <GLKit/GLKit.h>
#import "DiffuseVertex.h"

@interface DiffuseBaseEffect : NSObject

@property(nonatomic, assign) GLuint shaderProgram;
@property(nonatomic, assign) GLKMatrix4 modelViewMatrix;
@property(nonatomic, assign) GLKMatrix4 projectionMatrix;
@property(nonatomic, assign) GLint texture;

- (instancetype)initWithVertexShader:(NSString *)vertexShader
                      fragmentShader:(NSString *)fragmentShader;
- (void)prepareToDraw;

@end
