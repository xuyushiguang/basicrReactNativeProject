//
//  StringConverter.m
//  MyTools
//
//  Created by xingye.yang  qq:939607134 on 2021/4/28.
//

#import "StringConverter.h"

@implementation StringConverter

//16进制字符串转int，例如格式：0xFF,0xF,FF,0xFFEEDD,0xFFE,
+(NSInteger)hexString2Int:(NSString *)hex
{
    return strtoul([hex UTF8String], 0, 16);
}

//int转16进制字符串，输入0xffddc，输出@"ffddc"
+ (NSString *)int2HexString:(int)value
{
      NSString *nLetterValue;
      NSString *hexStr =@"";
      int64_t ttmpig;
      for (int i = 0; i<9; i++) {
          ttmpig=value%16;
          value=value/16;
         switch (ttmpig)
         {
             case 10:
                 nLetterValue =@"A";break;
             case 11:
                 nLetterValue =@"B";break;
             case 12:
                 nLetterValue =@"C";break;
             case 13:
                 nLetterValue =@"D";break;
             case 14:
                 nLetterValue =@"E";break;
             case 15:
                 nLetterValue =@"F";break;
             default:nLetterValue=[[NSString alloc]initWithFormat:@"%llx",ttmpig];

         }
          hexStr = [nLetterValue stringByAppendingString:hexStr];
          if (value == 0) break;
     }
     return hexStr;
 }

+ (NSData *)hexStringToData:(NSString *)str
{
    if (!str || [str length] == 0) {
        return nil;
    }
    
    NSMutableData *hexData = [NSMutableData data];
    NSRange range;
    if ([str length] % 2 == 0) {
        range = NSMakeRange(0, 2);
    } else {
        range = NSMakeRange(0, 1);
    }
    for (NSInteger i = range.location; i < [str length]; i += 2) {
        unsigned int anInt;
        NSString *hexCharStr = [str substringWithRange:range];
        NSScanner *scanner = [[NSScanner alloc] initWithString:hexCharStr];
        
        [scanner scanHexInt:&anInt];
        NSData *entity = [[NSData alloc] initWithBytes:&anInt length:1];
        [hexData appendData:entity];
        
        range.location += range.length;
        range.length = 2;
    }
    return hexData;
}

+ (NSString *)dataToHexString:(NSData *)data
{
    if (!data || [data length] == 0) {
        return @"";
    }
    NSMutableString *string = [[NSMutableString alloc] initWithCapacity:[data length]];
    
    [data enumerateByteRangesUsingBlock:^(const void *bytes, NSRange byteRange, BOOL *stop) {
        unsigned char *dataBytes = (unsigned char*)bytes;
        for (NSInteger i = 0; i < byteRange.length; i++) {
            NSString *hexStr = [NSString stringWithFormat:@"%x", (dataBytes[i]) & 0xff];
            if ([hexStr length] == 2) {
                [string appendString:hexStr];
            } else {
                [string appendFormat:@"0%@", hexStr];
            }
        }
    }];
    return string;
}


@end
