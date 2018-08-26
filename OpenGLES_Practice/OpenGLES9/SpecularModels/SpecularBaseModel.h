//
//  SpecularBaseModel.h
//  OpenGLES9
//
//  Created by ChenWei on 2018/8/25.
//  Copyright © 2018年 Jacob. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <GLKit/GLKit.h>
#import <OpenGLES/ES2/gl.h>
#import <OpenGLES/ES2/glext.h>
#import "SpecularVertex.h"

@class SpecularBaseEffect;

@interface SpecularBaseModel : NSObject
@property (nonatomic, strong) SpecularBaseEffect *shader;
@property (nonatomic, assign) GLKVector3 position;
@property (nonatomic) float rotationX;
@property (nonatomic) float rotationY;
@property (nonatomic) float rotationZ;
@property (nonatomic) float scale;
@property (nonatomic) GLuint texture;

- (instancetype)initWithName:(char *)name
                      shader:(SpecularBaseEffect *)shader
                   verteices:(SpecularVertex *)verteices
                 vertexCount:(unsigned int)vertexCount
                    indeices:(GLubyte *)indeices
                  indexCount:(unsigned int)indexCount;

- (void)renderWithParentModelViewMatrix:(GLKMatrix4)parentModelViewMatrix;
- (void)updateWithDelta:(NSTimeInterval)dt;
- (void)loadTexture:(NSString *)fileName;

@end
