//
//  MasonryTabelViewController.m
//  layoutDemo
//
//  Created by 小宸宸Dad on 16/5/3.
//  Copyright © 2016年 fj. All rights reserved.
//

#import "MasonryTabelViewController.h"
#import "YFJCellModel.h"
#import "YFJNewsTableViewCell.h"
#import "UITableViewCell+FYJMasonryCellHeight.h"

@interface MasonryTabelViewController ()<

    UITableViewDataSource,
    UITableViewDelegate

>

@property (strong,nonatomic)UITableView *tableView;

@property (strong,nonatomic)NSMutableArray *dataSource;

@end




@implementation MasonryTabelViewController

- (UITableView *)tableView{
    
    if (!_tableView) {
        
        _tableView = [[UITableView alloc] init];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [self.view addSubview:_tableView];
    }
    return _tableView;
    
    
}


- (NSMutableArray *)dataSource{
    
    if (!_dataSource) {
        
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
    
    
}



- (void)viewDidLoad {
    [super viewDidLoad];
    
    
}

- (void)initializeDataSource{

    [super initializeDataSource];
    NSString *title = @"督察组：河北省委原领导对环保不是真重视";
    NSString *news = @"(1)可以将类的实现分散到多个不同文件或多个不同框架中，方便代码管理。也可以对框架提供类的扩展（没有源码，不能修改）。(2)创建对私有方法的前向引用：如果其他类中的方法未实现，在你访问其他类的私有方法时编译器报错这时使用类别，在类别中声明这些方法（不必提供方法实现），编译器就不会再产生警告(3)向对象添加非正式协议：创建一个NSObject的类别称为“创建一个非正式协议”，因为可以作为任何类的委托对象使用。";
    for (int i = 0; i < 28; i ++) {
        
        NSUInteger titleLength = rand() % title.length + 10;
        titleLength            = titleLength > title.length - 1 ? title.length:titleLength;
        YFJCellModel *model    = [[YFJCellModel alloc]init];
        model.titleStr         = [title substringToIndex:titleLength];
        
        NSUInteger newsLength = rand() % news.length + 20;
        newsLength            = newsLength > news.length - 1 ? news.length:newsLength;
        
        model.newsStr          = [news substringToIndex:newsLength];
        [self.dataSource addObject:model];
    }

}


- (void)initializeViews{

    [super initializeViews];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.edges.equalTo(self.view);
    }];
    

}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return self.dataSource.count;


}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    static NSString *cellID = @"cell";
    YFJNewsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
    
        cell = [[YFJNewsTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    YFJCellModel *model = self.dataSource[indexPath.row];
    [cell setCellModel:model];
    
    cell.cellExpandBlock = ^(BOOL isExpand){
    
        model.isExpand = isExpand;
        //刷新tableView
        [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        
    
    };
    
    return cell;


}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    YFJCellModel *model = self.dataSource[indexPath.row];
    
    return [YFJNewsTableViewCell Yfj_CellHeight:tableView config:^(UITableViewCell *cell) {
        
        YFJNewsTableViewCell *souceCell = (YFJNewsTableViewCell *)cell;
        
        [souceCell setCellModel:model];
        
        
    }];


}





@end
