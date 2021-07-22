//
//  QAsyncUDPSocket.m
//  MyTools
//
//  Created by xingye.yang  qq:939607134 on 2021/4/30.
//

#import "QAsyncUDPSocket.h"
#import "CRC.h"
#import "ByteConverter.h"

#import <arpa/inet.h>
#import <fcntl.h>
#import <ifaddrs.h>
#import <netdb.h>
#import <net/if.h>
#import <sys/socket.h>
#import <sys/types.h>

@interface QAsyncUDPSocket ()<GCDAsyncUdpSocketDelegate>
{
  dispatch_queue_t _decod_data_queue;
  GCDAsyncUdpSocket *_udpSocket;
  int _port;
}
//包头
@property(nonatomic,strong)NSData *stx;
//包尾
@property(nonatomic,strong)NSData *etx;

@property(nonatomic,strong)NSMutableData *bufferCache;

@end

@implementation QAsyncUDPSocket


- (instancetype)initWithDelegate:(id<QAsyncUDPSocketDelegate>)delegate
{
    self = [super init];
    if (self) {
        NSString *bleStr = [NSString stringWithFormat:@"com.quectel.udp_decod_data_%p",self];
        _decod_data_queue = dispatch_queue_create([bleStr UTF8String], DISPATCH_QUEUE_SERIAL);
        _delegate = delegate;
        char stxChar[2] = {0xAA,0xAA};
        char etxChar[3] = {0xC5,0xCC,0xCA};
        _stx = [NSData dataWithBytes:stxChar length:3];
        _etx = [NSData dataWithBytes:etxChar length:3];
        _bufferCache = [NSMutableData data];
        
    }
    return self;
}

-(void)bindToPort:(int)port
{
  _port = port;
  _udpSocket = [[GCDAsyncUdpSocket alloc] initWithDelegate:self delegateQueue:dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)];
  
  NSError *error = nil;
  if (![_udpSocket bindToPort:port error:&error]) {
      NSLog(@"[yxy] udp bind port error=%@",error);
      if(_delegate && [_delegate respondsToSelector:@selector(bindPortState:)]){
          [_delegate bindPortState:NO];
      }
      return;
  }
  
  NSError *err2 = nil;
  if (![_udpSocket enableBroadcast:YES error:&err2]) {
    NSLog(@"[yxy] udp enableBroadcast error=%@",err2);
    if(_delegate && [_delegate respondsToSelector:@selector(bindPortState:)]){
        [_delegate bindPortState:NO];
    }
    return;
  }
  
  NSError *err = nil;
  if (![_udpSocket beginReceiving:&err]) {
      NSLog(@"[yxy] udp receive error=%@",err);
      if(_delegate && [_delegate respondsToSelector:@selector(bindPortState:)]){
          [_delegate bindPortState:NO];
      }
      return;
  }
  if(_delegate && [_delegate respondsToSelector:@selector(bindPortState:)]){
      [_delegate bindPortState:YES];
  }
}

//对数据进行处理,防止数据内容包含包头数据
//如果在js中处理过了,这里就不用再处理了.
-(NSData *)garbleData:(NSData*)data
{
    NSMutableData *mData = [NSMutableData dataWithData:data];
    NSUInteger count = 2;
    unsigned char a[2] = {0,0};
    while (count < mData.length - 1) {
        a[0] = 0;
        a[1] = 0;
        NSRange range = NSMakeRange(count, 2);
        [mData getBytes:a range:range];
        if ((a[0] == 0xAA && a[1] == 0x55) || (a[0] == 0xAA && a[1] == 0xAA)) {
            a[0] = 0xAA;
            a[1] = 0x55;
            [mData replaceBytesInRange:NSMakeRange(count, 1) withBytes:a length:2];
        }
        count ++;
    }
    return mData;
}

-(void)writeDate:(NSData *)data
{
    if (_udpSocket) {
        data = [self garbleData:data];
        [_udpSocket sendData:data withTimeout:-1 tag:0];
    }
}

-(void)writeDate:(NSData*)data host:(NSString*)host port:(int)port
{
  if (_udpSocket) {
//      data = [self garbleData:data];
//      host = [self getBroadcastAddress];
//      NSLog(@"=======ip======%@",host);
      [_udpSocket sendData:data toHost:host port:port withTimeout:-1 tag:0];
  }
}

-(void)closeUDP
{
    if (_udpSocket) {
        [_udpSocket close];
        _udpSocket.delegate = nil;
    }
}

#pragma mark **UDP delegate
- (void)udpSocket:(GCDAsyncUdpSocket *)sock didConnectToAddress:(NSData *)address
{
  NSLog(@"===UdpSocket====didConnectToAddress=======%@",address);
  if (self.delegate && [self.delegate respondsToSelector:@selector(udpConnectionState:)]) {
    [self.delegate udpConnectionState:@{
      @"isConnect":@(1),
      @"port":@(_port),
      @"address":[[NSString alloc] initWithData:address encoding:NSUTF8StringEncoding],
      @"error":@""
    }];
  }
}

- (void)udpSocket:(GCDAsyncUdpSocket *)sock didNotConnect:(NSError * _Nullable)error
{
  NSLog(@"===UdpSocket====didNotConnect=======%@",error);
  if (self.delegate && [self.delegate respondsToSelector:@selector(udpConnectionState:)]) {
    [self.delegate udpConnectionState:@{
      @"isConnect":@(0),
      @"port":@(_port),
      @"address":@"",
      @"error":error ? @{
          @"code":@(error.code),
          @"domain":[NSString stringWithFormat:@"%@",error.domain],
          @"userInfo":[NSString stringWithFormat:@"%@",error.description],
      } : [NSNull null]
    }];
  }
  _udpSocket.delegate = nil;
  _udpSocket = nil;
}

- (void)udpSocketDidClose:(GCDAsyncUdpSocket *)sock withError:(NSError  * _Nullable)error
{
  NSLog(@"===UdpSocket====udpSocketDidClose=======%@",error);
  
  if (self.delegate && [self.delegate respondsToSelector:@selector(udpConnectionState:)]) {
    [self.delegate udpConnectionState:@{
      @"isConnect":@(0),
      @"port":@(_port),
      @"address":@"",
      @"error":error ? @{
        @"code":@(error.code),
        @"domain":[NSString stringWithFormat:@"%@",error.domain],
        @"userInfo":[NSString stringWithFormat:@"%@",error.description],
    } : [NSNull null]
    }];
  }
  _udpSocket.delegate = nil;
  _udpSocket = nil;
}

- (void)udpSocket:(GCDAsyncUdpSocket *)sock didSendDataWithTag:(long)tag
{
  NSLog(@"===UdpSocket====didSendDataWithTag=======%ld",tag);
  if (self.delegate && [self.delegate respondsToSelector:@selector(udpSendDataState:)]) {
    [self.delegate udpSendDataState:YES];
  }
}

- (void)udpSocket:(GCDAsyncUdpSocket *)sock didNotSendDataWithTag:(long)tag dueToError:(NSError * _Nullable)error;
{
  NSLog(@"==UdpSocket=====didNotSendDataWithTag======tag=%ld=errot=%@",tag,error);
  if (self.delegate && [self.delegate respondsToSelector:@selector(udpSendDataState:)]) {
    [self.delegate udpSendDataState:NO];
  }
}

- (void)udpSocket:(GCDAsyncUdpSocket *)sock didReceiveData:(NSData *)data
                                             fromAddress:(NSData *)address
                                       withFilterContext:(nullable id)filterContext
{

  NSLog(@"==UdpSocket==didReceiveData==str=%@",[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
    
  return;
  dispatch_sync(_decod_data_queue, ^{
      NSString *host;
      UInt16 port;
      int family;
      [GCDAsyncUdpSocket getHost:&host port:&port family:&family fromAddress:address];
      NSString *ipAddr = [self getIPAddress];
//      NSLog(@"==UdpSocket==host=%@ port=%d==family=%d ipAddr=%@ ",host,port,family,ipAddr);
      if ([host containsString:ipAddr]) {
//        NSLog(@"==host containsString ipAddr===%@",host);
        return;
      }
//      NSLog(@"==UdpSocket==didReceiveData===%@",data);
      
        
      [self.bufferCache appendData:data];
        
      NSUInteger count = 0;
      unsigned char a[2] = {0,0};
      while (count < self.bufferCache.length - 1) {
        a[0] = 0;a[1] = 0;
        NSRange range = NSMakeRange(count, 2);
        [self.bufferCache getBytes:a range:range];
        if (a[0] == 0xAA && a[1] == 0x55) {
          [self.bufferCache replaceBytesInRange:range withBytes:a length:1];
        }
        count ++;
      }
      
      [self packetSlice:self.bufferCache];
    });
    
}


#pragma mark  粘包/断包处理
///粘包/断包处理
-(void)packetSlice:(NSMutableData *)mutiData
{
    while (mutiData.length) {
        if (mutiData.length < 9) {
            NSLog(@"===数据长度不够===%@",mutiData);
            return;
        }
        char *dataBuffer = (char *)mutiData.bytes;
        char ccc[2] = {0xAA,0xAA};
        NSData *stx= [NSData dataWithBytes:ccc length:2];
        NSRange stxRange = [mutiData rangeOfData:stx options:0 range:NSMakeRange(0, mutiData.length)];
//        NSLog(@"====stxRange===%@",NSStringFromRange(stxRange));
        
          //找到了包头，
        if(stxRange.length == 2 && stxRange.location < mutiData.length){
            //现在找长度
            NSUInteger payloadLen = (dataBuffer[stxRange.location + 2] << 8) | dataBuffer[stxRange.location + 3];
//            NSLog(@"====payloadLen===%ld",payloadLen);
            if (mutiData.length < stxRange.location + payloadLen + 4) {
                NSLog(@"====数据不够长=11==%@",mutiData);
              return;
            }
            //截取payload,得到完整数据包
            NSRange subR = NSMakeRange(stxRange.location, payloadLen + 4);
            NSData *subData = [mutiData subdataWithRange:subR];
            //解析完整的包
            [self crcSecurity:subData];
//            NSLog(@"====OK 数据===%@",subData);
            //删除payload中分片完的数据
            [mutiData replaceBytesInRange:NSMakeRange(0, stxRange.location + payloadLen + 4) withBytes:NULL length:0];
//            NSLog(@"===OK 数据=222==%@",mutiData);
        }else{
              //没找到包头，判断最后两个字节是否是0xAA
          if (mutiData.length >= 1) {
              unsigned char *buff = (unsigned char *)mutiData.bytes;
              if(buff[mutiData.length - 1] == 0xAA){
                  //最后一个字节可能是包头的第一字节，清除之前的数据
                  [mutiData replaceBytesInRange:NSMakeRange(0, mutiData.length - 1) withBytes:NULL length:0];
                  NSLog(@"[yxy]====可能是包头的第一字节===%@",mutiData);
                  return;
              }else{
                  NSLog(@"[yxy]====废数据===%@",mutiData);
                  [mutiData replaceBytesInRange:NSMakeRange(0, mutiData.length) withBytes:NULL length:0];
                  return;
              }
          }else{
              NSLog(@"[yxy]====空数据===%@",mutiData);
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
    unsigned char oldCRC = buffer[4];
    //根据数据计算新的crc值和原crc进行比较
    unsigned char newCRC = [CRC crcSum:(char *)(buffer + 5) offset:(unsigned int)(data.length - 5)];
    if(oldCRC == newCRC){
        //crc校验正确
      int cmd = [ByteConverter bytes2ShortBig:(char *)buffer offset:7];
      if (cmd == 0x0131) {
//        NSLog(@"===crc校验正确===0x0131");
        return;
      }
//      NSLog(@"===crc校验正确===%@",data);
      dispatch_async(dispatch_get_main_queue(), ^{
        if(self.delegate && [self.delegate respondsToSelector:@selector(udpSocket:didReadData:)]){
            [self.delegate udpSocket:self didReadData:data];
        }
      });
    }else{
        //crc校验错误，数据有问题，抛弃掉
        NSLog(@"crc error=%@",data);
    }
}

static int serialNum = 0;

-(int)getSerialNum{
  serialNum ++;
  if (serialNum == 0 || serialNum == 0xFFFF) {
    serialNum = 1;
  }
  return serialNum;
}

-(void)makeData{
  int len = 5 + 4;
  NSMutableData *data = [NSMutableData dataWithLength:len];
  char *buf = (char *)data.bytes;
  buf[0] = 0xAA;
  buf[1] = 0xAA;
  buf[2] = (len >> 8) & 0xFF;
  buf[3] = len & 0xFF;
  int packetid = [self getSerialNum];
  buf[5] = (packetid >> 8) & 0xFF;
  buf[6] = packetid & 0xFF;
  buf[7] = 0x01;
  buf[8] = 0x31;
  
  buf[4] = [CRC crcSum:(buf + 4) offset:(unsigned int)(data.length - 5)];
  
}


-(NSString *)getIPAddress
{
  NSString *address = @"";
  struct ifaddrs *interfaces = NULL;
  struct ifaddrs *temp_addr = NULL;
  int success = 0;
  success = getifaddrs(&interfaces);
  if (success == 0) {
    temp_addr = interfaces;
    while (temp_addr != NULL) {
      if (temp_addr->ifa_addr->sa_family == AF_INET) {
        if ([[NSString stringWithUTF8String:temp_addr->ifa_name] isEqualToString:@"en0"]) {
          address = [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)temp_addr->ifa_addr)->sin_addr)];
        }
      }
      temp_addr = temp_addr -> ifa_next;
    }
  }
  return address;
}

-(NSString *)getBroadcastAddress
{
  NSArray *strArr = [[self getIPAddress] componentsSeparatedByString:@"."];
  NSMutableArray *muArr = [NSMutableArray arrayWithArray:strArr];
  [muArr replaceObjectAtIndex:strArr.count - 1 withObject:@"255"];
  NSString *address = [muArr componentsJoinedByString:@"."];
  return address;
}

@end
