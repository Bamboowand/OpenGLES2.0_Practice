//
//  BaseCube.m
//  OpenGLES5
//
//  Created by arplanet on 2018/8/21.
//  Copyright © 2018年 Jacob. All rights reserved.
//

#import "BaseCube.h"

const static BaseVertex verteices[] = {
    // Front
    {{ 1.0, -1.0, 1}, { 1, 0, 0, 1}}, //V0
    {{ 1.0,  1.0, 1}, { 1, 0, 0, 1}}, //V1
    {{-1.0,  1.0, 1}, { 0, 1, 0, 1}}, //V2
    {{-1.0, -1.0, 1}, { 0, 1, 0, 1}}, //V3
    
    // Back
    {{-1.0, -1.0, -1}, { 1, 0, 0, 1}}, //V4
    {{-1.0,  1.0, -1}, { 1, 0, 0, 1}}, //V5
    {{ 1.0,  1.0, -1}, { 0, 1, 0, 1}}, //V6
    {{ 1.0, -1.0, -1}, { 0, 1, 0, 1}}  //V7
};

const static GLubyte indices[] = {
    // Front
    0, 1, 2,
    2, 3, 0,
    // Back
    4, 5, 6,
    6, 7, 4,
    // Left
    3, 2, 5,
    5, 4, 3,
    // Right
    7, 6, 1,
    1, 0, 7,
    // Top
    1, 6, 5,
    5, 2, 1,
    // Bottom
    3, 4, 7,
    7, 0, 3
};

@implementation BaseCube

- (instancetype)initWithShader:(BaseEffect *)shader {
    if ( self = [super initWithName:"Cube" shader:shader verteices:(BaseVertex *)verteices vertexCount:sizeof(verteices) / sizeof(verteices[0]) indeices:(GLubyte *)indices indexCount:sizeof(indices) / sizeof(indices[0])] ) {
        
    }
    return self;
}

- (void)updateWithDelta:(NSTimeInterval)dt {
    self.rotationZ += M_PI * dt;
    self.rotationY += M_PI * dt;
    
}
@end
