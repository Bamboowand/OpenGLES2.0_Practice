//
//  DiffuseBaseModel.h
//  OpenGLES8
//
//  Created by ChenWei on 2018/8/23.
//  Copyright © 2018年 Jacob. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <GLKit/GLKit.h>
#import "DiffuseVertex.h"

@class DiffuseBaseEffect;

@interface DiffuseBaseModel : NSObject

@property (nonatomic, strong)DiffuseBaseEffect *shader;
- (instancetype)initWithName:(char *)name
                      shader:(DiffuseBaseEffect *)shader
                   verteices:(DiffuseVertex *)verteices
                 vertexCount:(unsigned int)vertexCount
                    indeices:(GLubyte *)indeices
                  indexCount:(unsigned int)indexCount;
- (void)render;
- (void)updateWithDelta:(NSTimeInterval)dt;
@end
