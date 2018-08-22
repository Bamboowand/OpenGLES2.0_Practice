//
//  AmbientSimpleEffect.h
//  OpenGLES7
//
//  Created by ChenWei on 2018/8/22.
//  Copyright © 2018年 Jacob. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <GLKit/GLKit.h>
#import "AmbientVertex.h"

@interface AmbientSimpleEffect : NSObject

@property(nonatomic, assign)GLuint shaderProgram;
@property(nonatomic, assign)GLKMatrix4 modelViewMatrix;
@property(nonatomic, assign)GLKMatrix4 projectionMatrix;

- (instancetype)initWithVertexShader:(NSString *)vertexShader
                      fragmentShader:(NSString *)fragmentShader;

-(void)prepareToDraw;

@end
