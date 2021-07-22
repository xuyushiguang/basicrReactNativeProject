//
//  StringConverter.h
//  MyTools
//
//  Created by xingye.yang  qq:939607134 on 2021/4/28.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface StringConverter : NSObject

//16进制字符串转int，例如格式：0xFF,0xF,FF,0xFFEEDD,0xFFE,
+(NSInteger)hexString2Int:(NSString *)hex;

//int转16进制字符串，输入0xffddc，输出@"ffddc"
+ (NSString *)int2HexString:(int)value;

+(NSData *)hexStringToData:(NSString *)str;

+(NSString *)dataToHexString:(NSData *)data;

@end

NS_ASSUME_NONNULL_END
