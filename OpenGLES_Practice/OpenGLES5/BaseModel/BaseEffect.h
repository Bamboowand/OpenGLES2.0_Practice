//
//  BaseEffect.h
//  OpenGLES5
//
//  Created by ChenWei on 2018/8/19.
//  Copyright © 2018年 Jacob. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <GLKit/GLKit.h>
#import "BaseVertex.h"
#import "BaseEffect.h"


@interface BaseEffect : NSObject

@property(nonatomic, assign) GLuint shaderProgram;
@property(nonatomic, assign) GLKMatrix4 modelViewMatrix;
@property(nonatomic, assign) GLKMatrix4 projectionMatrix;
- (instancetype)initWithVertexShader:(NSString *)vertexShader
                      fragmentShader:(NSString *)fragmentShader;
- (void)prepareToDraw;

@end
