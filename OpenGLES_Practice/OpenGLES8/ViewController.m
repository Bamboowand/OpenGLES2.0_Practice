//
//  ViewController.m
//  OpenGLES8
//
//  Created by ChenWei on 2018/8/23.
//  Copyright © 2018年 Jacob. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () {
    DiffuseBaseEffect *shader_;
    DiffuseSquare *square_;
}

@end

@implementation ViewController
- (void)setupScene {
    shader_ = [[DiffuseBaseEffect alloc] initWithVertexShader:@"DiffuseVertexShader.glsl"
                                               fragmentShader:@"DiffuseFragmentShader.glsl"];
    square_ = [[DiffuseSquare alloc]initWithShader: shader_];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    GLKView *glView = (GLKView *)self.view;
    glView.context = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES2];
    [EAGLContext setCurrentContext:glView.context];
    [self setupScene];
}

- (void)glkView:(GLKView *)view drawInRect:(CGRect)rect {
    glClearColor(0, 100.0/255.0, 50.0/255.0, 1.0);
    glClear(GL_COLOR_BUFFER_BIT);
    [square_ render];
}




@end
