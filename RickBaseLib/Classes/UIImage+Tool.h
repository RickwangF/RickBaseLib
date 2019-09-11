//
//  UIImage+Tool.h
//  StringDemo
//
//  Created by Rick on 2019/9/10.
//  Copyright © 2019 Rick. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (Tool)

#pragma mark - UIColor

+ (instancetype _Nullable)imageWithUIColor:(UIColor *)color;

+ (instancetype _Nullable)imageWithName:(NSString *)name Bundle:(NSString * _Nullable)bundle;

#pragma mark - Scale

- (UIImage * _Nullable)scaleToSize:(CGSize)size;

#pragma mark - Mask

- (UIImage * _Nullable)maskWithImage:(UIImage *)image;

@end

NS_ASSUME_NONNULL_END
