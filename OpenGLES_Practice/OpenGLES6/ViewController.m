//
//  ViewController.m
//  OpenGLES6
//
//  Created by ChenWei on 2018/8/21.
//  Copyright © 2018年 Jacob. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController {
    JJBaseEffect *shaderProgram_;
    JJBaseSquare *square_;
    
}

- (void)setupScene {
    shaderProgram_ = [[JJBaseEffect alloc] initWithVertexShader:@"JJBaseSimpleVertex.glsl" fragmentShader:@"JJBaseSimpleFragment.glsl"];
    square_ = [[JJBaseSquare alloc] initWithShader:shaderProgram_];
}

#pragma mark - View life circle
- (void)viewDidLoad {
    [super viewDidLoad];
    GLKView *glView = (GLKView *)self.view;
    glView.context = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES2];
    [EAGLContext setCurrentContext:glView.context];
    
    [self setupScene];
}

#pragma mark - GLKView delegate methods
- (void)glkView:(GLKView *)view drawInRect:(CGRect)rect {
    glClearColor(0, 100.0/255.0, 50.0/255.0, 1);
    glClear(GL_COLOR_BUFFER_BIT);
    [square_ render];
    
}



@end
