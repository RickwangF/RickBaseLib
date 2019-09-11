//
//  UIView+Tool.h
//  StringDemo
//
//  Created by Rick on 2019/9/6.
//  Copyright © 2019 Rick. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (Tool)

#pragma mark - Property

@property (nonatomic, assign) CGFloat x;

@property (nonatomic, assign) CGFloat y;

@property (nonatomic, assign) CGFloat maxX;

@property (nonatomic, assign) CGFloat maxY;

@property (nonatomic, assign) CGFloat centerX;

@property (nonatomic, assign) CGFloat centerY;

@property (nonatomic, assign) CGFloat width;

@property (nonatomic, assign) CGFloat height;

#pragma mark - Common

- (void)addViewToTopControllerView;

- (void)addViewToWindow;

#pragma mark - Corner Radius

- (void)addCornerRadius:(CGFloat)cornerRadius;

- (void)addCornerRadius:(CGFloat)cornerRadius WithCorners:(UIRectCorner)corners;

#pragma mark - SnapShot

- (UIImage * _Nullable)snapShot;

@end

NS_ASSUME_NONNULL_END
