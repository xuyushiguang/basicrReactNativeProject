//
//  MapViewManager.h
//  BasicReactNativeProject
//
//  Created by xingye yang on 2021/6/18.
//

#import <React/RCTViewManager.h>
#import <React/RCTBridgeModule.h>
#import <React/RCTUIManager.h>
#import <React/RCTConvert.h>
#import <React/RCTLog.h>

NS_ASSUME_NONNULL_BEGIN
/* 大坑
 注意明明规范,如果类的后面是...Manager带这种Manager,在js中这样用requireNativeComponent('QMapView');
 否则不加载UI,
 最好不带Manager后缀.或者在RCT_EXPORT_MODULE(QMap)声明的时候别带Manager后缀
 */
@interface QMapViewManager : RCTViewManager

@end

NS_ASSUME_NONNULL_END
