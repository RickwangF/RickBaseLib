//
//  UIColor+Tool.h
//  StringDemo
//
//  Created by Rick on 2019/9/6.
//  Copyright © 2019 Rick. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIColor (Tool)

#pragma mark - Hex

+ (UIColor *)colorWithHex:(NSString *)hexString;

#pragma mark - Common

+ (UIColor *)randomColor;

@end

NS_ASSUME_NONNULL_END
