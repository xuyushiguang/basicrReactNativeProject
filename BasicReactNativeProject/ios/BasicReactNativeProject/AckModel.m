//
//  AckModel.m
//  MyTools
//
//  Created by xingye.yang  qq:939607134 on 2021/4/28.
//

#import "AckModel.h"

@implementation AckModel

- (void)dealloc
{
    //NSLog(@"==AckModel dealloc=");
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _timeOut = 5;
        _ack = -1;
    }
    return self;
}

@end
