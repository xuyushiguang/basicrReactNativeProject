//
//  ByteConverter.h
//  MyTools
//
//  Created by xingye.yang  qq:939607134 on 2021/4/27.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ByteConverter : NSObject

//**************低位在前,高位在后***************

//低位在前,高位在后
+(NSData*)int2Bytes:(int)value;

//低位在前,高位在后
+(NSData*)short2Bytes:(short)value;

//低位在前,高位在后
+(NSData*)int_64ToBytes:(int64_t)value;

//低位在前,高位在后
+(NSData*)float2Bytes:(float)value;

//低位在前,高位在后
+(int)bytes2int:(char*)buffer offset:(NSUInteger)offset;

//低位在前,高位在后
+(short)bytes2Short:(char*)buffer offset:(NSUInteger)offset;

//低位在前,高位在后
+(int64_t)bytes2Int_64:(char*)buffer offset:(NSUInteger)offset;

//低位在前,高位在后
+(float)bytes2Float:(char*)buffer offset:(NSUInteger)offset;

//**************高位在前,低位在后***************

//高位在前,低位在后
+(NSData*)int2BytesBig:(int)value;

//高位在前,低位在后
+(NSData*)short2BytesBig:(short)value;

//高位在前,低位在后
+(NSData*)int_64ToBytesBig:(int64_t)value;

//高位在前,低位在后
+(NSData*)float2BytesBig:(float)value;

//高位在前,低位在后
+(int)bytes2intBig:(char*)buffer offset:(NSUInteger)offset;

//高位在前,低位在后
+(short)bytes2ShortBig:(char*)buffer offset:(NSUInteger)offset;

//高位在前,低位在后
+(int64_t)bytes2Int_64Big:(char*)buffer offset:(NSUInteger)offset;

//高位在前,低位在后
+(float)bytes2FloatBig:(char*)buffer offset:(NSUInteger)offset;




@end

NS_ASSUME_NONNULL_END
