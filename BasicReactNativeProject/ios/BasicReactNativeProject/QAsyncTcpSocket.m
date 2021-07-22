//
//  QAsyncTcpSocket.m
//  MyTools
//
//  Created by xingye.yang  qq:939607134 on 2021/4/30.
//

#import "QAsyncTcpSocket.h"
#import "CRC.h"

@interface QAsyncTcpSocket ()<GCDAsyncSocketDelegate>
{
    dispatch_queue_t _decod_data_queue;
    GCDAsyncSocket *_asynSocket;
    int _reconnectCount;//重连次数,
  GCDAsyncSocket *_newSocket;
}
//包头
@property(nonatomic,strong)NSData *stx;
//包尾
@property(nonatomic,strong)NSData *etx;

@property(nonatomic,strong)NSMutableData *bufferCache;

@end

@implementation QAsyncTcpSocket

- (instancetype)initWithHost:(NSString *)host withPort:(int)port
{
    self = [super init];
    if (self) {
        NSString *bleStr = [NSString stringWithFormat:@"com.quectel.tcp_decod_data_%p",self];
        _decod_data_queue = dispatch_queue_create([bleStr UTF8String], DISPATCH_QUEUE_SERIAL);
        _host = host.copy;
        _port = port;
        char stxChar[3] = {0xA5,0xAA,0xAC};
        char etxChar[3] = {0xC5,0xCC,0xCA};
        _stx = [NSData dataWithBytes:stxChar length:3];
        _etx = [NSData dataWithBytes:etxChar length:3];
        _bufferCache = [NSMutableData data];
    }
    return self;
}

+(QAsyncTcpSocket *)connectToHost:(NSString *)host withPort:(int)port
{
    QAsyncTcpSocket *socketObj = [[QAsyncTcpSocket alloc] initWithHost:host withPort:port];
    [socketObj connectSocketToHost:host withPort:port];
    return socketObj;
}

-(void)connectSocketToHost:(NSString *)host withPort:(int)port
{
    _asynSocket = [[GCDAsyncSocket alloc] initWithDelegate:self delegateQueue:dispatch_get_main_queue()];
    NSError *error = nil;
    if (![_asynSocket acceptOnPort:12345 error:&error]) {
      NSLog(@"=====acceptOnPort error===%@",error);
    }
//    if(![_asynSocket connectToHost:host onPort:port error:&error]){
//        NSLog(@"[yxy] ==socket connect error=%@",error);
//        if(_delegate && [_delegate respondsToSelector:@selector(socket:connectState:)]){
//            [_delegate socket:self connectState:initFailure];
//        }
//    }
}

-(void)tryConnect
{
//    if (_asynSocket) {
//        NSError *error = nil;
//        if(![_asynSocket connectToHost:self.host onPort:self.port error:&error]){
//            NSLog(@"[yxy] ==socket connect error=%@",error);
//            if(_delegate && [_delegate respondsToSelector:@selector(socket:connectState:)]){
//                [_delegate socket:self connectState:initFailure];
//            }
//        }
//    }
}

-(void)disconnectSocket
{
    if (_asynSocket) {
        [_asynSocket disconnect];
        _asynSocket.delegate = nil;
        _asynSocket = nil;
    }
}

-(void)writeData:(NSData *)data
{
    [_asynSocket writeData:data withTimeout:-1 tag:0];
    [_asynSocket readDataWithTimeout:-1 tag:0];
}

#pragma mark ***socket delegate***
- (void)socket:(GCDAsyncSocket *)sock didAcceptNewSocket:(GCDAsyncSocket *)newSocket
{
  NSLog(@"===didAcceptNewSocket====%@",newSocket);
  _newSocket = newSocket;
  [newSocket readDataWithTimeout:-1 tag:0];
  
}


- (void)socket:(GCDAsyncSocket *)sock didConnectToHost:(NSString *)host port:(uint16_t)port
{
    if(_delegate && [_delegate respondsToSelector:@selector(socket:connectState:)]){
        [_delegate socket:self connectState:success];
    }
    [sock readDataWithTimeout:-1 tag:0];
}

- (void)socketDidDisconnect:(GCDAsyncSocket *)sock withError:(nullable NSError *)err
{
    NSLog(@"[yxy] socket disconnect error=%@",err);
    if(_delegate && [_delegate respondsToSelector:@selector(socket:connectState:)]){
        [_delegate socket:self connectState:disconnect];
    }
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self tryConnect];
    });
}

- (void)socket:(GCDAsyncSocket *)sock didReadData:(NSData *)data withTag:(long)tag
{
  NSString *receiverStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
  NSLog(@"receiverStr====didReadData=====%@",receiverStr);
  [sock readDataWithTimeout:-1 tag:0];
  
  NSString *str = @"GET / HTTP/1.1 \n Host: 127.0.0.1:12345 \n Sec-WebSocket-Version: 13 \n Upgrade: websocket \n Sec-WebSocket-Key: R4g1b2JEEmFkBkYAGGdhPg== \n Connection: Upgrade \n Origin: http://127.0.0.1:12345";
  
  [sock writeData:[str dataUsingEncoding:NSUTF8StringEncoding] withTimeout:-1 tag:0];
  
//    [_asynSocket readDataWithTimeout:-1 tag:0];
//
//    dispatch_sync(_decod_data_queue, ^{
//        [self.bufferCache appendData:data];
//        [self packetSlice:self.bufferCache];
//    });
}

- (void)socket:(GCDAsyncSocket *)sock didWriteDataWithTag:(long)tag
{
    
}

#pragma mark  粘包/断包处理
///粘包/断包处理
-(void)packetSlice:(NSMutableData *)mutiData
{
//    unsigned char *buffer = (unsigned char *)self.payload.bytes;
    while (mutiData.length) {

        NSRange stxRange = [mutiData rangeOfData:self.stx options:0 range:NSMakeRange(0, mutiData.length)];
        //NSLog(@"==11==stxRange===%@",NSStringFromRange(stxRange));
        //找到了包头，
        if(stxRange.length == 3 && stxRange.location < mutiData.length){
           //现在找包尾
            NSUInteger loc = stxRange.location + stxRange.length;
            NSRange etxRange = [mutiData rangeOfData:self.etx options:0 range:NSMakeRange(loc, mutiData.length - loc)];
//            NSLog(@"==22==etxRange===%@",NSStringFromRange(etxRange));
            //找到包尾
            if(etxRange.length == 3 && etxRange.location < mutiData.length){
                //截取payload,得到完整数据包
                NSRange subR = NSMakeRange(stxRange.location, etxRange.location + etxRange.length - stxRange.location);
                NSData *buffer = [mutiData subdataWithRange:subR];
                //NSLog(@"====s===%@",buffer);
                //删除payload中分片完的数据
                [mutiData replaceBytesInRange:NSMakeRange(0, subR.length + subR.location) withBytes:NULL length:0];
                //NSLog(@"====self.payload===%@",self.payload);
                //NSLog(@"====self.payload ll===%ld",self.payload.length);
                //解析完整的包
                [self crcSecurity:buffer];
            }else{
                //没找到包尾，数据不完整，继续接收数据
                NSLog(@"[yxy]====数据不完整===%@",mutiData);
                return;
            }
        }else{
            //没找到包头，判断最后两个字节是否是0xA5,0xAA
            unsigned char *buff = (unsigned char *)mutiData.bytes;
            if(buff[mutiData.length - 2] == 0xA5 && buff[mutiData.length - 1] == 0xAA){
                //有可能是包头前两个字节，清除之前的数据
                [mutiData replaceBytesInRange:NSMakeRange(0, mutiData.length - 2) withBytes:NULL length:0];
                NSLog(@"[yxy]====可能是包头前两个字节===%@",mutiData);
                return;
            }else if(buff[mutiData.length - 1] == 0xA5){
                //最后一个字节可能是包头的第一字节，清除之前的数据
                [mutiData replaceBytesInRange:NSMakeRange(0, mutiData.length - 1) withBytes:NULL length:0];
                NSLog(@"[yxy]====可能是包头的第一字节===%@",mutiData);
                return;
            }else{
                NSLog(@"[yxy]====废数据===%@",mutiData);
                [mutiData replaceBytesInRange:NSMakeRange(0, mutiData.length) withBytes:NULL length:0];
                return;
            }
            
        }
    }
    
}


//crc校验是否正确
-(void)crcSecurity:(NSData *)data
{
    unsigned char *buffer = (unsigned char *)data.bytes;
    //取出原crc
    unsigned char oldCRC = buffer[3];
    //根据数据计算新的crc值和原crc进行比较
    unsigned char newCRC = [CRC crc:(char *)(buffer + 4) offset:(unsigned int)(data.length - 7)];
    if(oldCRC == newCRC){
        //crc校验正确
        dispatch_async(dispatch_get_main_queue(), ^{
            if(self.delegate && [self.delegate respondsToSelector:@selector(socket:didReadData:)]){
                [self.delegate socket:self didReadData:data];
            }
        });
    }else{
        //crc校验错误，数据有问题，抛弃掉
        NSLog(@"crc error");
    }
}


@end
