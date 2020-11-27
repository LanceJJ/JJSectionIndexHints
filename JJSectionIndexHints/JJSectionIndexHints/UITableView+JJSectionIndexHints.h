//
//  UITableView+JJSectionIndexHints.h
//  JJSectionIndexHints
//
//  Created by Lance on 2018/4/28.
//  Copyright © 2018年 Lance. All rights reserved.
//  v1.0.1

#import <UIKit/UIKit.h>

@interface UITableView (JJSectionIndexHints)

/**
 Description 添加索引显示
 
 @param allKeyArray 索引字母 A-Z
 @param tintColor 字母颜色
 @param font 字母大小
 */
- (void)addSectionIndexWithAllKeyArray:(NSArray *)allKeyArray tintColor:(UIColor *)tintColor font:(UIFont *)font;

@end
