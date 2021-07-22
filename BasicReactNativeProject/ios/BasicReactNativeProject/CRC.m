//
//  XOR.m
//  MyTools
//
//  Created by xingye.yang  qq:939607134 on 2021/4/28.
//

#import "CRC.h"


unsigned char xor_calculation(char *byte,unsigned int offset){
    unsigned char xor = 0;
    for (int i = 0; i<offset; i++) {
        if(i == 0){
            xor = *byte;
        }else{
            xor = xor ^ *(byte + i);
        }
    }
    return xor;
}

unsigned char sum_calculation(char *byte,unsigned int offset){
    unsigned char xor = 0;
    for (int i = 0; i<offset; i++) {
        if(i == 0){
            xor = *byte;
        }else{
            xor = xor + *(byte + i);
        }
    }
    return xor;
}

@implementation CRC

+(unsigned char)crc:(char*)byte offset:(unsigned int)offset
{
    return xor_calculation(byte, offset);
}

+(unsigned char)crcSum:(char*)byte offset:(unsigned int)offset
{
    return sum_calculation(byte, offset);
}

@end
