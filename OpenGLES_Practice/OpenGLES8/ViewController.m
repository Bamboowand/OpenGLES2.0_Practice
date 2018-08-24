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
    DiffuseCube *cube_;
}

@end

@implementation ViewController
- (void)setupScene {
    shader_ = [[DiffuseBaseEffect alloc] initWithVertexShader:@"DiffuseVertexShader.glsl"
                                               fragmentShader:@"DiffuseFragmentShader.glsl"];
    shader_.projectionMatrix = GLKMatrix4MakePerspective(GLKMathDegreesToRadians(85.0), self.view.bounds.size.width/self.view.bounds.size.height, 1, 150);
//    square_ = [[DiffuseSquare alloc]initWithShader: shader_];
    cube_ = [[DiffuseCube alloc] initWithShader:shader_];
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
    glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);
    glEnable(GL_DEPTH_TEST);
    glEnable(GL_CULL_FACE);
    // 開啟混色
    glEnable(GL_BLEND);
    glBlendFunc(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);
    GLKMatrix4 viewMatrix = GLKMatrix4MakeTranslation(0, 0, -5);
    viewMatrix = GLKMatrix4Rotate(viewMatrix, GLKMathDegreesToRadians(20), 1, 0, 0);
//    [square_ renderWithParentModelViewMatrix:viewMatrix];
    [cube_ renderWithParentModelViewMatrix:viewMatrix];
}

- (void)update {
    [cube_ updateWithDelta:self.timeSinceLastUpdate];
}




@end
