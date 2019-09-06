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
@property (nonatomic, copy, readonly) NSString* _Nullable urlEncodedString;

/// 经过URL解码的字符串
@property (nonatomic, copy, readonly) NSString* _Nullable urlDecodedString;

/// 经过base64编码的字符串
@property (nonatomic, copy, readonly) NSString* _Nullable base64EncodedString;

/// base64解码之后的字符串
@property (nonatomic, copy, readonly) NSString* _Nullable base64DecodedString;

/// 字符串对应的NSURL对象
@property (nonatomic, strong, readonly) NSURL* _Nullable url;

/// 字符串对应的MD5加密后的字符串
@property (nonatomic, copy, readonly) NSString* _Nullable md5String;
    
#pragma mark - Util

/**
 NSString 专用的判断字符串是否为空的方法
 
 @param string 字符串对象
 @return 是否为空的结果
 */
+ (BOOL)isEmptyString:(id)string;

/**
 获取新的UUID的方法
 
 @return 新的UUID
 */
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
    
- (NSString * _Nullable)URLEncode;
    
- (NSString * _Nullable)URLDecode;

- (NSString * _Nullable)base64Encode;

- (NSString * _Nullable)base64Decode;
    
#pragma mark - URL
    
- (NSURL * _Nullable)urlForItself;
    
#pragma mark - JSON
    
- (id _Nullable)deserializeJSONString;
    
#pragma mark - Encrypt

- (NSString * _Nullable)md5Encrpt;
    
#pragma mark - RegExp
    
- (BOOL)isPhone;

#pragma mark - Date

- (NSDate * _Nullable)dateFromString;

- (NSDate * _Nullable)dateStringWithFormatter:(NSDateFormatter *)formatter;

@end

NS_ASSUME_NONNULL_END
