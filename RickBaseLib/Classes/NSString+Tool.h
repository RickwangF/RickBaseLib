//
//  NSString+Tool.h
//  BaseLib
//
//  Created by Rick on 2019/8/31.
//  Copyright © 2019 Rick. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (Tool)
    
#pragma mark - Property
    
/// 去除字符串前后空格和换行的字符串 \n
@property (nonatomic, copy, readonly) NSString* trimmedString;
    
/// URL编码的字符串
@property (nonatomic, copy, readonly) NSString* urlEncodedString;

/// 经过URL解码的字符串
@property (nonatomic, copy, readonly) NSString* urlDecodedString;

/// 经过base64编码的字符串
@property (nonatomic, copy, readonly) NSString* base64EncodedString;

/// base64解码之后的字符串
@property (nonatomic, copy, readonly) NSString* base64DecodedString;

/// 字符串对应的NSURL对象
@property (nonatomic, strong, readonly) NSURL* url;

/// 字符串对应的MD5加密后的字符串
@property (nonatomic, copy, readonly) NSString* md5String;
    
#pragma mark - Util
    
+ (BOOL)isEmptyString:(id)string;

+ (instancetype)newUUID;
    
#pragma mark - Size
    
- (CGSize)sizeWithFont:(UIFont *)font
              MaxWidth:(CGFloat)maxWidth
         ParagrahStyle:(NSParagraphStyle * __nullable)style;
    
- (CGSize)sizeWithFont:(UIFont *)font
              MaxWidth:(CGFloat)maxWidth
           LineSpacing:(CGFloat)lineSpacing
            headIndent:(CGFloat)headIndent
            tailIndent:(CGFloat)tailIndent;

/**
 计算单行文字的宽度的方法
 
 @param font 字体
 */
- (CGFloat)widthForFont:(UIFont *)font;

/**
 计算给定字体和宽度情况下的文字高度
 
 @param font 字体
 @param width 给定的宽度
 */
- (CGFloat)heigthForFont:(UIFont *)font Width:(CGFloat)width;
    
#pragma mark - Trim
    
- (NSString *)trim;
    
#pragma mark - Encode
    
- (NSString *)URLEncode;
    
- (NSString *)URLDecode;

- (NSString *)base64Encode;

- (NSString *)base64Decode;
    
#pragma mark - URL
    
- (NSURL *)urlForItself;
    
#pragma mark - JSON
    
- (id)deserializeJSONString;
    
#pragma mark - Encrypt

- (NSString *)md5Encrpt;
    
#pragma mark - RegExp
    
- (BOOL)isPhone;

#pragma mark - Date

- (NSDate *)dateFromString;

- (NSDate *)dateStringWithFormatter:(NSDateFormatter *)formatter;

@end

NS_ASSUME_NONNULL_END
