//
//  XDUtil+Device.m
//  XDFoundation
//
//  Created by xiaoda on 2020/8/18.
//  Copyright © 2020 XDFoundation. All rights reserved.
//

#import "XDUtil+Device.h"

@implementation XDUtil (Device)

+ (CGFloat)safeAreaHeight
{
    if (UIDevice.currentDevice.userInterfaceIdiom != UIUserInterfaceIdiomPhone) {
        return 0;
    }
    
    if (@available(iOS 11.0, *)) {
        UIWindow *mainWindow = [[[UIApplication sharedApplication] delegate] window];
        return mainWindow.safeAreaInsets.bottom;
    }
    
    return 0;
}

+ (NSString*)getOsVersion
{
    NSString* version = [[UIDevice currentDevice] systemVersion];
    return version;
}

+ (NSString*)getClientVersion
{
    NSString* text = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    return text;
}

+ (NSString*)getBuildVersion
{
    NSString *build = [[NSBundle mainBundle].infoDictionary objectForKey:@"CFBundleVersion"];
    
    return build;
}

+ (BOOL)isIPhoneX
{
    return [XDUtil safeAreaHeight] > 0;

}

+ (NSString*)getClientID
{
    return [NSBundle mainBundle].bundleIdentifier;
}

+ (NSString*)getSystemVersion
{
    return [[UIDevice currentDevice] systemVersion];
}

@end
