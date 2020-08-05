//
//  ViewController.m
//  KVO_demo
//
//  Created by YC on 2020/8/4.
//  Copyright © 2020 yc. All rights reserved.
//

#import "ViewController.h"
#import "YCPerson.h"
#import <objc/runtime.h>

@interface ViewController ()

@property (nonatomic, strong) YCPerson *person;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSLog(@"KVO之前");
//    NSLog(@"%p",[self.person methodForSelector:@selector(setAge:)]);
    [self printMethodNameOfClass:object_getClass(self.person)];
    
    
    [self.person addObserver:self forKeyPath:@"age" options:(NSKeyValueObservingOptionOld | NSKeyValueObservingOptionNew) context:nil];
    self.person.age = 1;
    
    
    NSLog(@"KVO之后");
//    NSLog(@"%p",[self.person methodForSelector:@selector(setAge:)]);
    [self printMethodNameOfClass:object_getClass(self.person)];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    NSLog(@"%@发生了改变",keyPath);
}

- (void)dealloc {
    [self.person removeObserver:self forKeyPath:@"age"];
}

/// 打印类对象的所有方法
/// @param cls 类对象
- (void)printMethodNameOfClass:(Class)cls {
    unsigned int count;
    // 获得方法数组
    Method *methodList = class_copyMethodList(cls, &count);
    // 存储方法名
    NSMutableString *methodNames = [NSMutableString string];
    // 遍历所有的方法
    for (int i = 0; i < count; i++) {
        // 获得方法
        Method method = methodList[i];
        // 获得方法名
        NSString *methodName = NSStringFromSelector(method_getName(method));
        // 拼接方法名
        [methodNames appendString:methodName];
        [methodNames appendString:@", "];
    }
    // 释放
    free(methodList);
    // 打印方法名
    NSLog(@"%@所有方法 %@", cls, methodNames);
}

#pragma mark - Getters/Setters

- (YCPerson *)person {
    if (!_person) {
        _person = [YCPerson new];
    }
    return _person;
}

@end
