//
//  QRedView.h
//  BasicReactNativeProject
//
//  Created by xingye yang on 2021/6/21.
//

#import <UIKit/UIKit.h>
#import <React/RCTComponent.h>
NS_ASSUME_NONNULL_BEGIN

@interface QRedView : UIView

@property(nonatomic,copy)NSString *str;
@property(nonatomic,copy)NSString *age;

@property(nonatomic,copy)RCTBubblingEventBlock onClick;

@end

NS_ASSUME_NONNULL_END
