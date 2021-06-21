//
//  OCEventer.m
//  BasicReactNativeProject
//
//  Created by xingye yang on 2021/6/21.
//

#import "OCEventer.h"

@interface OCEventer ()
{
  NSTimer *_timer;
}
@end

@implementation OCEventer
RCT_EXPORT_MODULE();

static int acount = 0;

- (instancetype)init
{
  self = [super init];
  if (self) {
//    _timer = [NSTimer scheduledTimerWithTimeInterval:2.0 repeats:YES block:^(NSTimer * _Nonnull timer) {
//      NSLog(@"sendEventWithName");
//      acount ++;
//      [self sendEventWithName:@"sendSelectedItem" body:@{@"title":[@(acount) stringValue]}];
//    }];
  }
  return self;
}

//返回函数执行时所在的线程，一般跨段交互都会操作UI，所以返回主线程
- (dispatch_queue_t)methodQueue
{
  return  dispatch_get_main_queue();
}

//返回给js端，iOS调用的js方法，js只能监听这些方法。
-(NSArray<NSString *>*)supportedEvents
{
  return @[@"sendSelectedItem"];
}


//加了一个回调block，js端调用testCallbackEventOne后，会在调用js方法参数中的闭包函数
//参数是数组，在js端收到的参数不是数组，而是分开的参数，参数个数和数组元素个数一样。
RCT_EXPORT_METHOD(testCallbackEventOne:(NSString*)name callback:(RCTResponseSenderBlock)callback){
  NSLog(@"**ios***==name=%@",name);
  callback(@[@"1",@"2"]);
}

//在js端可以异步执行的函数
RCT_REMAP_METHOD(testCallbackEventTwo,
                 resolevr:(RCTPromiseResolveBlock)resolve
                 rejecter:(RCTPromiseRejectBlock)reject){
  
  NSString *str = @"iosiosios";
  if (str) {
    resolve(str);
  }else{
    reject(@"error",@"error1",[NSError errorWithDomain:@"error2" code:1000 userInfo:@{@"11":@"22"}]);
  }
}


@end
