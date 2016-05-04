//
//  YFJCellModel.h
//  layoutDemo
//
//  Created by 小宸宸Dad on 16/5/3.
//  Copyright © 2016年 fj. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YFJCellModel : NSObject

/**标题*/
@property (nonatomic, copy) NSString *titleStr;
/**新闻的详情*/
@property (nonatomic, copy) NSString *newsStr;

/**是否被展开*/
@property (nonatomic, assign) BOOL isExpand;

@end
