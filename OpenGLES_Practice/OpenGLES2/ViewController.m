//
//  ViewController.m
//  OpenGLES2
//
//  Created by arplanet on 2018/8/17.
//  Copyright © 2018年 Jacob. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () {
    GLuint vertexBuffer_;
    RWTBaseEffect *shader_;
    
}

@end

@implementation ViewController

- (void)setupVertexBuffer {
    const static RWTVertex vertices[] = {
        {{ -1.0, -1.0, 0}}, //A
        {{  1.0, -1.0, 0}}, //B
        {{  0,  0, 0}}
    };
    
    glGenBuffers(1, &vertexBuffer_);
    glBindBuffer(GL_ARRAY_BUFFER, vertexBuffer_);
    glBufferData(GL_ARRAY_BUFFER, sizeof(vertices), vertices, GL_STATIC_DRAW);
    //第四個參數為設定ＧＬ對他畫的效率，因為我們這邊只畫一次，故使用GL_STATIC_DRAW
}

- (void)setupShader {
    shader_ = [[RWTBaseEffect alloc] initWithVertexShader:@"RWTSimpleVertex.glsl" fragmentShader:@"RWTSimpleFragment.glsl"];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    GLKView *glView = (GLKView *)self.view;
    glView.context = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES2];
    [EAGLContext setCurrentContext:glView.context];
    
    [self setupShader];
    [self setupVertexBuffer];
    
}
- (void)glkView:(GLKView *)view drawInRect:(CGRect)rect {
    glClearColor(0, 100.4/255.0, 55.0/255.0, 1.0);
    glClear(GL_COLOR_BUFFER_BIT);
    [shader_ prepareToDraw];
    
    glEnableVertexAttribArray(RWTVertexAttribPosition);// 開通Shader 的參數
    glVertexAttribPointer(RWTVertexAttribPosition, 3, GL_FLOAT, GL_FALSE, sizeof(RWTVertex), (const GLvoid *)offsetof( RWTVertex, Position));
    //第二個參數為3，因為RWTVertex的成員變數Point的Array.count為3
    //第三個參數為GL_FLOAT，因為數據為float
    //第四個參數為歸一化，if為ture，GL會把 0 to 255 轉換成 0 to 1
    //第五個參數為數據解構大小
    //第六個參數為數據位置
    
    
    
    glBindBuffer(GL_ARRAY_BUFFER, vertexBuffer_);
    glDrawArrays(GL_TRIANGLES, 0, 3);
    
    glDisableVertexAttribArray(RWTVertexAttribPosition);
}


@end
