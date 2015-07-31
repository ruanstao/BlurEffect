//
//  NetConnectErrorView.h
//  BlurEffect
//
//  Created by RuanSTao on 15/7/29.
//  Copyright (c) 2015年 JJS-iMac. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, ErrorViewType) {
    ErrorViewType_Top = 1,
    ErrorViewType_Bottom,
    ErrorViewType_FullScreen,
};

typedef NS_ENUM(NSUInteger, ErrorSelectType) {
    ErrorSelectType_Refresh = 0,
    ErrorSelectType_Cancel,
};

typedef void(^ErrorSelectBlock)(ErrorSelectType type);

@interface NetConnectErrorView : UIView



//default 1s
+ (void)showErrorView:(ErrorViewType ) type withDurationTime:(NSTimeInterval )time complateBlock:(ErrorSelectBlock)block;


@end
