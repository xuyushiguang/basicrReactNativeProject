//
//  XOR.h
//  MyTools
//
//  Created by xingye.yang  qq:939607134 on 2021/4/28.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN




@interface CRC : NSObject

+(unsigned char)crc:(char*)byte offset:(unsigned int)offset;

+(unsigned char)crcSum:(char*)byte offset:(unsigned int)offset;

@end

NS_ASSUME_NONNULL_END
