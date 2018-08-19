//
//  JJBaseEffect.h
//  OpenGLES4
//
//  Created by ChenWei on 2018/8/19.
//  Copyright © 2018年 Jacob. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <GLKit/GLKit.h>
#import "JJVertex.h"

@interface JJBaseEffect : NSObject

@property(nonatomic, assign)GLuint programHandler;

- (instancetype)initWithVertexShader:(NSString *)vertexShader
                      fragmentShader:(NSString *)fragmentShader;
- (void)prepareToDraw;

@end
