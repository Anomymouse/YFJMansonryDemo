//
//  ViewController.m
//  layoutDemo
//
//  Created by 小宸宸Dad on 16/2/22.
//  Copyright © 2016年 fj. All rights reserved.
//

#import "ViewController.h"
#import "Masonry.h"
#import "BaseViewController.h"
#import "MasonryTabelViewController.h"
#import "CalendarViewController.h"

@interface ViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSArray *dataSource;
@property (nonatomic, strong) UITableView *tableView;

@end

@implementation ViewController


#pragma mark - 懒加载


- (NSArray *)dataSource{
    
    if (!_dataSource) {
        _dataSource = @[[[BaseViewController alloc]initWithTitle:@"Masonry基础"],[[MasonryTabelViewController alloc]initWithTitle:@"cell高度计算 With mansonry"],[[CalendarViewController alloc]initWithTitle:@"Mansonry 日历布局"]];
    }
    return _dataSource;
    
    
}

- (UITableView *)tableView{
    
    if (!_tableView) {
        
        _tableView = [[UITableView alloc] init];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [self.view addSubview:_tableView];
    }
    return _tableView;
    
    
}



- (void)viewDidLoad {
    [super viewDidLoad];
    //加载tableView的约束
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.edges.equalTo(self.view);
    }];
    
    
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

     return  self.dataSource.count;

}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    static NSString *cellID = @"cell";
    UIViewController *viewController = self.dataSource[indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    cell.textLabel.text = viewController.title;
    return cell;
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [self.tableView deselectRowAtIndexPath:indexPath animated:NO];
    UIViewController *viewController = self.dataSource[indexPath.row];
    [self.navigationController pushViewController:viewController animated:YES];
    
}



- (void)test2{

    UIScrollView *scrollView = [[UIScrollView alloc]init];
    scrollView.backgroundColor = [UIColor blueColor];
    [self.view addSubview:scrollView];
    
    [scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.edges.equalTo(self.view).insets(UIEdgeInsetsMake(5, 5, 5, 5));
        
    }];
    
    UIView *container = [[UIView alloc]init];
    [scrollView addSubview:container];
    
    [container mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.edges.equalTo(scrollView);
        make.width.equalTo(scrollView);
        
    }];
    
    int count = 10;
    UIView *lastView = nil;
    for (int i = 0; i < count; i ++) {
        
        UIView *subView = [[UIView alloc]init];
        subView.backgroundColor = [UIColor colorWithHue:( arc4random() % 256 / 256.0 )
                                             saturation:( arc4random() % 128 / 256.0 ) + 0.5
                                             brightness:( arc4random() % 128 / 256.0 ) + 0.5
                                                  alpha:1];
        [container addSubview:subView];
        [subView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.and.right.equalTo(container);
            make.height.equalTo(@(20*i));
            
            if (lastView) {
                
                make.top.equalTo(lastView.mas_bottom);
            }else{
                
                make.top.equalTo(container.mas_top);
                
            }
            
        }];
        lastView = subView;
        
    }
    
    [container mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.bottom.equalTo(lastView.mas_bottom);
        
    }];

}



- (void)test1{

    UIView *blueView = [[UIView alloc]init];
    blueView.backgroundColor = [UIColor blueColor];
    [self.view addSubview:blueView];
    
    UIView *redView = [[UIView alloc]init];
    redView.backgroundColor = [UIColor redColor];
    [self.view addSubview:redView];
    
    int padding = 10;
    
    [blueView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.view.mas_left).with.offset(padding);
        make.centerY.equalTo(self.view.mas_centerY);
        make.right.equalTo(redView.mas_left).with.offset(-padding);
        make.height.equalTo(@150);
        make.width.equalTo(redView);
    }];
    
    [redView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(blueView.mas_right).with.offset(padding);
        make.right.equalTo(self.view.mas_right).with.offset(-padding);
        make.width.height.top.equalTo(blueView);
    }];
    

}






@end
