//
//  MapViewManager.m
//  BasicReactNativeProject
//
//  Created by xingye yang on 2021/6/18.
//

#import "QMapViewManager.h"
#import <React/RCTLog.h>
#import "GaodeMapView.h"

@interface QMapViewManager ()
@property(nonatomic,strong)UIView *mapView;
//@property(nonatomic,strong)GaodeMapView *mapView;
@end

@implementation QMapViewManager

RCT_EXPORT_MODULE(QMapViewManager)

- (dispatch_queue_t)methodQueue
{
  return dispatch_get_main_queue();
}

- (UIView *)view
{
  _mapView = [[UIView alloc] init];
  return _mapView;
}

@end
