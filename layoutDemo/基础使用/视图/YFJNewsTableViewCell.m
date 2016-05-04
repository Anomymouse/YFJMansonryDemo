//
//  YFJNewsTableViewCell.m
//  layoutDemo
//
//  Created by 小宸宸Dad on 16/5/3.
//  Copyright © 2016年 fj. All rights reserved.
//

#import "YFJNewsTableViewCell.h"
#import "UITableViewCell+FYJMasonryCellHeight.h"
#import "FactoryTool.h"
#import "Masonry.h"

@interface YFJNewsTableViewCell ()

/**显示标题的label*/
@property (nonatomic, strong) UILabel *titleLabel;

/**显示新闻详情的Label*/
@property (nonatomic, strong) UILabel *newsLabel;

/**当前cell的一个按钮*/
@property (nonatomic, strong) UIButton *button;

/**当前cell的news是否已经展开*/
@property (nonatomic, assign) BOOL isExpanded;


@end

@implementation YFJNewsTableViewCell



- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{


    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self loadViews];
    }
    return self;


}

#pragma mark - 加载当前cell的Views
- (void)loadViews{

    //初始化views
    UIColor *color = [UIColor blackColor];
    self.titleLabel = [FactoryTool factoryLabel:@"标题" color:color size:16];
    self.newsLabel = [FactoryTool factoryLabel:@"新闻内容" color:color size:20];
    self.newsLabel.numberOfLines = 0;
    CGFloat w = [UIScreen mainScreen].bounds.size.width;
    // 应该始终要加上这一句
    // 不然在6/6plus上就不准确了
    self.newsLabel.preferredMaxLayoutWidth = w - 30;
    [self.newsLabel sizeToFit];
    self.newsLabel.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(expandedAction)];
    [self.newsLabel addGestureRecognizer:tap];
    
    self.button = [FactoryTool factoryButton:@"👆点上面可以展开👆" color:color];
     [self.button setBackgroundColor:[UIColor greenColor]];
    self.lastView = self.button;
    self.lastViewOffsetToCellBottom = 20;
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.newsLabel];
    [self.contentView addSubview:self.button];
    
    //设置views的约束
    
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(15);
        make.top.mas_equalTo(20);
        make.right.mas_equalTo(-15);
        make.height.mas_lessThanOrEqualTo(80);//设置高度最少为80
    }];
    
    [self.newsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.right.equalTo(self.titleLabel);
        make.top.mas_equalTo(self.titleLabel.mas_bottom).offset(15);
        
    }];
    [self.button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.right.mas_equalTo(-15);
        make.height.mas_equalTo(45);
        make.top.mas_equalTo(self.newsLabel.mas_bottom).offset(40);
    }];
    
    
    
}

#pragma mark - 点击cell的新闻详情，展开cell
- (void)expandedAction{


    self.cellExpandBlock(!self.isExpanded);
    


}


- (void)setCellModel:(YFJCellModel *)cellModel{

    self.titleLabel.text = cellModel.titleStr;
    self.newsLabel.text = cellModel.newsStr;
    self.isExpanded = cellModel.isExpand;
    if (self.isExpanded) {
        
        //cell已经被展开了,收回cell
        
        [self.newsLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            
            make.left.right.equalTo(self.titleLabel);
            make.top.mas_equalTo(self.titleLabel.mas_bottom).offset(15);
            
        }];
        
        
    }else{
    
        [self.newsLabel mas_updateConstraints:^(MASConstraintMaker *make){
            
            make.height.mas_lessThanOrEqualTo(60);
            
        }];
    
    
    }


}





@end
