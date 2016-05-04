//
//  YFJCalendarView.h
//  layoutDemo
//
//  Created by 小宸宸Dad on 16/5/4.
//  Copyright © 2016年 fj. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WHUCalendarCal.h"
#import "WHUCalendarItem.h"

@interface YFJCalendarView : UIView


/**本月第一天对应的数据模型,方便左右滑动的时候计算当前页面是第几月*/
@property (strong,nonatomic)WHUCalendarItem *nowItem;

- (void)initlizeViews:(NSString *)dateStr;


@end
