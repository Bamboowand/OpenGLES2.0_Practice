//
//  SpecularBaseEffect.h
//  OpenGLES9
//
//  Created by ChenWei on 2018/8/25.
//  Copyright © 2018年 Jacob. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <GLKit/GLKit.h>
#import "SpecularVertex.h"

@interface SpecularBaseEffect : NSObject

@property (nonatomic, assign) GLuint programHandler;
@property (nonatomic, assign) GLKMatrix4 modelViewMatrix;
@property (nonatomic, assign) GLKMatrix4 projectionMatrix;
@property (nonatomic) GLuint texture;

- (instancetype)initWithVertexShader:(NSString *)vertexShader
                      fragmentShader:(NSString *)fragmentShader;

- (void)prepareToDraw;

@end
