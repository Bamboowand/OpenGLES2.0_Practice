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

@property(nonatomic, assign)GLuint shaderProgram;

- (instancetype)initWithVertexShader:(NSString *)vertexShader
                      fragmentShader:(NSString *)fragmentShader;
- (void)prepareToDraw;

@end
