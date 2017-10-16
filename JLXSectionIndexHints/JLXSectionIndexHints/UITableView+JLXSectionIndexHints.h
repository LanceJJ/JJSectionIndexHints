//
//  UITableView+JLXSectionIndexHints.h
//  JLXSectionIndexHints
//
//  Created by Huatan on 2017/10/16.
//  Copyright © 2017年 huatan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableView (JLXSectionIndexHints)

/**
 Description 添加索引显示

 @param allKeyArray 索引字母 A-Z
 @param tintColor 字母颜色
 @param font 字母大小
 */
- (void)addSectionIndexWithAllKeyArray:(NSArray *)allKeyArray tintColor:(UIColor *)tintColor font:(UIFont *)font;

@end
