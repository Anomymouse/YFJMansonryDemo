//
//  YFJNewsTableViewCell.h
//  layoutDemo
//
//  Created by 小宸宸Dad on 16/5/3.
//  Copyright © 2016年 fj. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YFJCellModel.h"

@interface YFJNewsTableViewCell : UITableViewCell


@property (strong,nonatomic)YFJCellModel *cellModel;

/**cell展开的block*/
@property (strong,nonatomic)void(^cellExpandBlock)(BOOL isExpand);


@end
