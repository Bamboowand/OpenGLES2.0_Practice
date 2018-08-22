//
//  ViewController.m
//  OpenGLES7
//
//  Created by ChenWei on 2018/8/22.
//  Copyright © 2018年 Jacob. All rights reserved.
//

#import "ViewController.h"
#import "AmbientVertex.h"
#import "AmbientSimpleEffect.h"
#import "AmbientSquare.h"

@interface ViewController () {
    AmbientSimpleEffect *shader_;
    AmbientSquare *square_;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    GLKView *glView = (GLKView *)self.view;
    glView.context = [[EAGLContext alloc]initWithAPI:kEAGLRenderingAPIOpenGLES2];
    [EAGLContext setCurrentContext:glView.context];
    [self setupScene];
}

-(void)glkView:(GLKView *)view drawInRect:(CGRect)rect {
    glClearColor(0, 100.0/255.0, 50.0/255.0, 1);
    glClear(GL_COLOR_BUFFER_BIT);
    [square_ renderWithParentModelViewMatrix:GLKMatrix4MakeTranslation(0, -1, -5)];
    
}

- (void)update {
    
}

- (void)setupScene {
    shader_ = [[AmbientSimpleEffect alloc] initWithVertexShader:@"AmbientVertex.glsl" fragmentShader:@"AmbientFragment.glsl"];
    shader_.projectionMatrix = GLKMatrix4MakePerspective(GLKMathDegreesToRadians(85.0), self.view.bounds.size.width/self.view.bounds.size.height, 1, 150);
    square_ = [[AmbientSquare alloc] initWithShader:shader_];
}


@end
