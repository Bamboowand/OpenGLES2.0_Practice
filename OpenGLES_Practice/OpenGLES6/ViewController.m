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
    shaderProgram_.projectionMatrix = GLKMatrix4MakePerspective(GLKMathDegreesToRadians(85.0), self.view.bounds.size.width / self.view.bounds.size.height, 1, 150);
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
    GLKMatrix4 viewMatrix = GLKMatrix4MakeTranslation(0, -1, -5);
    [square_ renderWithParentModelViewMatrix:viewMatrix];
}

- (void)update {
    [square_ updateWithDelta:self.timeSinceLastUpdate];
}



@end
