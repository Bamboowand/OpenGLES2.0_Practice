//
//  JJBaseSquare.m
//  OpenGLES6
//
//  Created by ChenWei on 2018/8/22.
//  Copyright © 2018年 Jacob. All rights reserved.
//

#import "JJBaseSquare.h"
const static JJBaseVertex verteices[] = {
    {{  1.0, -1.0, 0}, {1, 0, 0, 1}}, // V0
    {{  1.0,  1.0, 0}, {0, 1, 0, 1}}, // V1
    {{ -1.0,  1.0, 0}, {0, 0, 1, 1}}, // V2
    {{ -1.0, -1.0, 0}, {0, 0, 0, 0}}
};

const static GLubyte indeices[] = {
    0, 1, 2,
    2, 3, 0
};

@implementation JJBaseSquare

- (instancetype)initWithShader:(JJBaseEffect *)shader {
    if ( self = [super initWithName:"Square" shader:shader verteices:(JJBaseVertex *)verteices vertexCount:sizeof(verteices)/sizeof(verteices[0]) indeices:(GLubyte *)indeices indexCount:sizeof(indeices)/sizeof(indeices[0])] ) {
        
    }
    return self;
}

- (void)updateWithDelta:(NSTimeInterval)dt {
    float secsPreMov = 2.0;
    self.position = GLKVector3Make(sinf(CACurrentMediaTime() * 2 * M_PI / secsPreMov), self.position.y, self.position.z);
}
@end
