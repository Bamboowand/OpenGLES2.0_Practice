//
//  JJModel.h
//  OpenGLES4
//
//  Created by ChenWei on 2018/8/19.
//  Copyright © 2018年 Jacob. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <GLKit/GLKit.h>
#import "JJVertex.h"
#import <OpenGLES/ES2/gl.h>
#import <OpenGLES/ES2/glext.h>


@class JJBaseEffect;
@interface JJModel : NSObject

@property(nonatomic, strong) JJBaseEffect *shader;

- (instancetype)initWithName:(char *)name shader:(JJBaseEffect *)shader vertices:(JJVertex *)vertices vertexCount:(unsigned int)vertexCount indices:(GLubyte *)indices indexCount:(unsigned int)indexCount;
- (void)render;

@end
