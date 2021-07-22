//
//  ByteConverter.m
//  MyTools
//
//  Created by xingye.yang  qq:939607134 on 2021/4/27.
//

#import "ByteConverter.h"

@implementation ByteConverter


//低位在前,高位在后
+(NSData*)int2Bytes:(int)value
{
    char buffer[4] = {0};
    buffer[0] = value       & 0xFF;
    buffer[1] = value >> 8  & 0xFF;
    buffer[2] = value >> 16 & 0xFF;
    buffer[3] = value >> 24 & 0xFF;
    return [NSData dataWithBytes:buffer length:4];
}

//低位在前,高位在后
+(NSData*)short2Bytes:(short)value
{
    char buffer[2] = {0};
    buffer[0] = value       & 0xFF;
    buffer[1] = value >> 8  & 0xFF;
    return [NSData dataWithBytes:buffer length:2];
}

//低位在前,高位在后
+(NSData*)int_64ToBytes:(int64_t)value
{
    char buffer[8] = {0};
    buffer[0] = value       & 0xFF;
    buffer[1] = value >> 8  & 0xFF;
    buffer[2] = value >> 16  & 0xFF;
    buffer[3] = value >> 24  & 0xFF;
    buffer[4] = value >> 32  & 0xFF;
    buffer[5] = value >> 40  & 0xFF;
    buffer[6] = value >> 48  & 0xFF;
    buffer[7] = value >> 56  & 0xFF;
    return [NSData dataWithBytes:buffer length:8];
}

//低位在前,高位在后
+(NSData*)float2Bytes:(float)value
{
    char buffer[4] = {0};
    memcpy(buffer, &value, sizeof(buffer));
    return [NSData dataWithBytes:buffer length:4];
}

//低位在前,高位在后
+(int)bytes2int:(char*)buffer offset:(NSUInteger)offset
{
    int res = 0;
    res |= buffer[offset];
    res |= buffer[offset + 1] << 8;
    res |= buffer[offset + 2] << 16;
    res |= buffer[offset + 3] << 24;
    return res;
}

//低位在前,高位在后
+(short)bytes2Short:(char*)buffer offset:(NSUInteger)offset
{
    short res = 0;
    res |= buffer[offset];
    res |= buffer[offset + 1] << 8;
    return res;
}

//低位在前,高位在后
+(int64_t)bytes2Int_64:(char*)buffer offset:(NSUInteger)offset
{
    int64_t res = 0;
    NSData *data = [NSData dataWithBytes:buffer + offset length:8];
    [data getBytes:&res length:sizeof(res)];
    return res;
}

//低位在前,高位在后
+(float)bytes2Float:(char*)buffer offset:(NSUInteger)offset
{
    char buf1[4] = {0};
    buf1[0] = buffer[offset];
    buf1[1] = buffer[offset + 1];
    buf1[2] = buffer[offset + 2];
    buf1[3] = buffer[offset + 3];
    float *res = (float*)(&buf1);
    return *res;
}

//高位在前,低位在后
+(NSData*)int2BytesBig:(int)value
{
    char buffer[4] = {0};
    buffer[3] = value       & 0xFF;
    buffer[2] = value >> 8  & 0xFF;
    buffer[1] = value >> 16 & 0xFF;
    buffer[0] = value >> 24 & 0xFF;
    return [NSData dataWithBytes:buffer length:4];
}

//高位在前,低位在后
+(NSData*)short2BytesBig:(short)value
{
    char buffer[2] = {0};
    buffer[1] = value       & 0xFF;
    buffer[0] = value >> 8  & 0xFF;
    return [NSData dataWithBytes:buffer length:2];
}

//高位在前,低位在后
+(NSData*)int_64ToBytesBig:(int64_t)value
{
    char buffer[8] = {0};
    buffer[7] = value        & 0xFF;
    buffer[6] = value >> 8   & 0xFF;
    buffer[5] = value >> 16  & 0xFF;
    buffer[4] = value >> 24  & 0xFF;
    buffer[3] = value >> 32  & 0xFF;
    buffer[2] = value >> 40  & 0xFF;
    buffer[1] = value >> 48  & 0xFF;
    buffer[0] = value >> 56  & 0xFF;
    return [NSData dataWithBytes:buffer length:8];
}

//高位在前,低位在后
+(NSData*)float2BytesBig:(float)value
{
    char buffer[4] = {0};
    memcpy(buffer, &value, sizeof(buffer));
    char bigBuffer[4] = {0};
    bigBuffer[0] = buffer[3];
    bigBuffer[1] = buffer[2];
    bigBuffer[2] = buffer[1];
    bigBuffer[3] = buffer[0];
    return [NSData dataWithBytes:bigBuffer length:4];
}

//高位在前,低位在后
+(int)bytes2intBig:(char*)buffer offset:(NSUInteger)offset
{
    int res = 0;
    res |= buffer[offset + 3];
    res |= buffer[offset + 2] << 8;
    res |= buffer[offset + 1] << 16;
    res |= buffer[offset]     << 24;
    return res;
}

//高位在前,低位在后
+(short)bytes2ShortBig:(char*)buffer offset:(NSUInteger)offset
{
    short res = 0;
    res |= buffer[offset + 1];
    res |= buffer[offset]     << 8;
    return res;
}

//高位在前,低位在后
+(int64_t)bytes2Int_64Big:(char*)buffer offset:(NSUInteger)offset
{
    int64_t res = 0;
    NSData *data = [NSData dataWithBytes:buffer + offset length:8];
    [data getBytes:&res length:sizeof(res)];
    return res;
}

//高位在前,低位在后
+(float)bytes2FloatBig:(char*)buffer offset:(NSUInteger)offset
{
    char buf1[4] = {0};
    buf1[0] = buffer[offset];
    buf1[1] = buffer[offset + 1];
    buf1[2] = buffer[offset + 2];
    buf1[3] = buffer[offset + 3];
    char bigBuf[4] = {0};
    bigBuf[0] = buf1[3];
    bigBuf[1] = buf1[2];
    bigBuf[2] = buf1[1];
    bigBuf[3] = buf1[0];
    float *res = (float*)(&bigBuf);
    return *res;
}


@end
