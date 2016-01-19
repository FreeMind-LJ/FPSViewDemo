//
//  JBFPSView.m
//  FPSViewDemo
//
//  Created by lujiangbin on 16/1/19.
//  Copyright (c) 2016年 lujiangbin. All rights reserved.
//

#import "JBFPSView.h"

@interface JBFPSView ()
@property(nonatomic,assign) CGPoint startPoint;
@property(nonatomic,strong) CADisplayLink *displayLink;
@property(nonatomic,strong) UILabel *displayLabel;
@property(nonatomic,assign) CFTimeInterval startTime;
@property(nonatomic,assign) NSInteger frameCount;
@end

static JBFPSView *fpsView;

@implementation JBFPSView

+(void)showFPSView
{
    if (!fpsView) {
        fpsView = [[JBFPSView alloc] initWithFrame:[UIApplication sharedApplication].statusBarFrame];
    }else{
        if (fpsView.isHidden) {
            [fpsView setHidden:false];
        }
    }
}

+(void)hideFPSView
{
    [fpsView setHidden:true];
}

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor redColor];
        self.windowLevel =UIWindowLevelStatusBar+1;
        self.hidden=NO;
        
        self.displayLabel = [[UILabel alloc] initWithFrame:frame];
        self.displayLabel.textAlignment = NSTextAlignmentCenter;
        self.displayLabel.textColor = [UIColor whiteColor];
        self.displayLabel.font = [UIFont systemFontOfSize:13];
        [self addSubview:self.displayLabel];
        
        [self startDisplaylink];
    }
    return self;
}

-(void)dealloc
{
    [self stopDisplayLink];
}

#pragma mark -- displaylink

-(void)startDisplaylink
{
    _displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(fpsCalculate)];
    self.startTime = CACurrentMediaTime();
    [_displayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
    
}

- (void)stopDisplayLink
{
    [self.displayLink invalidate];
}


- (void)fpsCalculate
{
    self.frameCount++;
    
    CFTimeInterval now = CACurrentMediaTime();
    CFTimeInterval elapsed = now - self.startTime;
    
    if (elapsed >= 1.0) {
        CGFloat frameRate = self.frameCount / elapsed;
        self.displayLabel.text = [NSString stringWithFormat:@"当前实时帧率: %.0f FPS", frameRate];
        self.frameCount = 0;
        self.startTime = now;
    }
}

@end
