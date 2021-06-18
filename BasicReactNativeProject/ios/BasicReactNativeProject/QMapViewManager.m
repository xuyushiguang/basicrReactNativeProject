//
//  MapViewManager.m
//  BasicReactNativeProject
//
//  Created by xingye yang on 2021/6/18.
//

#import "QMapViewManager.h"
#import <MapKit/MapKit.h>
#import "RCTConvert+Mapkit.h"

@interface QMapViewManager ()

@property(nonatomic,strong)MKMapView *mapView;
@end

@implementation QMapViewManager

RCT_EXPORT_MODULE(QMapView)

- (dispatch_queue_t)methodQueue
{
  return dispatch_get_main_queue();
}

- (UIView *)view
{
  _mapView = [[MKMapView alloc] init];
  return _mapView;
}

RCT_EXPORT_VIEW_PROPERTY(zoomEnabled, BOOL)

RCT_CUSTOM_VIEW_PROPERTY(region, MKCoordinateRegion, MKMapView)
{
  
  MKCoordinateRegion reg = [RCTConvert MKCoordinateRegion:json];
  RCTLog(@"====latitude====%f",reg.center.latitude);
  RCTLog(@"==latitude==latitudeDelta====%f",reg.span.latitudeDelta);
  [view setRegion:json ? reg : defaultView.region animated:YES];
}

RCT_EXPORT_METHOD(reload:(nonnull NSNumber *)reactTag){
  printf("=====self.bridge.uiManager addUIBloc==%d \n",[reactTag intValue]);
//  [self.bridge.uiManager addUIBlock:^(RCTUIManager *uiManager, NSDictionary<NSNumber *,UIView *> *viewRegistry) {
//    id view = viewRegistry[reactTag];
//    if ([view isKindOfClass:[MKMapView class]]) {
//      printf("=====self.bridge.uiManager addUIBloc==");
//    }
//  }];
}

RCT_EXPORT_METHOD(blockCallbackEvent:(RCTResponseSenderBlock)callBack){
  callBack(@[[NSNull null],@"1234"]);
}

@end
