//
//  BaseSquare.m
//  OpenGLES5
//
//  Created by ChenWei on 2018/8/20.
//  Copyright © 2018年 Jacob. All rights reserved.
//

#import "BaseSquare.h"

const static BaseVertex verteices[] = {
    {{ 1.0, -1.0, 0}, { 1, 0, 0, 1}}, //V0
    {{ 1.0,  1.0, 0}, { 0, 1, 0, 1}}, //V1
    {{-1.0,  1.0, 0}, { 0, 0, 1, 1}}, //V2
    {{-1.0, -1.0, 0}, { 0, 0, 0, 0}}  //V3
};

const static GLubyte indices[] = {
    0, 1, 2,
    2, 3, 0
};

@implementation BaseSquare

- (instancetype)initWithShader:(BaseEffect *)shader {
    if ( self = [super initWithName:"Square" shader:shader verteices:(BaseVertex *)verteices vertexCount:sizeof(verteices) / sizeof(verteices[0]) indeices:(GLubyte *)indices indexCount:sizeof(indices) / sizeof(indices[0])] ) {
        
    }
    return self;
}

- (void)updateWithDelta:(NSTimeInterval)dt {
    float secsPreMove = 2.0;
    self.position = GLKVector3Make(sinf(CACurrentMediaTime() * 2 * M_PI / secsPreMove), self.position.y, self.position.z);
}

@end
