//
//  SpecularSquare.m
//  OpenGLES9
//
//  Created by ChenWei on 2018/8/25.
//  Copyright © 2018年 Jacob. All rights reserved.
//

#import "SpecularSquare.h"
const static SpecularVertex verteices[] = {
    {{  1.0, -1.0, 0}, {1, 0, 0, 1}}, // V0
    {{  1.0,  1.0, 0}, {0, 1, 0, 1}}, // V1
    {{ -1.0,  1.0, 0}, {0, 0, 1, 1}}, // V2
    {{ -1.0, -1.0, 0}, {0, 0, 0, 0}}  // V3
};

const static GLubyte indeices[] = {
    0, 1, 2,
    2, 3, 0
};

@implementation SpecularSquare

- (instancetype)initWithShader:(SpecularBaseEffect *)shader {
    if ( self = [super initWithName:"Square"
                             shader:shader
                          verteices:(SpecularVertex *)verteices
                        vertexCount:sizeof(verteices)/sizeof(verteices[0])
                           indeices:(GLubyte *)indeices
                         indexCount:sizeof(indeices)/sizeof(indeices[0])] ) {
        
    }
    return self;
}

@end
