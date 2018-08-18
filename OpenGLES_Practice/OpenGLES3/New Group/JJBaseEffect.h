//
//  JJBaseEffect.h
//  OpenGLES3
//
//  Created by ChenWei on 2018/8/18.
//  Copyright © 2018年 Jacob. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <GLKit/GLKit.h>

@interface JJBaseEffect : NSObject

@property (nonatomic, assign) GLuint programHandler;

- (instancetype)initWithVertexShader:(NSString *)vertexShader
                      fragmentShader:(NSString *)fragmentShader;

- (void)prepareToDraw;

@end
