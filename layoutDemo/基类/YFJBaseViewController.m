//
//  YFJBaseViewController.m
//  layoutDemo
//
//  Created by 小宸宸Dad on 16/5/3.
//  Copyright © 2016年 fj. All rights reserved.
//

#import "YFJBaseViewController.h"

@interface YFJBaseViewController ()




@end

@implementation YFJBaseViewController

- (instancetype)initWithTitle:(NSString *)title {
    if (self = [super init]) {
        self.title = title;
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initializeDataSource];
    [self initializeViews];
   
}

- (void)initializeViews{

    if (IOSVersion >= 7.0) {
        self.automaticallyAdjustsScrollViewInsets = NO;
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    
    self.view.backgroundColor = [UIColor whiteColor];


}

- (void)initializeDataSource{




}





@end
