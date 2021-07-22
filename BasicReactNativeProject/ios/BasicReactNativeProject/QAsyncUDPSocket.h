//
//  QAsyncUDPSocket.h
//  MyTools
//
//  Created by xingye.yang  qq:939607134 on 2021/4/30.
//

#import <Foundation/Foundation.h>
#import "GCDAsyncUdpSocket.h"

@class QAsyncUDPSocket;

NS_ASSUME_NONNULL_BEGIN

@protocol QAsyncUDPSocketDelegate <NSObject>

@optional

//data是经过沾包/断包处理后的一个完整的包，
-(void)udpSocket:(QAsyncUDPSocket *)udpSocket didReadData:(NSData *)data;

//绑定结果
-(void)bindPortState:(BOOL)isSuccess;

-(void)udpConnectionState:(NSDictionary*)state;

-(void)udpSendDataState:(BOOL)state;

@end

@interface QAsyncUDPSocket : NSObject

- (instancetype)initWithDelegate:(id<QAsyncUDPSocketDelegate>)delegate;

@property(nonatomic,weak)id<QAsyncUDPSocketDelegate>delegate;

-(void)bindToPort:(int)port;

-(void)writeDate:(NSData *)data;

-(void)writeDate:(NSData*)data host:(NSString*)host port:(int)port;

-(void)closeUDP;

@end

NS_ASSUME_NONNULL_END
