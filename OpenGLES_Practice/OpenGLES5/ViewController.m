//
//  ViewController.m
//  OpenGLES5
//
//  Created by ChenWei on 2018/8/19.
//  Copyright © 2018年 Jacob. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () {
    BaseEffect *shader_;
    BaseSquare *square_;
}

@end

@implementation ViewController
#pragma mark - View Life Circle
- (void)viewDidLoad {
    [super viewDidLoad];
    GLKView *glView = (GLKView *)self.view;
    glView.context = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES2];
    [EAGLContext setCurrentContext:glView.context];
    
    [self setupScene];
}

#pragma mark - GLKView delegate methods
- (void)glkView:(GLKView *)view drawInRect:(CGRect)rect {
    glClearColor(0, 100.0/255.0, 50.0/255.0, 1.0);
    glClear(GL_COLOR_BUFFER_BIT);
    GLKMatrix4 viewMatrix = GLKMatrix4MakeTranslation(0, -1, -5);
    [square_ renderWithParentModelViewMatrix:viewMatrix];
}

#pragma mark - Setup Data Methods
- (void)setupScene {
    shader_ = [[BaseEffect alloc] initWithVertexShader:@"BaseSimpleVertex.glsl" fragmentShader:@"BaseSimpleFragment.glsl"];
    shader_.projectionMatrix = GLKMatrix4MakePerspective(GLKMathDegreesToRadians(85.0), self.view.bounds.size.width  / self.view.bounds.size.height, 1, 150);
    square_ = [[BaseSquare alloc] initWithShader:shader_];


    
}

- (void)update {
    [square_ updateWithDelta:self.timeSinceLastUpdate];
}


@end
