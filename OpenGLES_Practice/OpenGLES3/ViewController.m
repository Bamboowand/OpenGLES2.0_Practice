//
//  ViewController.m
//  OpenGLES3
//
//  Created by ChenWei on 2018/8/18.
//  Copyright © 2018年 Jacob. All rights reserved.
//

#import "ViewController.h"


@interface ViewController () {
    GLuint vertexBuffer_;
    GLuint indexBuffer_;
    JJBaseEffect *shader_;
    
    GLsizei indexCount_;
}

@end

@implementation ViewController
#pragma mark - View Life Circle
- (void)viewDidLoad {
    [super viewDidLoad];
    GLKView *glView = (GLKView *)self.view;
    glView.context = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES2];
    [EAGLContext setCurrentContext:glView.context];
    [self setupShader];
    [self setupVertexBuffer];
}

#pragma mark - GLView Delegate
- (void)glkView:(GLKView *)view drawInRect:(CGRect)rect {
    glClearColor(0, 100.4/255.0, 55.0/255.0, 1.0);
    glClear(GL_COLOR_BUFFER_BIT);
    [shader_ prepareToDraw];
    
    //宣告自己的結構
    glEnableVertexAttribArray(JJVertexAttribPosition);
    glVertexAttribPointer(JJVertexAttribPosition, 3, GL_FLOAT, GL_FALSE, sizeof(JJVertex), (const GLvoid *)offsetof(JJVertex, Position));
    
    glEnableVertexAttribArray(JJVertexAttribColor);
    glVertexAttribPointer(JJVertexAttribColor, 4, GL_FLOAT, GL_FALSE, sizeof(JJVertex), (const GLvoid *)offsetof(JJVertex, Color));
    
    glBindBuffer(GL_ARRAY_BUFFER, vertexBuffer_);
    glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, indexBuffer_);
//    glDrawArrays(GL_TRIANGLES, 0, 3);
    glDrawElements(GL_TRIANGLES, indexCount_, GL_UNSIGNED_BYTE, 0);
    
    glDisableVertexAttribArray(JJVertexAttribPosition);
    glDisableVertexAttribArray(JJVertexAttribColor);
    
}

#pragma mark - Setup
- (void)setupVertexBuffer {
    const static JJVertex vertices[] = {
        {{ 1.0, -1.0, 0}, { 1, 0, 0, 1}}, //V0
        {{ 1.0,  1.0, 0}, { 0, 1, 0, 1}}, //V1
        {{-1.0,  1.0, 0}, { 0, 0, 1, 1}}, //V2
        {{-1.0, -1.0, 0}, { 0, 0, 0, 0}}  //V3
    };
    
    const static GLubyte indices[] = {
        0, 1, 2,
        2, 3, 0
    };
    indexCount_ = sizeof(indices) / sizeof(indices[0]);
    
    // Generate Vertex Buffer
    glGenBuffers(1, &vertexBuffer_);
    glBindBuffer(GL_ARRAY_BUFFER, vertexBuffer_);
    glBufferData(GL_ARRAY_BUFFER, sizeof(vertices), vertices, GL_STATIC_DRAW);
    
    // Generate Index Buffer
    glGenBuffers(1, &indexBuffer_);
    glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, indexBuffer_);
    glBufferData(GL_ELEMENT_ARRAY_BUFFER, sizeof(indices), indices, GL_STATIC_DRAW);
}

- (void)setupShader {
    shader_ = [[JJBaseEffect alloc] initWithVertexShader:@"JJSimpleVertex.glsl" fragmentShader:@"JJSimpleFragment.glsl"];
    
}



@end
