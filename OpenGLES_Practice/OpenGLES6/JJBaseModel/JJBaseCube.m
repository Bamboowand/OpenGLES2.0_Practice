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
    {{ 1, -1,  1}, { 1, 0, 0, 1}, { 1, 0}}, //V0
    {{ 1,  1,  1}, { 0, 1, 0, 1}, { 1, 1}}, //V1
    {{-1,  1,  1}, { 0, 0, 1, 1}, { 0, 1}}, //V2
    {{-1, -1,  1}, { 0, 0, 0, 1}, { 0, 0}}, //V3
    
    // Back
    {{-1, -1, -1}, { 1, 0, 0, 1}, { 1, 0}}, //V4
    {{-1,  1, -1}, { 1, 0, 0, 1}, { 1, 1}}, //V5
    {{ 1,  1, -1}, { 0, 1, 0, 1}, { 0, 1}}, //V6
    {{ 1, -1, -1}, { 0, 1, 0, 1}, { 0, 0}},  //V7
    
    // Left
    {{-1, -1,  1}, { 1, 0, 0, 1}, { 1, 0}}, //V8
    {{-1,  1,  1}, { 0, 1, 0, 1}, { 1, 1}}, //V9
    {{-1,  1, -1}, { 0, 0, 1, 1}, { 0, 1}}, //V10
    {{-1, -1, -1}, { 0, 0, 0, 1}, { 0, 0}}, //V11
    
    // Right
    {{ 1, -1, -1}, { 1, 0, 0, 1}, { 1, 0}}, //V12
    {{ 1,  1, -1}, { 0, 1, 0, 1}, { 1, 1}}, //V13
    {{ 1,  1,  1}, { 0, 0, 1, 1}, { 0, 1}}, //V14
    {{ 1, -1,  1}, { 0, 0, 0, 1}, { 0, 0}},  //V15
    
    // Top
    {{ 1,  1,  1}, { 1, 0, 0, 1}, { 1, 0}}, //V16
    {{ 1,  1, -1}, { 0, 1, 0, 1}, { 1, 1}}, //V17
    {{-1,  1, -1}, { 0, 0, 1, 1}, { 0, 1}}, //V18
    {{-1,  1,  1}, { 0, 0, 0, 1}, { 0, 0}},  //V19
    
    // Bottom
    {{ 1, -1, -1}, { 1, 0, 0, 1}, { 1, 0}}, //V16
    {{ 1, -1,  1}, { 0, 1, 0, 1}, { 1, 1}}, //V17
    {{-1, -1, -1}, { 0, 0, 1, 1}, { 0, 1}}, //V18
    {{-1, -1, -1}, { 0, 0, 0, 1}, { 0, 0}}  //V19
};

const static GLubyte indeices[] = {
    // Front
    0, 1, 2,
    2, 3, 0,
    // Back
    4, 5, 6,
    6, 7, 4,
    // Left
    8, 9, 10,
    10, 11, 8,
    // Right
    12, 13, 14,
    14, 15, 12,
    // Top
    16, 17, 18,
    18, 19, 16,
    // Bottom
    20, 21, 22,
    22, 23, 20
};

@implementation JJBaseCube
- (instancetype)initWithShader:(JJBaseEffect *)shader {
    if ( self = [super initWithName:"Cube" shader:shader verteices:(JJBaseVertex *)verteices vertexCount:sizeof(verteices)/sizeof(verteices[0]) indeices:(GLubyte *)indeices indexCount:sizeof(indeices)/sizeof(indeices[0])] ) {
        [self loadTexture:@"test.png"];
    }
    return self;
}

- (void)updateWithDelta:(NSTimeInterval)dt {
    self.rotationY += M_PI * dt;
    self.rotationZ += M_PI * dt;
}
@end
