//
//  NSString+Tool.m
//  BaseLib
//
//  Created by Rick on 2019/8/31.
//  Copyright © 2019 Rick. All rights reserved.
//

#import "NSString+Tool.h"
#import <CommonCrypto/CommonCrypto.h>

@implementation NSString (Tool)
    
#pragma mark - Util

+ (BOOL)isEmptyString:(id)string{
    if (string == nil || string == [NSNull null] || ![string isKindOfClass:NSString.class]) {
        return YES;
    }
    
    NSString *strongIns = (NSString *)string;
    if ([strongIns isEqualToString:@""] || strongIns.trimmedString.length == 0) {
        return YES;
    }
    
    return NO;
}
    
+ (instancetype)newUUID{
    CFUUIDRef uuid = CFUUIDCreate(NULL);
    CFStringRef cString = CFUUIDCreateString(NULL, uuid);
    CFRelease(uuid);
    return (__bridge_transfer NSString*)cString;
}
    
#pragma mark - Size
    
- (CGSize)sizeWithFont:(UIFont *)font
              MaxWidth:(CGFloat)maxWidth
         ParagrahStyle:(NSParagraphStyle * __nullable)style{
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:self];
    if (style == nil || ![style isKindOfClass:NSParagraphStyle.class]) {
        NSMutableParagraphStyle *mutableStyle = [[NSMutableParagraphStyle alloc] init];
        mutableStyle.lineSpacing = 2;
        mutableStyle.headIndent = 0;
        mutableStyle.tailIndent = 0;
        mutableStyle.lineBreakMode = NSLineBreakByWordWrapping;
        [attributedString addAttribute:NSParagraphStyleAttributeName value:mutableStyle range:NSMakeRange(0, attributedString.length)];
    }
    else {
        [attributedString addAttribute:NSParagraphStyleAttributeName value:style range:NSMakeRange(0, attributedString.length)];
    }
    [attributedString addAttribute:NSFontAttributeName value:font range:NSMakeRange(0, attributedString.length)];
    NSStringDrawingOptions options = NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading;
    CGRect rect = [attributedString boundingRectWithSize:CGSizeMake(maxWidth, MAXFLOAT) options:options context:nil];
    
    return rect.size;
}
    
- (CGSize)sizeWithFont:(UIFont *)font
              MaxWidth:(CGFloat)maxWidth
           LineSpacing:(CGFloat)lineSpacing
            headIndent:(CGFloat)headIndent
            tailIndent:(CGFloat)tailIndent{
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:self];
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    style.lineSpacing = lineSpacing;
    style.headIndent = headIndent;
    style.tailIndent = tailIndent;
    style.lineBreakMode = NSLineBreakByWordWrapping;
    [attributedString addAttribute:NSParagraphStyleAttributeName value:style range:NSMakeRange(0, attributedString.length)];
    [attributedString addAttribute:NSFontAttributeName value:font range:NSMakeRange(0, attributedString.length)];
    NSStringDrawingOptions options = NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading;
    CGRect rect = [attributedString boundingRectWithSize:CGSizeMake(maxWidth, MAXFLOAT) options:options context:nil];
    
    return rect.size;
}
    
- (CGFloat)heigthForFont:(UIFont *)font Width:(CGFloat)width{
    return [self sizeWithFont:font MaxWidth:width LineSpacing:0 headIndent:0 tailIndent:0].height;
}
    
- (CGFloat)widthForFont:(UIFont *)font{
    return [self sizeWithFont:font MaxWidth:MAXFLOAT LineSpacing:0 headIndent:0 tailIndent:0].width;
}
    
#pragma mark - Trim
    
- (NSString*)trim{
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}
    
- (NSString *)trimmedString{
    return [self trim];
}
    
#pragma mark - Encode
    
- (NSString * _Nullable)URLEncode{
    static NSString * const kAFCharactersGeneralDelimitersToEncode = @":#[]@"; // does not include "?" or "/" due to RFC 3986 - Section 3.4
    static NSString * const kAFCharactersSubDelimitersToEncode = @"!$&'()*+,;=";
    
    NSMutableCharacterSet * allowedCharacterSet = [[NSCharacterSet URLQueryAllowedCharacterSet] mutableCopy];
    [allowedCharacterSet removeCharactersInString:[kAFCharactersGeneralDelimitersToEncode stringByAppendingString:kAFCharactersSubDelimitersToEncode]];
    static NSUInteger const batchSize = 50;
    
    NSUInteger index = 0;
    NSMutableString *escaped = @"".mutableCopy;
    
    while (index < self.length) {
        NSUInteger length = MIN(self.length - index, batchSize);
        NSRange range = NSMakeRange(index, length);
        // To avoid breaking up character sequences such as 👴🏻👮🏽
        range = [self rangeOfComposedCharacterSequencesForRange:range];
        NSString *substring = [self substringWithRange:range];
        NSString *encoded = [substring stringByAddingPercentEncodingWithAllowedCharacters:allowedCharacterSet];
        [escaped appendString:encoded];
        
        index += range.length;
    }
    return [escaped copy];
}
    
- (NSString * _Nullable)urlEncodedString{
    return [self URLEncode];
}
    
- (NSString * _Nullable)URLDecode{
    return [self stringByRemovingPercentEncoding];
}
    
- (NSString * _Nullable)urlDecodedString{
    return [self URLDecode];
}

- (NSString * _Nullable)base64Encode{
    NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding];
    NSString *string = [data base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    return string;
}

- (NSString * _Nullable)base64EncodedString{
    return [self base64Encode];
}

- (NSString * _Nullable)base64Decode{
    NSData *data = [[NSData alloc] initWithBase64EncodedString:self options:NSDataBase64DecodingIgnoreUnknownCharacters];
    NSString *string = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    return string;
}

- (NSString * _Nullable)base64DecodedString{
    return [self base64Decode];
}
    
#pragma mark - URL
    
- (NSURL * _Nullable)urlForItself{
    return [NSURL URLWithString:self];
}
    
- (NSURL * _Nullable)url{
    return [self urlForItself];
}
    
#pragma mark - JSON
    
- (id _Nullable)deserializeJSONString{
    NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding];
    return [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
}
    
#pragma mark - Encrypt

- (NSString * _Nullable)md5Encrpt{
    if ([NSString isEmptyString:self]) {
        return nil;
    }
    
    unsigned char digest[CC_MD5_DIGEST_LENGTH], i;
    CC_MD5([self UTF8String], (int)[self lengthOfBytesUsingEncoding:NSUTF8StringEncoding], digest);
    NSMutableString *ms = [NSMutableString string];
    for (i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
        [ms appendFormat: @"%02x", (int)(digest[i])];
    }
    return [ms copy];
}

- (NSString * _Nullable)md5String{
    return [self md5Encrpt];
}
    
#pragma mark - RegExp

- (BOOL)isPhone{
    NSString *phoneRegex = @"^(1[3-9])\\d{9}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    return [phoneTest evaluateWithObject:self];
}

#pragma mark - Date

- (NSDate * _Nullable)dateFromString{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    NSDate* date = [formatter dateFromString:self];
    return date;
}

- (NSDate * _Nullable)dateStringWithFormatter:(NSDateFormatter *)formatter{
    if (formatter == nil || ![formatter isKindOfClass:NSDateFormatter.class]) {
        return nil;
    }
    
    NSDate *date = [formatter dateFromString:self];
    return date;
}

@end
