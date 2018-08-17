//
//  ViewController.m
//  OpenGLES2
//
//  Created by arplanet on 2018/8/17.
//  Copyright © 2018年 Jacob. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    GLKView *glView = (GLKView *)self.view;
    glView.context = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES2];
}
- (void)glkView:(GLKView *)view drawInRect:(CGRect)rect {
    
}


@end
