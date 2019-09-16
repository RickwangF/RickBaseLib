//
//  UIImage+Tool.m
//  StringDemo
//
//  Created by Rick on 2019/9/10.
//  Copyright © 2019 Rick. All rights reserved.
//

#import "UIImage+Tool.h"
#import "NSString+Tool.h"

@implementation UIImage (Tool)

#pragma mark - UIColor

+ (instancetype _Nullable)imageWithUIColor:(UIColor *)color{
    
    CGRect rect = CGRectMake(0, 0, 1, 1);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef contextRef = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(contextRef, [color CGColor]);
    CGContextFillRect(contextRef, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
    
}

+ (instancetype _Nullable)imageWithName:(NSString *)name Bundle:(NSString * _Nullable)bundle{
    if ([NSString isEmptyString:name]) {
        return nil;
    }
    
    UIImage *image;
    if ([NSString isEmptyString:bundle]) {
        image = [UIImage imageNamed:name];
    }
    else {
        NSString *bundlePath = [NSBundle.mainBundle pathForResource:bundle ofType:@"bundle"];
        NSString *path = [NSString stringWithFormat:@"%@/%@/%@@2x.png", bundlePath, name, name];
        image = [UIImage imageWithContentsOfFile:path];
    }
    
    return image;
}

#pragma mark - Scale

- (UIImage * _Nullable)scaleToSize:(CGSize)size{
    if (CGSizeEqualToSize(size, CGSizeZero)) {
        return nil;
    }
    
    if (size.width == 0 || size.height == 0) {
        return nil;
    }
    
    UIGraphicsBeginImageContext(size);
    UIGraphicsBeginImageContextWithOptions(size, NO, self.scale);
    [self drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

#pragma mark - Mask

- (UIImage * _Nullable)maskWithImage:(UIImage *)image{
    CGContextRef context;
    CGColorSpaceRef colorSpace;
    colorSpace = CGColorSpaceCreateDeviceRGB();
    context = CGBitmapContextCreate(NULL, self.size.width, self.size.height, 8, 0, colorSpace, (CGBitmapInfo)kCGImageAlphaPremultipliedLast);
    CGColorSpaceRelease(colorSpace);
    
    if (context == NULL) {
        return NULL;
    }
    
    CGContextClipToMask(context, CGRectMake(0, 0, self.size.width, self.size.height), image.CGImage);
    CGContextDrawImage(context, CGRectMake(0, 0, self.size.width, self.size.height), self.CGImage);
    CGImageRef bitmapContext = CGBitmapContextCreateImage(context);
    CGContextRelease(context);
    UIImage *returnImage = [UIImage imageWithCGImage:bitmapContext];
    CGImageRelease(bitmapContext);
    
    return returnImage;
}



@end
