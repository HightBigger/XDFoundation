//
//  XDUtil+Css.m
//  XDFoundation
//
//  Created by xiaoda on 2020/8/16.
//  Copyright © 2020 XDFoundation. All rights reserved.
//

#import "XDUtil+Css.h"
#import "NSString+XDExtension.h"

@implementation XDUtil (Css)

+ (UIColor *)parseColor:(NSString*)cssValue
{
    UIColor *defaultValue = [UIColor clearColor];
    
    if (cssValue == nil)
        return defaultValue;
    
    NSString* colorText = [[cssValue stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    if ([colorText hasPrefix:@"#"])
    {
        //#FFFFFF 或者 #FFFFFFFF
        colorText = [colorText substringFromIndex:1];
        if (colorText.length == 6)
        {
            for (int i = 0; i < 6; i++)
            {
                unichar c = [colorText characterAtIndex:i];
                if (!((c >= L'A' && c <= 'Z') || ( c >= L'0' && c <= L'9')))
                    return defaultValue;
            }
            
            NSRange range;
            range.location = 0;
            range.length = 2;
            //r
            NSString *rString = [colorText substringWithRange:range];
            //g
            range.location = 2;
            NSString *gString = [colorText substringWithRange:range];
            //b
            range.location = 4;
            NSString *bString = [colorText substringWithRange:range];
            
            // Scan values
            unsigned int r, g, b;
            [[NSScanner scannerWithString:rString] scanHexInt:&r];
            [[NSScanner scannerWithString:gString] scanHexInt:&g];
            [[NSScanner scannerWithString:bString] scanHexInt:&b];
            return [UIColor colorWithRed:((float)r / 255.0f) green:((float)g / 255.0f) blue:((float)b / 255.0f) alpha:1.0f];
            
        }
        else if(colorText.length == 8)
        {
            for (int i = 0; i < 8; i++)
            {
                unichar c = [colorText characterAtIndex:i];
                if (!((c >= L'A' && c <= 'Z') || ( c >= L'0' && c <= L'9')))
                    return defaultValue;
            }
            
            NSRange range;
            range.location = 0;
            range.length = 2;
            //a
            NSString *aString = [colorText substringWithRange:range];
            //r
            range.location = 2;
            NSString *rString = [colorText substringWithRange:range];
            //g
            range.location = 4;
            NSString *gString = [colorText substringWithRange:range];
            //b
            range.location = 6;
            NSString *bString = [colorText substringWithRange:range];
            
            
            // Scan values
            unsigned int r, g, b,a;
            [[NSScanner scannerWithString:rString] scanHexInt:&r];
            [[NSScanner scannerWithString:gString] scanHexInt:&g];
            [[NSScanner scannerWithString:bString] scanHexInt:&b];
            [[NSScanner scannerWithString:aString] scanHexInt:&a];
            return [UIColor colorWithRed:((float)r / 255.0f) green:((float)g / 255.0f) blue:((float)b / 255.0f) alpha:((float)a / 255.0f)];
        }
        else
        {
            return defaultValue;
        }
    }
    else if([colorText hasPrefix:@"RGBA"])
    {
        //RGBA
        colorText = [colorText substringFromIndex:4];
        int pos = [colorText indexOf:@"(" startPos:0];
        int pos1 = [colorText indexOf:@")" startPos:0];
        pos++;
        colorText = [colorText subString:pos endPos:pos1];
        colorText = [colorText trim];
        NSArray* ary = [colorText splitStr:@","];
        if (ary == nil || ary.count != 4)
            return defaultValue;
        
        for (int i = 0; i < 4; i++)
        {
            NSString* text = [ary objectAtIndex:i];
            
            if (i != 3)
            {
                if (![self isDouble:text])
                    return defaultValue;
            }
            else
            {
                if (![self isDouble:text])
                    return defaultValue;
            }
            
        }
        
        int r = [[ary objectAtIndex:0] intValue];
        int g = [[ary objectAtIndex:1] intValue];
        int b = [[ary objectAtIndex:2] intValue];
        float a = [[ary objectAtIndex:3] floatValue];
        return [UIColor colorWithRed:((float)r / 255.0f) green:((float)g / 255.0f) blue:((float)b / 255.0f) alpha:a];
    }
    else if([colorText hasPrefix:@"RGB"])
    {
        colorText = [colorText substringFromIndex:3];
        int pos = [colorText indexOf:@"(" startPos:0];
        int pos1 = [colorText indexOf:@")" startPos:0];
        pos++;
        colorText = [colorText subString:pos endPos:pos1];
        colorText = [colorText trim];
        NSArray* ary = [colorText splitStr:@","];
        if (ary == nil || ary.count != 3)
            return defaultValue;
        
        for (int i = 0; i < 3; i++) {
            NSString* text = [ary objectAtIndex:i];
            if (![self isDouble:text])
                return defaultValue;
        }
        
        int r = [[ary objectAtIndex:0] intValue];
        int g = [[ary objectAtIndex:1] intValue];
        int b = [[ary objectAtIndex:2] intValue];
        return [UIColor colorWithRed:((float)r / 255.0f) green:((float)g / 255.0f) blue:((float)b / 255.0f) alpha:1.0f];
    }
    else
    {
        if([colorText equalsIgnoreCase:@"black"])
            return [UIColor blackColor];
        else if([colorText equalsIgnoreCase:@"silver"])
            return [UIColor colorWithRed:((float)192 / 255.0f) green:((float)192 / 255.0f) blue:((float)192 / 255.0f) alpha:1.0f];
        else if([colorText equalsIgnoreCase:@"gray"])
            return [UIColor grayColor];
        else if([colorText equalsIgnoreCase:@"white"])
            return [UIColor whiteColor];
        else if([colorText equalsIgnoreCase:@"red"])
            return [UIColor redColor];
        else if([colorText equalsIgnoreCase:@"green"])
            return [UIColor greenColor];
        else if([colorText equalsIgnoreCase:@"blue"])
            return [UIColor blueColor];
        else if([colorText equalsIgnoreCase:@"yellow"])
            return [UIColor yellowColor];
        else if([colorText equalsIgnoreCase:@"transparent"])
            return [UIColor clearColor];
        else
            return defaultValue;
        
    }
    return defaultValue;
}

+ (UIColor*)parseColor:(NSString*)color darkMode:(NSString*)darkColor
{
    UIColor* nColor = [XDUtil parseColor:color];
    UIColor* dColor = [XDUtil parseColor:darkColor ];
    return [XDUtil setDynamicColor:nColor darkMode:dColor];
}

+ (UIColor*)setDynamicColor:(UIColor*)color darkMode:(UIColor*)darkColor
{
    if (@available(iOS 13.0, *))
    {
        #if __IPHONE_OS_VERSION_MAX_ALLOWED >= 130000
        UIColor *dyColor = [UIColor colorWithDynamicProvider:^UIColor * _Nonnull(UITraitCollection * _Nonnull trainCollection)
        {
            if ([trainCollection userInterfaceStyle] == UIUserInterfaceStyleLight)
            {
                return color;
            }
            else
            {
                return darkColor;
            }
        }];
        return dyColor;
        #else
        return color;
        #endif
    }
    else
    {
        return color;
    }
}

+ (BOOL)isInterger:(NSString*)text
{
    NSScanner* scan = [NSScanner scannerWithString:text];
    int val;
    return [scan scanInt:&val] && [scan isAtEnd];
}

+ (BOOL)isDouble:(NSString*)text
{
    NSScanner* scan = [NSScanner scannerWithString:text];
    double val;
    return [scan scanDouble:&val] && [scan isAtEnd];
}

+ (UIImage*)createImageWithColor:(UIColor*)color size:(CGSize)size
{
    CGRect rect= CGRectMake(0, 0, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}

+ (float)getProportionHeight:(CGSize)srcSize width:(float)width
{
    if (srcSize.width <= 0)
        return 0;
    
    return srcSize.height * width / srcSize.width;
}


+ (float)getProportionWidth:(CGSize)srcSize height:(float)height
{
    if (srcSize.height <= 0)
        return 0;
    
    return srcSize.width * height / srcSize.height;
}

@end
