//
//  NSKVONotifying_YCPerson.m
//  KVO_demo
//
//  Created by YC on 2020/8/5.
//  Copyright © 2020 yc. All rights reserved.
//

#import "NSKVONotifying_YCPerson.h"

@implementation NSKVONotifying_YCPerson

- (void)setAge:(NSUInteger)age {
    // _NSSetUnsignedLongLongValueAndNotify
    [self willChangeValueForKey:@"age"];
    [super setAge:age];
    [self didChangeValueForKey:@"age"];
}

- (void)didChangeValueForKey:(NSString *)key {
    // 通知监听器，key发生了改变
    [self observeValueForKeyPath:key ofObject:self change:nil context:nil]; // 伪码：参数暂时设为nil
}

@end
