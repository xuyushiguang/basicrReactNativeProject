//
//  RCTConvert+Mapkit.h
//  BasicReactNativeProject
//
//  Created by xingye yang on 2021/6/18.
//

#import <React/RCTConvert.h>
#import <MapKit/MapKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface RCTConvert (Mapkit)
+ (MKCoordinateSpan)MKCoordinateSpan:(id)json;
+ (MKCoordinateRegion)MKCoordinateRegion:(id)json;
@end

NS_ASSUME_NONNULL_END
