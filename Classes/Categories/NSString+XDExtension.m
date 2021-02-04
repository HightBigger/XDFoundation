//
//  NSString+XDExtension.m
//  XDFoundation
//
//  Created by xiaoda on 2020/8/16.
//  Copyright © 2020 XDFoundation. All rights reserved.
//

#import "NSString+XDExtension.h"

@implementation NSString (XDExtension)

- (int)indexOf:(NSString*)findString startPos:(int)startPos
{
    if (findString == nil)
        return -1;
    
    int length = (int)self.length;
    if (startPos >= length)
        return -1;
    
    
    length = length - startPos;
    NSRange range = [self rangeOfString:findString options:NSCaseInsensitiveSearch | NSLiteralSearch range:NSMakeRange(startPos, length)];
    if (range.location == NSNotFound)
        return -1;
    return (int)(range.location);
}

- (NSString*)subString:(int)startPos endPos:(int)endPos
{
    if (endPos == -1)
        endPos = (int)(self.length);
    if (endPos >= self.length)
        endPos = (int)(self.length);
    
    int len = endPos - startPos;
    return [self substringWithRange:NSMakeRange(startPos, len)];
}

- (NSString*)trim
{
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

- (NSArray*)splitStr:(NSString*)string
{
    NSMutableArray* list = [[NSMutableArray alloc] init];
    NSArray* ary = [self componentsSeparatedByString:string];
    for (NSString* text in ary) {
        NSString* tmp = [text trim];
        if (tmp.length > 0)
            [list addObject:tmp];
    }
    return list;
}

- (BOOL)equalsIgnoreCase:(NSString*)text
{
    return [self caseInsensitiveCompare:text] == NSOrderedSame;
}

@end
