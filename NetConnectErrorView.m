//
//  NetConnectErrorView.m
//  BlurEffect
//
//  Created by RuanSTao on 15/7/29.
//  Copyright (c) 2015年 JJS-iMac. All rights reserved.
//

#import "NetConnectErrorView.h"
#import "UIImageEffects.h"
@interface NetConnectErrorView()

@property (nonatomic,strong) ErrorSelectBlock errorSelectBlock;

@end
@implementation NetConnectErrorView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (UIImage *)capture
{
    UIGraphicsBeginImageContextWithOptions([[UIScreen mainScreen] bounds].size, NO, 0);
    [[[UIApplication sharedApplication] keyWindow] drawViewHierarchyInRect:[UIScreen mainScreen].bounds afterScreenUpdates:NO];
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return img;
}


+ (void)showErrorView:(ErrorViewType ) type withDurationTime:(NSTimeInterval )time complateBlock:(ErrorSelectBlock)block
{
    NetConnectErrorView *errorView = [[self alloc] initWithFrame:[UIScreen mainScreen].bounds];
    errorView.errorSelectBlock = block;
    switch (type) {
        case ErrorViewType_Top:{
            [errorView showTopErrorViewDurationTime:time];
        }
            break;
        case ErrorViewType_Bottom:{
            [errorView showBottomErrorViewDurationTime:time];
        }
            break;
        case ErrorViewType_FullScreen:{
            [errorView showFullScreenErrorView];
        }
            break;
        default:
            break;
    }
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.userInteractionEnabled = YES;
    }
    return self;
}

- (void) showBottomErrorViewDurationTime:(NSTimeInterval )time
{
    if (time < 1) {
        time = 1;
    }
    CGFloat height = 49;
    UIImageView *bgImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(self.bounds), CGRectGetWidth(self.bounds), height)];
    bgImgView.backgroundColor = [UIColor colorWithRed:255.0/256.0 green:191.0/256.0 blue:25.0/256.0 alpha:1];
    UILabel *tipsLabel = [[UILabel alloc] initWithFrame:bgImgView.bounds];
    tipsLabel.textAlignment = NSTextAlignmentCenter;
    tipsLabel.text = @"当前网络不可用！";
    tipsLabel.font = [UIFont systemFontOfSize:18];
    tipsLabel.textColor = [UIColor whiteColor];
    [bgImgView addSubview:tipsLabel];
    [self addSubview:bgImgView];
    [UIView animateWithDuration:0.6 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        bgImgView.transform = CGAffineTransformMakeTranslation(0, -height);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.6 delay:time options:UIViewAnimationOptionCurveEaseIn animations:^{
            bgImgView.transform = CGAffineTransformIdentity;
        } completion:^(BOOL finished) {
            [self hide];
        }];
    }];


    [[UIApplication sharedApplication].keyWindow addSubview:self];
}

- (void) showTopErrorViewDurationTime:(NSTimeInterval )time
{
    if (time < 1) {
        time = 1;
    }
    CGFloat height = 64;
    UIImageView *bgImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, -height, CGRectGetWidth(self.bounds), height)];
    bgImgView.backgroundColor = [UIColor colorWithRed:255.0/256.0 green:191.0/256.0 blue:25.0/256.0 alpha:1];
    UIImageView *worningView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ErrorWarning"]];
    worningView.frame = CGRectMake(40, 18, 40, 40);
    UILabel *tipsLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(worningView.frame) + 10, CGRectGetMinY(worningView.frame), CGRectGetWidth(self.bounds) - CGRectGetMaxX(worningView.frame) - 10, CGRectGetHeight(worningView.frame))];
    tipsLabel.text = @"Sorry！网络不好呀！失败了哇！";
    tipsLabel.font = [UIFont systemFontOfSize:18];
    tipsLabel.textColor = [UIColor whiteColor];
    [bgImgView addSubview:worningView];
    [bgImgView addSubview:tipsLabel];
    [self addSubview:bgImgView];
    [UIView animateWithDuration:0.6 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        bgImgView.transform = CGAffineTransformMakeTranslation(0, height);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.6 delay:time options:UIViewAnimationOptionCurveEaseIn animations:^{
            bgImgView.transform = CGAffineTransformIdentity;
        } completion:^(BOOL finished) {
            [self hide];
        }];
    }];
    
    
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    
}


- (void) showFullScreenErrorView
{
    UIImageView *bgImgView = [[UIImageView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    bgImgView.userInteractionEnabled = YES;
    if ([[[UIDevice currentDevice] systemVersion] floatValue] < 8.0) {
        bgImgView.image = [UIImageEffects imageByApplyingDarkEffectToImage:[self capture]];
    }else {
        bgImgView.image = [self capture];
        UIVisualEffectView *effectView = [[UIVisualEffectView alloc] initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleDark]];
        effectView.frame = bgImgView.bounds;
        effectView.userInteractionEnabled = YES;
        [bgImgView addSubview:effectView];
    }
    [self addSubview:bgImgView];

    //总区域
    UIView *showView = [[UIView alloc] initWithFrame:bgImgView.frame];
    showView.backgroundColor = [UIColor clearColor];
    showView.userInteractionEnabled = YES;
    UITapGestureRecognizer *showViewTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showViewClick:)];
    [showView addGestureRecognizer:showViewTap];
    //白色背景
    UIImageView *whiteBgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"NetErrorWhiteBgView"]];
    whiteBgView.frame = CGRectMake(38, 208, CGRectGetWidth(bgImgView.frame) - 38 * 2, CGRectGetHeight(bgImgView.frame) - 208 - 179);
    //网络失败连接图标
    UIImageView *netErrorTopView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"NetError"]];
    netErrorTopView.frame = CGRectMake(CGRectGetMidX(whiteBgView.frame) - 80 / 2, CGRectGetMinY(whiteBgView.frame) - 80 / 2, 80, 80);
    UILabel *connectErrorLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(whiteBgView.frame), CGRectGetMaxY(netErrorTopView.frame) + 20, CGRectGetWidth(whiteBgView.frame), 40)];
    connectErrorLabel.textAlignment = NSTextAlignmentCenter;
    connectErrorLabel.font = [UIFont systemFontOfSize:16];
    connectErrorLabel.text = @"网络连接失败";
    connectErrorLabel.textColor = [UIColor colorWithRed:56.0/256.0 green:68.0/256.0 blue:86.0/256.0 alpha:1];
    
    UIView *sparLine = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetMinX(whiteBgView.frame) + 16 , CGRectGetMaxY(connectErrorLabel.frame) + 16, CGRectGetWidth(whiteBgView.frame) - 16 * 2, 1)];
    sparLine.backgroundColor = [UIColor colorWithRed:212.0/256.0 green:212.0/256.0 blue:212.0/256.0 alpha:1];
    UILabel *despLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(connectErrorLabel.frame), CGRectGetMaxY(sparLine.frame) + 25, CGRectGetWidth(connectErrorLabel.frame), 40)];
    despLabel.textAlignment = NSTextAlignmentCenter;
    despLabel.font = [UIFont systemFontOfSize:14];
    despLabel.text = @"请检查您的网络，带来不便，深感抱歉";
    despLabel.textColor = [UIColor colorWithRed:148.0/256.0 green:151.0/256.0 blue:156.0/256.0 alpha:1];
    UIButton *refreshButton = [UIButton buttonWithType:UIButtonTypeCustom];
    refreshButton.frame = CGRectMake(CGRectGetMinX(despLabel.frame) + 16, CGRectGetMaxY(despLabel.frame) + 32, CGRectGetWidth(despLabel.frame) - 16 *2, 45);
    refreshButton.layer.borderColor = [UIColor colorWithRed:22.0/256.0 green:199.0/256.0 blue:226.0/256.0 alpha:1].CGColor;
    refreshButton.layer.borderWidth = 1;
    [refreshButton setTitle:@"重新加载" forState:UIControlStateNormal];
    [refreshButton setTitleColor:[UIColor colorWithRed:22.0/256.0 green:199.0/256.0 blue:226.0/256.0 alpha:1] forState:UIControlStateNormal];
    [refreshButton addTarget:self action:@selector(refreshButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    UIImageView *cancelView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"NetErrorCancel"]];
    cancelView.frame = CGRectMake(CGRectGetMidX(whiteBgView.frame) - 45 / 2, CGRectGetMaxY(whiteBgView.frame) + 20 + 45 / 2, 45, 45);
    cancelView.userInteractionEnabled = YES;
    cancelView.backgroundColor = [UIColor clearColor];
    UITapGestureRecognizer * cancelTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showViewClick:)];
    [cancelView addGestureRecognizer:cancelTap];
    
    [showView addSubview:whiteBgView];
    [showView addSubview:netErrorTopView];
    [showView addSubview:connectErrorLabel];
    [showView addSubview:sparLine];
    [showView addSubview:despLabel];
    [showView addSubview:refreshButton];
    [showView addSubview:cancelView];
    [self addSubview:showView];
    //逗比动画
    self.alpha = 0;
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        self.alpha = 1;
        showView.transform = CGAffineTransformMakeScale(1.1, 1.1);

    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.1 delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
            showView.transform = CGAffineTransformIdentity;
        } completion:^(BOOL finished) {
            
        }];
    }];
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    
    
}

- (void)refreshButtonClick:(UIButton *)button
{
    [self refreshEvent];
}

- (void)showViewClick:(UITapGestureRecognizer *)ges
{
    [self cancelEvent];
}

- (void)refreshEvent
{
    if (self.errorSelectBlock) {
                self.errorSelectBlock(ErrorSelectType_Refresh);
    }
    [self hide];
}

- (void)cancelEvent
{
    if (self.errorSelectBlock) {
        self.errorSelectBlock(ErrorSelectType_Cancel);
    }
    [self hide];
}

- (void) hide
{
    [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        self.alpha = 0;
    } completion:^(BOOL finished) {
        
        [self removeFromSuperview];
    }];

}

- (BOOL) pointInside:(CGPoint)point withEvent:(UIEvent *)event
{
     BOOL b = NO;
    for (UIView *subView in self.subviews) {
        b = [subView pointInside:point withEvent:event];
        if (b) {
            return b;
        }
    }
    return NO;

}
@end
