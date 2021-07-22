//
//  AckModelManager.h
//  MyTools
//
//  Created by xingye.yang  qq:939607134 on 2021/4/28.
//

#import <Foundation/Foundation.h>
#import "CommonFunc.h"
#import "AckModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface AckModelManager : NSObject

+(instancetype)shareInstance;

-(void)addAckModel:(AckModel *)ack;

-(AckModel *)popAckModel:(int)key;

-(void)deleteAckModel:(int)key;

@end

NS_ASSUME_NONNULL_END
