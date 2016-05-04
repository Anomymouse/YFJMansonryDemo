//
//  CalendarViewController.m
//  layoutDemo
//
//  Created by 小宸宸Dad on 16/5/4.
//  Copyright © 2016年 fj. All rights reserved.
//

#import "CalendarViewController.h"
#import "YFJCalendarView.h"

@interface CalendarViewController ()

@property (strong,nonatomic)YFJCalendarView *calendarView;

@end

@implementation CalendarViewController


- (void)viewDidLoad{

    [super viewDidLoad];
    
}

- (YFJCalendarView *)calendarView{
    
    if (!_calendarView) {
        
        _calendarView = [[YFJCalendarView alloc]initWithFrame:CGRectZero];
        UISwipeGestureRecognizer *leftSwipeGestureRecognizer = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(leftSwipeAction)];
        leftSwipeGestureRecognizer.direction = UISwipeGestureRecognizerDirectionLeft;
        [_calendarView addGestureRecognizer:leftSwipeGestureRecognizer];
        
        UISwipeGestureRecognizer *rightSwipeGestureRecognizer = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(rightSwipeAction)];
        rightSwipeGestureRecognizer.direction = UISwipeGestureRecognizerDirectionRight;
        [_calendarView addGestureRecognizer:rightSwipeGestureRecognizer];
        [self.view addSubview:_calendarView];
    }
    return _calendarView;
    
    
}



- (void)initializeViews{
    
    [super initializeViews];
    
    [self.calendarView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        
        make.edges.equalTo(self.view);
        
    }];


}

#pragma mark - 左滑切换日期
- (void)leftSwipeAction{
    
    [self swipeFactoryAction:1];
    
}



#pragma mark - 右滑切换日期
- (void)rightSwipeAction{
    
    [self swipeFactoryAction:2];
    
}

- (void)swipeFactoryAction:(NSInteger )type{
    
    NSLog(@"%@",self.calendarView.nowItem.dateStr);
    NSString *str = self.calendarView.nowItem.dateStr;
    NSInteger year = [[str substringToIndex:4] integerValue];
    NSString *resultStr= nil;
    NSRange range;
    range.location = 5;
    range.length = str.length-5;
    NSString *monthStr = [str substringWithRange:range];
    NSRange range1 = [monthStr rangeOfString:@"-"];
    NSInteger month = 1;
    if (range1.location != NSNotFound) {
        
        month = [[monthStr substringToIndex:range1.location]integerValue];
    }
    if (type == 1) {
        if (month++ >= 12) {
            year ++;
            month = 1;
        }
    }
    if (type == 2) {
        if (month-- <= 1) {
            year --;
            month = 12;
        }
    }
    
    resultStr = [NSString stringWithFormat:@"%ld年%ld月",year,month];
    monthStr = month<10?[NSString stringWithFormat:@"0%ld",month]:[NSString stringWithFormat:@"%ld",month];
    [self.calendarView initlizeViews:resultStr];
    
    
}



@end
