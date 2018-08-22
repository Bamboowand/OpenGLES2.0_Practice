//
//  JJBaseModel.h
//  OpenGLES6
//
//  Created by ChenWei on 2018/8/21.
//  Copyright © 2018年 Jacob. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <GLKit/GLKit.h>
#import "JJBaseVertex.h"

@class JJBaseEffect;

@interface JJBaseModel : NSObject
@property(nonatomic, strong)JJBaseEffect *shader;
@property(nonatomic, assign) GLKVector3 position;
@property(nonatomic) float rotationX;
@property(nonatomic) float rotationY;
@property(nonatomic) float rotationZ;
@property(nonatomic) float scale;

- (instancetype)initWithName:(char *)name
                      shader:(JJBaseEffect *)shader
                   verteices:(JJBaseVertex *)verteices
                 vertexCount:(unsigned int)vertexCount
                    indeices:(GLubyte *)indeices
                  indexCount:(unsigned int)indexCount;

- (void)renderWithParentModelViewMatrix:(GLKMatrix4)parentModelViewMatrix;
- (void)updateWithDelta:(NSTimeInterval)dt;

@end
