//
//  AckModelManager.m
//  MyTools
//
//  Created by xingye.yang  qq:939607134 on 2021/4/28.
//

#import "AckModelManager.h"


typedef NS_ENUM(NSUInteger,TimerStatus){
    suspend,
    resume
};

@interface AckModelManager ()<NSCopying,NSMutableCopying>
{
    dispatch_source_t _timer;
    TimerStatus _status;
    dispatch_queue_t _queue_t ;
}

@property(nonatomic,strong)NSMutableDictionary<NSNumber *,AckModel *> *ackDic;

@end
static AckModelManager *_instance = nil;
@implementation AckModelManager

+(instancetype)shareInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[super allocWithZone:NULL] init];
    });
    return _instance;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _ackDic = [NSMutableDictionary dictionary];
        _queue_t = dispatch_queue_create("com.quectel.ackManager", DISPATCH_QUEUE_SERIAL);
        [self createTimer];
    }
    return self;
}

+(instancetype)allocWithZone:(struct _NSZone *)zone
{
    return [AckModelManager shareInstance];
}

- (nonnull id)copyWithZone:(nullable NSZone *)zone {
    return self;
}

- (nonnull id)mutableCopyWithZone:(nullable NSZone *)zone {
    return self;
}

-(void)createTimer{
    if (_timer) {
        dispatch_source_cancel(_timer);
        _timer = nil;
    }
    
    _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, dispatch_get_global_queue(0, 0));
    dispatch_source_set_timer(_timer, dispatch_time(DISPATCH_TIME_NOW, NSEC_PER_SEC), NSEC_PER_SEC, 0);
    
    dispatch_source_set_event_handler(_timer, ^{
        dispatch_sync(self->_queue_t, ^{
            [self calculationTimeOut];
            if(self.ackDic.count == 0){
                if(self->_status == resume){
                    [self suspend];
                }
            }
        });
    });
    [self resume];
}

-(void)calculationTimeOut{
    
    NSMutableArray * timeOutkeys = @[].mutableCopy;
    
    [_ackDic enumerateKeysAndObjectsUsingBlock:^(NSNumber * _Nonnull key, AckModel * _Nonnull ack, BOOL * _Nonnull stop) {
        ack.timeOut -= 1;
        if(ack.timeOut <= 0){
            NSLog(@"[yxy]ack timeout cmdType=%d cmd=%d",ack.cmdType,ack.cmd);
            dispatch_async(dispatch_get_main_queue(), ^{
                AckBlock block = (AckBlock)ack.ackBlock;
                if(block){
                    ack.ack = -1;
                    block(-1,nil);
                }
            });
            
            [timeOutkeys addObject:key];
        }
    }];
    
    [_ackDic removeObjectsForKeys:timeOutkeys];

}

-(void)suspend{
    if (_timer) {
        _status = suspend;
        dispatch_suspend(_timer);
    }
}

-(void)resume
{
    if (_timer) {
        _status = resume;
        dispatch_resume(_timer);
    }
}

-(void)cancelTimer{
    if (_timer) {
        _status = suspend;
        dispatch_source_cancel(_timer);
        _timer = nil;
    }
}

-(void)addAckModel:(AckModel *)ack{
    if(_timer){
        dispatch_sync(_queue_t, ^{
            int cmdid = (ack.cmdType << 8) | ack.cmd;
            [self.ackDic setObject:ack forKey:@(cmdid & 0xFFFF)];
            if(self->_status == suspend){
                [self resume];
            }
        });
    }else{
        NSLog(@"_timer error: restart _timer");
        [self createTimer];
    }
}

-(AckModel *)popAckModel:(int)key
{
    if (key == 0) {
        return nil;
    }
    __block AckModel *model;
    dispatch_sync(_queue_t, ^{
        model = [self->_ackDic objectForKey:@(key)];
    });
    return model;
}

-(void)deleteAckModel:(int)key
{
    if (key == 0) {
        return ;
    }
    dispatch_sync(_queue_t, ^{
        AckModel *ack = [self.ackDic objectForKey:@(key)];
        ack.ackBlock = nil;
        [self.ackDic removeObjectForKey:@(key)];
    });
}

@end
