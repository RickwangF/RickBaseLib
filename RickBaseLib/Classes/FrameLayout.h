//
//  FrameLayout.h
//  StringDemo
//
//  Created by Rick on 2019/9/9.
//  Copyright © 2019 Rick. All rights reserved.
//

#ifndef FrameLayout_h
#define FrameLayout_h

#include <CoreGraphics/CGGeometry.h>

#pragma mark - CGRect以中心点和宽高的初始化方法

CG_INLINE CGRect
CGRectCenterMake(CGFloat centerX, CGFloat centerY, CGFloat width, CGFloat height)
{
    CGRect rect;
    rect.origin.x = centerX - width * 0.5;
    rect.origin.y = centerY - height * 0.5;
    rect.size.width = width; rect.size.height = height;
    return rect;
}

#pragma mark - 设备尺寸

#define SCREEN_WIDTH UIScreen.mainScreen.bounds.size.width
#define SCREEN_HEIGHT UIScreen.mainScreen.bounds.size.height
#define SCREEN_BOUNDS UIScreen.mainScreen.bounds

#pragma mark - 设备类型判断

#define IS_IPAD (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#define IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define IS_IPHONEX_SERIES ([[NSString stringWithFormat:@"%.2f", 9.0 / 19.5] floatValue] == [[NSString stringWithFormat:@"%.2f", SCREEN_WIDTH / SCREEN_HEIGHT] floatValue])

#pragma mark - 16:9比例下的宽高

#define SCREEN16_9_WIDTH SCREEN_HEIGHT * 9.0 / 16.0
#define SCREEN16_9_HEIGHT SCREEN_WIDTH * 16.0 / 9.0

#pragma mark - 以iPhone6和iPad 2为基准的单位宽度和高度

#define UNIT_WIDTH (IS_IPAD ? SCREEN_WIDTH / 768.0 : SCREEN_WIDTH / 375.0)
#define UNIT_HEIGHT (IS_IPAD ? SCREEN_HEIGHT / 1024.0 : (IS_IPHONEX_SERIES ? (SCREEN16_9_HEIGHT / 667.0) : SCREEN_HEIGHT / 667.0))

#pragma mark - 影响布局的UI控件高度

#define STATUSBAR_HEIGHT [[UIApplication sharedApplication] statusBarFrame].size.height
#define TABBAR_HEIGHT (IS_IPHONEX_SERIES ? 83 : 49)
#define TOP_INSETS (IS_IPHONEX_SERIES ? 88 : 64)
#define BOTTOM_INSETS (IS_IPHONEX_SERIES ? 34 : 0)

#pragma mark - 单位字体

#define UNIT_FONT(num) [UIFont systemFontOfSize:num * UNIT_HEIGHT]

#endif /* FrameLayout_h */
