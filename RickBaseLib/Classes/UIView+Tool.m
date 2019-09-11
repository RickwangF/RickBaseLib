//
//  UIView+Tool.m
//  StringDemo
//
//  Created by Rick on 2019/9/6.
//  Copyright © 2019 Rick. All rights reserved.
//

#import "UIView+Tool.h"

@implementation UIView (Tool)

#pragma mark - Property

- (CGFloat)x{
    return CGRectGetMinX(self.frame);
}

- (void)setX:(CGFloat)x{
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (CGFloat)y{
    return CGRectGetMinY(self.frame);
}

- (void)setY:(CGFloat)y{
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (CGFloat)maxX{
    return CGRectGetMaxX(self.frame);
}

- (void)setMaxX:(CGFloat)maxX{
    CGRect frame = CGRectMake(maxX-self.width, self.y, self.width, self.height);
    self.frame = frame;
}

- (CGFloat)maxY{
    return CGRectGetMaxY(self.frame);
}

- (void)setMaxY:(CGFloat)maxY{
    CGRect frame = CGRectMake(self.x, maxY-self.height, self.width, self.height);
    self.frame = frame;
}

- (CGFloat)centerX{
    return CGRectGetMidX(self.frame);
}

- (void)setCenterX:(CGFloat)centerX{
    self.center = CGPointMake(centerX, self.centerY);
}

- (CGFloat)centerY{
    return CGRectGetMidY(self.frame);
}

- (void)setCenterY:(CGFloat)centerY{
    self.center = CGPointMake(self.centerX, centerY);
}

- (CGFloat)width{
    return self.frame.size.width;
}

- (void)setWidth:(CGFloat)width{
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (CGFloat)height{
    return self.frame.size.height;
}

- (void)setHeight:(CGFloat)height{
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

#pragma mark - Common

- (void)addViewToTopControllerView{
    UIView *view = [self controllerView];
    if (view != nil) {
        [view addSubview:self];
    }
}

- (UIView * _Nullable)controllerView {
    UIViewController *controller;
    
    controller = UIApplication.sharedApplication.keyWindow.rootViewController;
    if (controller == nil) {
        return nil;
    }
    
    if ([controller isKindOfClass:UITabBarController.class]) {
        controller = [(UITabBarController*)controller selectedViewController];
        
        if (controller.childViewControllers.count > 0) {
            
            UIViewController *subViewController = controller.childViewControllers.lastObject;
            if (subViewController != nil) {
                
                controller = subViewController;
                if (controller.presentedViewController != nil) {
                    while (controller.presentedViewController && ![controller isKindOfClass:UIAlertController.class]) {
                        controller = controller.presentedViewController;
                    }
                }
            }
        }
    }
    else if ([controller isKindOfClass:UINavigationController.class]){
        if (controller.childViewControllers.count > 0) {
            
            UIViewController *subViewController = controller.childViewControllers.lastObject;
            if (subViewController != nil) {
                
                controller = subViewController;
                if (controller.presentedViewController != nil) {
                    while (controller.presentedViewController && ![controller isKindOfClass:UIAlertController.class]) {
                        controller = controller.presentedViewController;
                    }
                }
            }
        }
    }
    else {
        if (controller.presentedViewController != nil) {
            while (controller.presentedViewController && ![controller isKindOfClass:UIAlertController.class]) {
                controller = controller.presentedViewController;
            }
        }
    }
    
    return controller.view;
}

- (void)addViewToWindow{
    [UIApplication.sharedApplication.keyWindow addSubview:self];
}

#pragma mark - Corner Radius

- (void)addCornerRadius:(CGFloat)cornerRadius{
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:cornerRadius];
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    [maskLayer setPath:path.CGPath];
    self.layer.mask = maskLayer;
}

- (void)addCornerRadius:(CGFloat)cornerRadius WithCorners:(UIRectCorner)corners{
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:corners cornerRadii:CGSizeMake(cornerRadius, cornerRadius)];
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    [maskLayer setPath:path.CGPath];
    self.layer.mask = maskLayer;
}

#pragma mark - SnapShot

- (UIImage * _Nullable)snapShot{
    UIGraphicsBeginImageContextWithOptions(self.bounds.size, NO, UIScreen.mainScreen.scale);
    
    [self drawViewHierarchyInRect:self.bounds afterScreenUpdates:YES];
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    NSData *imageData = UIImagePNGRepresentation(image);
    image = [UIImage imageWithData:imageData];
    
    return image;
}

@end
