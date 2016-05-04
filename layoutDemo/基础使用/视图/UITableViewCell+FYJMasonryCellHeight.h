//
//  UITableViewCell+FYJMasonryCellHeight.h
//  layoutDemo
//
//  Created by 小宸宸Dad on 16/5/3.
//  Copyright © 2016年 fj. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^YFJCellConfigBlock)(UITableViewCell *cell);

@interface UITableViewCell (FYJMasonryCellHeight)


/**当前cell中最后一个view*/
@property (strong,nonatomic)UIView *lastView;

/**最后一个view到当前cell底部的间隙*/
@property (assign,nonatomic)CGFloat lastViewOffsetToCellBottom;

+ (CGFloat)Yfj_CellHeight:(UITableView *)tableView config:(YFJCellConfigBlock)config;


@end
