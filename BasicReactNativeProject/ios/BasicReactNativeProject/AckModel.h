//
//  AckModel.h
//  MyTools
//
//  Created by xingye.yang  qq:939607134 on 2021/4/28.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface AckModel : NSObject
//R’：读取指令，由上位机发起‘W’：写参数指令，由上位机发起‘S’：为设备发起，上位机无需返回信息
@property(nonatomic,assign)UInt8 cmdType;

//指令
@property(nonatomic,assign)UInt8 cmd;

@property(nonatomic,copy,nullable)id ackBlock;

@property(nonatomic,assign)int timeOut;

@property(nonatomic,assign)int ack;

@end

NS_ASSUME_NONNULL_END
