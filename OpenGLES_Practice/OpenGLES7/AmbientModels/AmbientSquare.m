//
//  AmbientSquare.m
//  OpenGLES7
//
//  Created by ChenWei on 2018/8/23.
//  Copyright © 2018年 Jacob. All rights reserved.
//

#import "AmbientSquare.h"

const static AmbientVertex verteices[] = {
    {{  1.0, -1.0, 0}, {1, 0, 0, 1}}, // V0
    {{  1.0,  1.0, 0}, {0, 1, 0, 1}}, // V1
    {{ -1.0,  1.0, 0}, {0, 0, 1, 1}}, // V2
    {{ -1.0, -1.0, 0}, {0, 0, 0, 0}}  // V3
};

const static GLubyte indeices[] = {
    0, 1, 2,
    2, 3, 0
};

@implementation AmbientSquare
- (instancetype)initWithShader:(AmbientSimpleEffect *)shader {
    if ( self = [super initWithName:"Square" shader:shader verteices:(AmbientVertex *)verteices vertexCount:sizeof(verteices)/sizeof(verteices[0]) indeices:(GLubyte *)indeices index:sizeof(indeices)/sizeof(indeices[0])]) {
        
    }
    return self;
}

@end
