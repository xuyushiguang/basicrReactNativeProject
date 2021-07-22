#import "AppDelegate.h"

#import <React/RCTBridge.h>
#import <React/RCTBundleURLProvider.h>
#import <React/RCTRootView.h>

#ifdef FB_SONARKIT_ENABLED
#import <FlipperKit/FlipperClient.h>
#import <FlipperKitLayoutPlugin/FlipperKitLayoutPlugin.h>
#import <FlipperKitUserDefaultsPlugin/FKUserDefaultsPlugin.h>
#import <FlipperKitNetworkPlugin/FlipperKitNetworkPlugin.h>
#import <SKIOSNetworkPlugin/SKIOSNetworkAdapter.h>
#import <FlipperKitReactPlugin/FlipperKitReactPlugin.h>

#import <React/RCTLog.h>
#import "OCEventer.h"

//#import "QAsyncTcpSocket.h"
#import <BLWebSocketsServer/BLWebSocketsServer.h>
#import "QAsyncUDPSocket.h"

static void InitializeFlipper(UIApplication *application) {
  FlipperClient *client = [FlipperClient sharedClient];
  SKDescriptorMapper *layoutDescriptorMapper = [[SKDescriptorMapper alloc] initWithDefaults];
  [client addPlugin:[[FlipperKitLayoutPlugin alloc] initWithRootNode:application withDescriptorMapper:layoutDescriptorMapper]];
  [client addPlugin:[[FKUserDefaultsPlugin alloc] initWithSuiteName:nil]];
  [client addPlugin:[FlipperKitReactPlugin new]];
  [client addPlugin:[[FlipperKitNetworkPlugin alloc] initWithNetworkAdapter:[SKIOSNetworkAdapter new]]];
  [client start];
}
#endif

@interface AppDelegate ()<QAsyncUDPSocketDelegate>
{
//  OCEventer * _oceventer;
  QAsyncUDPSocket *_udpSocket;
  
}


@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
  
//  [[BLWebSocketsServer sharedInstance] setHandleRequestBlock:^NSData *(NSData *requestData) {
////    NSLog(@"****oc*****setHandleRequestBlock*********%@",requestData);
//    NSLog(@"****oc*****setHandleRequestBlock*********%@",[[NSString alloc] initWithData:requestData encoding:NSUTF8StringEncoding]);
//    [[BLWebSocketsServer sharedInstance] pushToAll:[@"1234qwr" dataUsingEncoding:NSUTF8StringEncoding]];
//    return [@"asdfgg" dataUsingEncoding:NSUTF8StringEncoding];//也可以在这里返回数据
//  }];
//
//  [[BLWebSocketsServer sharedInstance] startListeningOnPort:12345 withProtocolName:@"echo-protocol" andCompletionBlock:^(NSError *error) {
//    NSLog(@"****oc*****startListeningOnPort*********%@",error);
//
//  }];
  
  
#ifdef FB_SONARKIT_ENABLED
  InitializeFlipper(application);
#endif

  RCTBridge *bridge = [[RCTBridge alloc] initWithDelegate:self launchOptions:launchOptions];
  RCTRootView *rootView = [[RCTRootView alloc] initWithBridge:bridge
                                                   moduleName:@"BasicReactNativeProject"
                                            initialProperties:nil];

  rootView.backgroundColor = [UIColor whiteColor];

  self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
  UIViewController *rootViewController = [UIViewController new];
  rootViewController.view = rootView;
  self.window.rootViewController = rootViewController;
  [self.window makeKeyAndVisible];
  
  
//  _udpSocket = [[QAsyncUDPSocket alloc] initWithDelegate:self];
//
//  [_udpSocket bindToPort:1233];
//
//  [NSTimer scheduledTimerWithTimeInterval:2 repeats:YES block:^(NSTimer * _Nonnull timer) {
//    [_udpSocket writeDate:[@"123456" dataUsingEncoding:NSUTF8StringEncoding] host:@"127.0.0.1" port:1234];
//  }];
  
  return YES;
}

- (NSURL *)sourceURLForBridge:(RCTBridge *)bridge
{
#if DEBUG
  NSURL *url = [[RCTBundleURLProvider sharedSettings] jsBundleURLForBundleRoot:@"index" fallbackResource:nil];
  RCTLog(@"sourceURLForBridge ==DEBUG=== url=%@",url);
  return url;
#else
  NSURL *url = [[NSBundle mainBundle] URLForResource:@"main" withExtension:@"jsbundle"];
  RCTLog(@"sourceURLForBridge ===realease== url=%@",url);
  return url;
#endif
}

@end
