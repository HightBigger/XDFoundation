//
//  XDMacro.h
//  XDFoundation
//
//  Created by xiaoda on 2020/8/18.
//  Copyright © 2020 XDFoundation. All rights reserved.
//

#import <XDFoundation/XDUtil+Device.h>

#define ISIPHONEX               ([XDUtil isIPhoneX])
#define ISIPHONE                ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
#define ISIPAD                  ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad)
#define XDScreenWidth           [UIScreen mainScreen].bounds.size.width
#define XDScreenHeight          [UIScreen mainScreen].bounds.size.height
#define XDStatusHeight          [[UIApplication sharedApplication] statusBarFrame].size.height
#define XDNavigationHeight      self.navigationController.navigationBar.frame.size.height
#define XDTabBarHeight          self.tabBarController.tabBar.frame.size.height
#define XDBottomInsets          ([XDUtil safeAreaHeight])

#define XDSafeBlock(BlockName, ...)   ({ !BlockName ? nil : BlockName(__VA_ARGS__); })
