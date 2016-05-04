//
//  YFJCalendarView.m
//  layoutDemo
//
//  Created by 小宸宸Dad on 16/5/4.
//  Copyright © 2016年 fj. All rights reserved.
//

#import "YFJCalendarView.h"
#import "FactoryTool.h"
#import "Masonry.h"
#import "FJTapGestureRecognizer.h"
#import "MBProgressHUD+MJ.h"

#define weekMargin 10
#define CalendarWidth (CGRectGetWidth([UIScreen mainScreen].bounds) - weekMargin*8)/7.0


@interface YFJCalendarView ()

/**日历数据*/
@property (strong,nonatomic)NSArray *calendarArray;


/**日历数据模型*/
@property (strong,nonatomic)WHUCalendarCal *calendarModel;

/**第一个周控件*/
@property (strong,nonatomic)UIView *fristWeekView;

/**周一、周二.....周日的View*/
@property (strong,nonatomic)UIView *weekView;

/**存储周一、周二.....周日View的数组*/
@property (strong,nonatomic)NSMutableArray *weekArray;


/**上一次创建的日历的控件*/
@property (strong,nonatomic)UIView *lastCalendarView;


@end


@implementation YFJCalendarView


#pragma mark - 懒加载区域

- (UIView *)weekView{
    
    if (!_weekView) {
        
        _weekView = [[UIView alloc]init];
//        _weekView.backgroundColor = [UIColor redColor];
        [self addSubview:_weekView];
    }
    return _weekView;
    
    
}

- (NSMutableArray *)weekArray{
    
    if (!_weekArray) {
        
        _weekArray = [NSMutableArray array];
    }
    return _weekArray;
    
    
}

- (WHUCalendarCal *)calendarModel{
    
    if (!_calendarModel) {
        
        _calendarModel = [[WHUCalendarCal alloc]init];
    }
    return _calendarModel;
    
    
}




- (instancetype)initWithFrame:(CGRect)frame{
    
    
    if (self = [super initWithFrame:frame]) {
        
        [self loadViews];
    }
    return self;
    
    
    
}

#pragma mark - 加载当前view的子控件
- (void)loadViews{
    
    self.backgroundColor = [UIColor whiteColor];
    self.userInteractionEnabled = YES;
    NSDictionary *calendardic = [self.calendarModel  getCalendarMapWith:[_calendarModel stringFromDate:[NSDate date]]];
    NSLog(@"%@",calendardic);
    self.calendarArray = calendardic[@"dataArr"];
    [self loadWeekViews];
    [self loadClenderViews];
    
}

#pragma mark - 加载周视图
- (void)loadWeekViews{

    NSArray *weekArray = @[@"周日",@"周一",@"周二",@"周三",@"周四",@"周五",@"周六"];
    UIView *lastView = nil;
    
    [self.weekView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.right.with.equalTo(self);
        make.height.equalTo(@60);
        make.top.equalTo(self);
        
    }];
    
    for (int i = 0; i < weekArray.count; i ++) {
        
        UILabel *label = [FactoryTool factoryLabel:weekArray[i] color:[UIColor blackColor] size:14];
            label.textAlignment = NSTextAlignmentCenter;
        
        [self.weekView addSubview:label];
        
        //存储第一个周控件
        self.fristWeekView = i == 0 ? label : self.fristWeekView;
        
        //方法1:
        if (!lastView) {
            
            [label mas_remakeConstraints:^(MASConstraintMaker *make) {
                
                make.left.equalTo(self.weekView.mas_left).with.offset(weekMargin);
                make.centerY.equalTo(self.weekView.mas_centerY);
                make.width.equalTo(@(CalendarWidth));
            }];
            
        }else{
        
            [label mas_remakeConstraints:^(MASConstraintMaker *make) {
                
                make.left.equalTo(lastView.mas_right).with.offset(weekMargin);
                make.top.equalTo(lastView.mas_top);
                make.width.equalTo(lastView.mas_width);
            }];
        
        }
        [self.weekArray addObject:label];
        lastView = label;
        
    }
    
    //方法2
//    [self.weekArray mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:weekMargin leadSpacing:weekMargin tailSpacing:weekMargin];
//    [self.weekArray mas_makeConstraints:^(MASConstraintMaker *make) {
//        
//        make.centerY.equalTo(self.weekView);
//        
//    }];
//    
    

}

#pragma mark - 加载显示日历的视图
- (void)loadClenderViews{
    
    
    for (int i = 0; i < self.calendarArray.count; i ++) {
        
        WHUCalendarItem *calenItem = self.calendarArray[i];
        if (calenItem.day > 0) {
            
            UIView *tempView  = nil;
            NSInteger weekNumber = i % 7;
            weekNumber = weekNumber == 6 ? 0:weekNumber + 1;
            tempView = self.weekArray[weekNumber];
            
            [self handleFactoryFunction:calenItem centerView:tempView];
            
        }
        
    }
    
    
    
}



#pragma mark - 工厂模式批量生成单个日历View
- (void)handleFactoryFunction:(WHUCalendarItem *)item centerView:(UIView *)centerView{


    //日历背景图(选中有小圆标记)
    UIButton *bgView = [UIButton buttonWithType:UIButtonTypeSystem];
    bgView.userInteractionEnabled = YES;
    bgView.layer.cornerRadius = CalendarWidth/2.0;
    bgView.clipsToBounds = YES;
    //标记下，方便左右滑动时删除View
    bgView.tag = 1987;
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    [format setDateFormat:@"yyyy-M-d"];
    NSString  *dateStr = [format stringFromDate:[NSDate date]];
    //判断日期是不是今天
    if ([dateStr isEqualToString:item.dateStr]) {
        
        bgView.layer.borderWidth = 1;
        bgView.layer.borderColor = [UIColor colorWithRed:0.000 green:0.608 blue:0.722 alpha:1.000].CGColor;
    }
    
    [self addSubview:bgView];
    FJTapGestureRecognizer *tap = [[FJTapGestureRecognizer alloc]initWithTarget:self action:@selector(touchCalendarAction:)];
    tap.item = item;
    [bgView addGestureRecognizer:tap];


    
    //生成日期(多少号)
    UILabel *dateLabel   = [FactoryTool factoryLabel:@"11" color:[UIColor blackColor] size:14];
    dateLabel.textAlignment = NSTextAlignmentCenter;
    dateLabel.text = [NSString stringWithFormat:@"%ld",ABS(item.day)];
    [bgView addSubview:dateLabel];
    
    if (item.day == 1) {
        self.nowItem = item;
    }
    UILabel *nongliLabel = [FactoryTool factoryLabel:@"劳动节" color:[UIColor colorWithRed:0.255 green:0.259 blue:0.263 alpha:1.000] size:12];
    nongliLabel.text = item.holiday.length == 0 ?item.Chinese_calendar:item.holiday;
    nongliLabel.font = [UIFont systemFontOfSize:11];
    nongliLabel.textColor = [UIColor colorWithRed:0.255 green:0.259 blue:0.263 alpha:1.000];
    nongliLabel.textAlignment = NSTextAlignmentCenter;
    [bgView addSubview:nongliLabel];
    
    
    //设置约束
    
    if (!self.lastCalendarView) {
        
        //第一次创建日历控件
        [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.width.centerX.equalTo(centerView);
            make.top.equalTo(self.weekView.mas_bottom);
            make.height.equalTo(bgView.mas_width);
        }];
        
    }else{
    
        //已经创建过日历控件,根据上一个控件设置约束
        
        if (centerView == self.fristWeekView) {
            
            //又到一周的第一天了,换行显示
            
            [bgView mas_remakeConstraints:^(MASConstraintMaker *make) {

                make.width.equalTo(self.lastCalendarView.mas_width);
                make.left.equalTo(self.fristWeekView.mas_left);
                make.top.equalTo(self.lastCalendarView.mas_bottom).with.offset(weekMargin);
                make.height.equalTo(self.lastCalendarView.mas_height);
            }];
            
        }else{
        
            //不换行显示
            [bgView mas_remakeConstraints:^(MASConstraintMaker *make) {
                
                
                make.left.equalTo(self.lastCalendarView.mas_right).with.offset(weekMargin);
                make.top.width.height.equalTo(self.lastCalendarView);
                make.height.equalTo(bgView.mas_width);
            }];
            
            
            
        
        }
    
    
    
    }
    self.lastCalendarView = bgView;
    
    float padding = 2;
    [dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.equalTo(bgView.mas_top).offset(padding);
        make.bottom.equalTo(nongliLabel.mas_top).offset(-padding);
        make.left.equalTo(bgView);
        make.height.equalTo(@16);
        make.width.equalTo(bgView);
    }];
    [nongliLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(dateLabel.mas_bottom).offset(padding);
        make.centerX.equalTo(dateLabel);
        make.bottom.equalTo(bgView).offset(-padding);
        make.height.equalTo(@14);
        make.width.equalTo(bgView);
    }];
    

}

- (void)touchCalendarAction:(FJTapGestureRecognizer *)tap{
    
    for (UIView *view in self.subviews) {
        
        view.backgroundColor = [UIColor clearColor];
    }
    tap.view.backgroundColor = [UIColor colorWithRed:0.055 green:0.439 blue:0.514 alpha:0.7];
    NSLog(@"%@",tap.item);
    
    [MBProgressHUD showError:[NSString stringWithFormat:@"选中:%@",tap.item.dateStr]];
    
    
}

- (void)initlizeViews:(NSString *)dateStr{

    for (UIView *view in self.subviews) {
        
        if (view.tag == 1987) {
            
            [view removeFromSuperview];
        }
        
    }
    
    self.lastCalendarView = nil;
    NSDictionary  * calendardic = [self.calendarModel  getCalendarMapWith:dateStr];
    self.calendarArray = calendardic[@"dataArr"];
    [self loadClenderViews];


}

@end
