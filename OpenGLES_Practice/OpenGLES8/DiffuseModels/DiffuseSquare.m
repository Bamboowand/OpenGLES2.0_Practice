//
//  DiffuseSquare.m
//  OpenGLES8
//
//  Created by ChenWei on 2018/8/24.
//  Copyright © 2018年 Jacob. All rights reserved.
//

#import "DiffuseSquare.h"

@implementation DiffuseSquare
const static DiffuseVertex verteices[] = {
    {{  1.0, -1.0, 0}, {1, 0, 0, 1}}, // V0
    {{  1.0,  1.0, 0}, {0, 1, 0, 1}}, // V1
    {{ -1.0,  1.0, 0}, {0, 0, 1, 1}}, // V2
    {{ -1.0, -1.0, 0}, {0, 0, 0, 0}}  // V3
};

const static GLubyte indeices[] = {
    0, 1, 2,
    2, 3, 0
};

- (instancetype)initWithShader:(DiffuseBaseEffect *)shader {
    if ( self = [super initWithName:"Square"
                             shader:shader
                          verteices:(DiffuseVertex *)verteices
                        vertexCount:sizeof(verteices)/sizeof(verteices[0])
                           indeices:(GLubyte *)indeices
                         indexCount:sizeof(indeices)/sizeof(indeices[0])]) {
        
    }
    return self;
}

- (void)updateWithDelta:(NSTimeInterval)dt {
    
}

@end
