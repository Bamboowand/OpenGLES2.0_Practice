//
//  JJBaseEffect.h
//  OpenGLES6
//
//  Created by ChenWei on 2018/8/21.
//  Copyright © 2018年 Jacob. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <GLKit/GLKit.h>
#import "JJBaseVertex.h"

@interface JJBaseEffect : NSObject

@property(nonatomic, assign) GLuint shaderProgram;
@property(nonatomic, assign) GLKMatrix4 modelViewMatrix;

- (instancetype)initWithVertexShader:(NSString *)vertexShader
                      fragmentShader:(NSString *)fragmentShader;

- (void)prepareToDraw;

@end
