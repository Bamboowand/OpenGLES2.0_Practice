//
//  JJBaseCube.m
//  OpenGLES6
//
//  Created by arplanet on 2018/8/22.
//  Copyright © 2018年 Jacob. All rights reserved.
//

#import "JJBaseCube.h"

const static JJBaseVertex verteices[] = {
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

const static GLubyte indeices[] = {
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

@implementation JJBaseCube
- (instancetype)initWithShader:(JJBaseEffect *)shader {
    if ( self = [super initWithName:"Cube" shader:shader verteices:(JJBaseVertex *)verteices vertexCount:sizeof(verteices)/sizeof(verteices[0]) indeices:(GLubyte *)indeices indexCount:sizeof(indeices)/sizeof(indeices[0])] ) {
        
    }
    return self;
}

- (void)updateWithDelta:(NSTimeInterval)dt {
    self.rotationY += M_PI * dt;
    self.rotationZ += M_PI * dt;
}
@end
