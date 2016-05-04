//
//  BaseViewController.m
//  layoutDemo
//
//  Created by 小宸宸Dad on 16/5/3.
//  Copyright © 2016年 fj. All rights reserved.
//

#import "BaseViewController.h"
#import "MasonryTabelViewController.h"

@interface BaseViewController ()

@property (strong,nonatomic)UIView *greenView;
@property (strong,nonatomic)UIView *redView;
@property (strong,nonatomic)UIView *yellowView;

@end

@implementation BaseViewController

#pragma mark - 懒加载

- (UIView *)greenView{

    if (!_greenView) {
        
        _greenView = [FactoryTool factoryView:[UIColor greenColor]];
        [self.view addSubview:_greenView];
    }
    return _greenView;

}

- (UIView *)redView{
    
    if (!_redView) {
        
        _redView = [FactoryTool factoryView:[UIColor redColor]];
        [self.view addSubview:_redView];
    }
    return _redView;
    
}

- (UIView *)yellowView{
    
    if (!_yellowView) {
        
        _yellowView = [FactoryTool factoryView:[UIColor yellowColor]];
        [self.view addSubview:_yellowView];
    }
    return _yellowView;
    
}





- (void)viewDidLoad {
    [super viewDidLoad];
    [self test2];
    
}







#pragma mark - 三个view以相等间隙水平显示
- (void)test1{

    float padding = 10;
    //方法1
    [self.greenView mas_makeConstraints:^(MASConstraintMaker *make) {
    
        make.left.equalTo(self.view).offset(padding);
        make.right.equalTo(self.redView.mas_left).offset(-padding);
        make.height.equalTo(@100);
        make.top.equalTo(@100);
        make.width.equalTo(self.redView);
    }];
    
    [self.redView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.greenView.mas_right).offset(padding);
        make.top.height.equalTo(self.greenView);
        make.right.equalTo(self.yellowView.mas_left).offset(-padding);
        make.width.equalTo(self.yellowView);
    }];
    
    [self.yellowView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.redView.mas_right).offset(padding);
        make.right.equalTo(self.view.mas_right).offset(-padding);
        make.top.height.equalTo(self.redView);
        make.width.equalTo(self.greenView);
    }];

    //方法2
//    NSArray *array = @[self.greenView,self.redView,self.yellowView];
//    [array mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:padding leadSpacing:padding tailSpacing:padding];
//
//    [array mas_makeConstraints:^(MASConstraintMaker *make) {
//       
//        make.height.top.equalTo(@100);
//    }];
    
    


}

#pragma mark - 三个view以相等间隙垂直显示
- (void)test2{

    float padding = 10;
    //方法1:
    [self.greenView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.equalTo(self.view).offset(padding);
        make.width.equalTo(self.view).multipliedBy(0.9);
        make.centerX.equalTo(self.view);
        make.height.equalTo(self.view).multipliedBy(0.2);
    }];
    
    [self.redView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.equalTo(self.greenView.mas_bottom).offset(padding);
        make.width.left.equalTo(self.greenView);
        make.height.equalTo(self.view).multipliedBy(0.3);
    }];
    
    [self.yellowView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.equalTo(self.redView.mas_bottom).offset(padding);
        make.width.left.equalTo(self.redView);
        make.bottom.equalTo(self.view).offset(-padding);
        
    }];
    //方法2
//    NSArray *array = @[self.greenView,self.redView,self.yellowView];
//    
//    [array mas_distributeViewsAlongAxis:MASAxisTypeVertical withFixedSpacing:padding leadSpacing:padding tailSpacing:padding];
//    [array mas_makeConstraints:^(MASConstraintMaker *make) {
//       
//        make.width.equalTo(self.view).multipliedBy(0.9);
//        make.centerX.equalTo(self.view);
//        
//    }];


}






@end
