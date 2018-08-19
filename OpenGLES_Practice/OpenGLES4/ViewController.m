//
//  ViewController.m
//  OpenGLES4
//
//  Created by ChenWei on 2018/8/19.
//  Copyright © 2018年 Jacob. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController {
    JJBaseEffect *shaderProgram_;
    JJSquare *square_;
}

- (void)setupScene {
    shaderProgram_ = [[JJBaseEffect alloc] initWithVertexShader:@"JJSimpleVertex.glsl" fragmentShader:@"JJSimpleFragment.glsl"];
    square_ = [[JJSquare alloc] initWithShader:shaderProgram_];
}


#pragma mark - View Life Circle
- (void)viewDidLoad {
    [super viewDidLoad];
    GLKView *glView = (GLKView *)self.view;
    glView.context = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES2];
    [EAGLContext setCurrentContext:glView.context];
    [self setupScene];
    
}

#pragma mark - GLKView Delegate Methods
- (void)glkView:(GLKView *)view drawInRect:(CGRect)rect {
    glClearColor(0, 100.0/255.0, 55.0/255.0, 1.0);
    glClear(GL_COLOR_BUFFER_BIT);
    [square_ render];
}



@end
