//
//  FactoryTool.m
//  ControlSystem
//
//  Created by 小宸宸Dad on 16/3/8.
//  Copyright © 2016年 fj. All rights reserved.
//

#import "FactoryTool.h"
#define FontSize ScreenWidth == 768 ? [UIFont systemFontOfSize:14]:[UIFont systemFontOfSize:18]
//系统的屏幕宽度
#define ScreenWidth CGRectGetWidth([UIScreen mainScreen].bounds)
//系统的屏幕高度
#define ScreenHeight CGRectGetHeight([UIScreen mainScreen].bounds)

@implementation FactoryTool


+ (UIButton *)factoryButton:(NSString *)title color:(UIColor *)color{
    
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    [button setTitle:title forState:UIControlStateNormal];
//    button.backgroundColor = color;
    button.layer.cornerRadius = 3;
    button.clipsToBounds = YES;
    button.titleLabel.font = FontSize;
    return button;
    
    
}


+ (UIButton *)factoryImageButton:(NSString *)imageStr width:(NSInteger)width{

    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *titleimage = [UIImage imageNamed:imageStr];
    [button setContentMode:UIViewContentModeScaleAspectFit];
    [button setImage:titleimage forState:UIControlStateNormal];
    button.backgroundColor = [UIColor clearColor];
    return button;

}



+ (UILabel *)factoryLabel:(NSString *)text color:(UIColor *)color size:(NSInteger)size{


    UILabel *label = [[UILabel alloc]init];
    label.textColor = color;
    label.text = text;
//    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:size];
    return label;

}

+ (UITextField *)factoryTextField:(NSString *)placeText color:(UIColor *)color size:(NSInteger)size{
    
    UITextField *textField = [[UITextField alloc]init];
    textField.placeholder = placeText;
    textField.textColor = color;
    textField.font = [UIFont systemFontOfSize:size];
    textField.layer.borderWidth = 1;
    textField.layer.borderColor = [UIColor grayColor].CGColor;
    textField.backgroundColor = [UIColor whiteColor];
    textField.layer.cornerRadius = 3;
    textField.clipsToBounds = YES;
    textField.textAlignment = NSTextAlignmentCenter;
    textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    textField.keyboardType = UIKeyboardTypeDecimalPad;
    return textField;

}

+ (UIImageView *)factoryImageView:(NSString *)imageStr{

    UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:imageStr]];
    return imageView;

}

+ (UIView *)factoryView:(UIColor *)color{
    
    UIView *view = [[UIView alloc]init];
    view.backgroundColor = color;
//    view.layer.borderColor = UIColor.blackColor.CGColor;
    view.layer.borderWidth = 1;
    return view;

}




@end
