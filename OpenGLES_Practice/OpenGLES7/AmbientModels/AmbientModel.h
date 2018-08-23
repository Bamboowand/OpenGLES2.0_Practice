//
//  AmbientModel.h
//  OpenGLES7
//
//  Created by ChenWei on 2018/8/22.
//  Copyright © 2018年 Jacob. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <GLKit/GLKit.h>
#import "AmbientVertex.h"

@class AmbientSimpleEffect;

@interface AmbientModel : NSObject

@property (nonatomic, strong) AmbientSimpleEffect *shaderProgram;
@property (nonatomic, assign) GLKVector3 position;
@property (nonatomic) float rotationX;
@property (nonatomic) float rotationY;
@property (nonatomic) float rotationZ;
@property (nonatomic) float scale;
@property (nonatomic) GLuint texture;

- (instancetype)initWithName:(char *)name
                      shader:(AmbientSimpleEffect *)shader
                   verteices:(AmbientVertex *)verteices
                 vertexCount:(unsigned int)vertexCount
                    indeices:(GLubyte *)indeices
                       index:(unsigned int)indexCount;
- (void)renderWithParentModelViewMatrix:(GLKMatrix4)parentModelViewMatrix;
- (void)updateWithDelta:(NSTimeInterval)dt;
- (void)loadTexture:(NSString *)fileName;

@end
