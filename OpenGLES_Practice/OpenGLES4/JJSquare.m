//
//  JJSquare.m
//  OpenGLES4
//
//  Created by ChenWei on 2018/8/19.
//  Copyright © 2018年 Jacob. All rights reserved.
//

#import "JJSquare.h"

const static JJVertex verteics[] = {
    {{ 1.0, -1.0, 0}, { 1, 0, 0, 1}}, //V0
    {{ 1.0,  1.0, 0}, { 0, 1, 0, 1}}, //V1
    {{-1.0,  1.0, 0}, { 0, 0, 1, 1}}, //V2
    {{-1.0, -1.0, 0}, { 0, 0, 0, 0}}  //V3
};

const static GLubyte indicx[] = {
    0, 1, 2,
    2, 3, 0
};

@implementation JJSquare

- (instancetype)initWithShader:(JJBaseEffect*)shader {
    if ( self = [super initWithName:"square" shader:shader vertices:(JJVertex *)verteics vertexCount:sizeof(verteics)/sizeof(verteics[0]) indices:indicx indexCount:sizeof(indicx)/sizeof(indicx[0])] ) {
        
    }
    return self;
}

@end
