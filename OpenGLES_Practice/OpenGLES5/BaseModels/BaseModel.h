//
//  BaseModel.h
//  OpenGLES5
//
//  Created by ChenWei on 2018/8/20.
//  Copyright © 2018年 Jacob. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <GLKit/GLKit.h>
#import <OpenGLES/ES2/gl.h>
#import <OpenGLES/ES2/glext.h>
#import "BaseVertex.h"
@class BaseEffect;


@interface BaseModel : NSObject
@property(nonatomic, assign) BaseEffect *shader;
@property(nonatomic, assign) GLKVector3 position;
@property(nonatomic) float rotationX;
@property(nonatomic) float rotationY;
@property(nonatomic) float rotationZ;
@property(nonatomic) float scale;

- (instancetype)initWithName:(char *)name
                      shader:(BaseEffect *)shader
                   verteices:(BaseVertex *)verteices
                 vertexCount:(unsigned int)vertexCount
                    indeices:(GLubyte *)indeices
                  indexCount:(unsigned int)indexCount;

- (void)renderWithParentModelViewMatrix:(GLKMatrix4)parentModleViewMatrix;
- (void)updateWithDelta:(NSTimeInterval)dt;

@end
