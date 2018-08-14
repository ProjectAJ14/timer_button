#import "TimerButtonPlugin.h"
#import <timer_button/timer_button-Swift.h>

@implementation TimerButtonPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftTimerButtonPlugin registerWithRegistrar:registrar];
}
@end
