//
//  ViewController.m
//  非对象类型放入数组
//
//  Created by yg on 2017/8/1.
//  Copyright © 2017年 TBB. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}
//假设CGPoint是自定义的结构体
- (IBAction)btntap:(id)sender {
    CGPoint p1 = CGPointMake(10, 20);
    CGPoint p2 = CGPointMake(30, 40);
    CGPoint p3 = CGPointMake(50, 60);
    CGPoint p4 = CGPointMake(70, 80);
    
    //集合的成员只能是Objective-C的对象,不能是结构体
    //NSArray *points = @[p1, p2, p3, p4];
    //1. 将非对象类型转换成对象类型
    //CGPoint ==> NSValue
    NSValue *v1 = [NSValue valueWithBytes:&p1 objCType:@encode(CGPoint)];
    NSValue *v2 = [NSValue valueWithBytes:&p2 objCType:@encode(CGPoint)];
    NSValue *v3 = [NSValue valueWithBytes:&p3 objCType:@encode(CGPoint)];
    NSValue *v4 = [NSValue valueWithBytes:&p4 objCType:@encode(CGPoint)];
    //将转换后的对象存入数组
    NSArray *points = @[v1,v2,v3,v4];
    //3. 如果要使用数组中的点,可以将对象转换成非对象类型
    CGPoint point;//准备一片内存空间
    for (NSValue *value in points) {
        [value getValue:&point];
        NSLog(@"x:%.0f y:%.0f",point.x,point.y);
    }
}
//CGPoint是SDK中结构体,提供了快捷方式进行对象与非对象之间的转换
- (IBAction)btntap2:(id)sender {
    CGPoint p1 = CGPointMake(10, 20);
    CGPoint p2 = CGPointMake(30, 40);
    CGPoint p3 = CGPointMake(50, 60);
    CGPoint p4 = CGPointMake(70, 80);
    
    //将这4个点结构体变量转成对象
    //CGPoint ==> NSValue
    NSValue *v1 = [NSValue valueWithCGPoint:p1];
    NSValue *v2 = [NSValue valueWithCGPoint:p2];
    NSValue *v3 = [NSValue valueWithCGPoint:p3];
    NSValue *v4 = [NSValue valueWithCGPoint:p4];
    NSArray *points = @[v1, v2, v3, v4];
    //将NSValue对象转换成点结构
    for (NSValue *v in points) {
        //NSValue ==> CGPoint
        CGPoint point = [v CGPointValue];
        NSLog(@"%.0f,%.0f", point.x, point.y);
    }
    
    //可以将NSInteger转换成NSValue吗?可以
    //但是,实际开发中这个问题由NSNumber类来解决
    NSInteger x1 = 10;
    NSInteger x2 = 20;
    NSInteger x3 = 30;
    //NSArray *numbers = @[x1, x2, x3];
    NSValue *vx1 = [NSValue valueWithBytes:&x1 objCType:@encode(NSInteger)];
    NSValue *vx2 = [NSValue valueWithBytes:&x2 objCType:@encode(NSInteger)];
    NSValue *vx3 = [NSValue valueWithBytes:&x3 objCType:@encode(NSInteger)];
    NSArray *numbers = @[vx1, vx2, vx3];
    for (NSValue *v in numbers) {
        //NSValue ==> NSInteger
        //1. 先准备一片空间
        NSInteger x;
        //2. 从NSValue中取值
        [v getValue:&x];
        //3. 使用取得的值
        NSLog(@"%ld", x);
    }
}
- (IBAction)btntap3:(id)sender {
    //将一些整数放入数组,1,2,3,4,5
    NSMutableArray *numbers = [NSMutableArray new];
    for(int i=1; i<=5; i++){
        //int ==> NSNumber
        NSNumber *n = [NSNumber numberWithInt:i];
        [numbers addObject:n];
    }
    int sum = 0;//和
    for (NSNumber *n in numbers) {
        //NSNumber ==> int
        sum += [n intValue];
    }
    NSLog(@"sum:%d", sum);
    
    //从iOS6开始的新用法
    //@1 相当于 [NSNumber numberWithInt:1]
    NSArray *nums = @[@1, @2, @3, @4, @5];
    sum = 0;
    for (NSNumber *n in nums) {
        sum += [n intValue];
    }
    NSLog(@"sum:%d", sum);
    
    //基本类型的变量转成NSNumber
    NSInteger ix = 12345;
    NSNumber *nix = [NSNumber numberWithInteger:ix];
    NSNumber *nix2 = @(ix);//iOS6 新用法
    nix2 = @(ix + 200);//[NSNumber numberWithInteger:(ix + 200)];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
