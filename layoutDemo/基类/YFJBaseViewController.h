//
//  YFJBaseViewController.h
//  layoutDemo
//
//  Created by 小宸宸Dad on 16/5/3.
//  Copyright © 2016年 fj. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FactoryTool.h"
#import "Masonry.h"

#define WeakObject(obj) __weak __typeof(obj) weakObject = obj;
#define IOSVersion ((float)[[[UIDevice currentDevice] systemVersion] doubleValue])
@interface YFJBaseViewController : UIViewController

- (instancetype)initWithTitle:(NSString *)title;
//初始化数据相关
- (void)initializeDataSource;
/**初始化当前页面的UI*/
- (void)initializeViews;

@end
