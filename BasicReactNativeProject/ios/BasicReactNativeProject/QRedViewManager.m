//
//  QRedViewManager.m
//  BasicReactNativeProject
//
//  Created by xingye yang on 2021/6/21.
//

#import "QRedViewManager.h"
#import "QRedView.h"
#import "OCEventer.h"

@interface QRedViewManager ()

@property(nonatomic,strong)QRedView *redView;

@end

@implementation QRedViewManager

RCT_EXPORT_MODULE(QRedView)

- (UIView *)view
{
  _redView = [[QRedView alloc] init];
  //_redView.backgroundColor = [UIColor redColor];
  return _redView;
}

RCT_CUSTOM_VIEW_PROPERTY(str, NSString *, QRedView)
{
  [view setStr:json];
}


@end
