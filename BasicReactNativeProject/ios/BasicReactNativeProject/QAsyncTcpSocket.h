//
//  QAsyncTcpSocket.h
//  MyTools
//
//  Created by xingye.yang  qq:939607134 on 2021/4/30.
//

#import <Foundation/Foundation.h>
#import "GCDAsyncSocket.h"
NS_ASSUME_NONNULL_BEGIN

@class QAsyncTcpSocket;

typedef NS_ENUM(NSUInteger, AsynTcpSocketState)
{
    success,
    initFailure,
    disconnect,
};

@protocol QAsynTcpSocketDelegate <NSObject>

//data是经过沾包/断包处理后的一个完整的包，
-(void)socket:(QAsyncTcpSocket *)socket didReadData:(NSData *)data;

-(void)socket:(QAsyncTcpSocket *)socket connectState:(AsynTcpSocketState)state;

@end


@interface QAsyncTcpSocket : NSObject

@property(nonatomic,weak)id <QAsynTcpSocketDelegate> delegate;

+(QAsyncTcpSocket *)connectToHost:(NSString *)host withPort:(int)port;

@property(nonatomic,copy)NSString *host;
@property(nonatomic,assign)int port;

-(void)disconnectSocket;

-(void)writeData:(NSData *)data;

@end

NS_ASSUME_NONNULL_END
