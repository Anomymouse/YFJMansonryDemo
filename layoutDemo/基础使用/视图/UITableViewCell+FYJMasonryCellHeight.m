//
//  UITableViewCell+FYJMasonryCellHeight.m
//  layoutDemo
//
//  Created by 小宸宸Dad on 16/5/3.
//  Copyright © 2016年 fj. All rights reserved.
//

#import "UITableViewCell+FYJMasonryCellHeight.h"
#import <objc/runtime.h>
const void *lastViewInCellKey = "lastViews";
const void *bottomOffsetToCellKey = "lastViewOffsetToCellBottom";

@implementation UITableViewCell (FYJMasonryCellHeight)



+ (CGFloat)Yfj_CellHeight:(UITableView *)tableView config:(YFJCellConfigBlock)config{
    static NSString *cellID = @"cell";
    UITableViewCell *cell = [[self alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    if (config) {
        
        config(cell);
    }
    
    return  [cell handle_fyj_CellHeight];
    

}

- (UIView *)lastView {
    return objc_getAssociatedObject(self, lastViewInCellKey);
}

- (void)setLastView:(UIView *)lastView{

    objc_setAssociatedObject(self,
                             lastViewInCellKey,
                             lastView,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);

}

- (void)setLastViewOffsetToCellBottom:(CGFloat)height {
    objc_setAssociatedObject(self,
                             bottomOffsetToCellKey,
                             @(height),
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (CGFloat)lastViewOffsetToCellBottom{

    NSNumber *valueObject = objc_getAssociatedObject(self, bottomOffsetToCellKey);
    
    if ([valueObject respondsToSelector:@selector(floatValue)]) {
        return valueObject.floatValue;
    }
    
    return 0.0;

}


#pragma mark - 计算cell高度
- (CGFloat)handle_fyj_CellHeight {
    NSAssert(self.lastView != nil, @"未指定cell排列中最后一个视图对象，无法计算cell的高度");
    NSLog(@"%@",NSStringFromCGRect(self.lastView.frame));
    [self layoutIfNeeded];
    NSLog(@"%@",NSStringFromCGRect(self.lastView.frame));
    CGFloat rowHeight = self.lastView.frame.size.height + self.lastView.frame.origin.y;
    rowHeight += self.lastViewOffsetToCellBottom;
    
    return rowHeight;
}


@end
