//
//  UITableView+JJSectionIndexHints.m
//  JJSectionIndexHints
//
//  Created by Lance on 2018/4/28.
//  Copyright © 2018年 Lance. All rights reserved.
//

#import "UITableView+JJSectionIndexHints.h"
#import <objc/runtime.h>


@interface UITableView ()

@property (nonatomic, strong) UILabel *centerLabel;
@property (nonatomic, strong) NSArray *allKeyArray;

@end

@implementation UITableView (JJSectionIndexHints)

/**
 Description 添加索引显示
 
 @param allKeyArray 索引字母 A-Z
 @param tintColor 字母颜色
 @param font 字母大小
 */
- (void)addSectionIndexWithAllKeyArray:(NSArray *)allKeyArray tintColor:(UIColor *)tintColor font:(UIFont *)font;
{
    if (![self.superview isKindOfClass:[UIView class]]) return;
    
    //设置默认颜色与字体大小
    tintColor = tintColor == nil ? self.superview.tintColor : tintColor;
    font = font == nil ? [UIFont boldSystemFontOfSize:12] : font;
    
    self.allKeyArray = allKeyArray;
    
    //右侧索引宽度（可重新设置）
    CGFloat groundViewW = 30;
    CGFloat indexViewW = groundViewW;
    //直接添加右侧索引的view距离底层view的y值，可改变索引高度
    CGFloat indexViewH = allKeyArray.count * 14;

    //用于直接添加右侧索引的view（高度可自定义）
    UIView *indexView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, indexViewW, indexViewH)];
    
    indexView.backgroundColor = [UIColor redColor];
    
    [self.superview addSubview:indexView];
    
    indexView.translatesAutoresizingMaskIntoConstraints = NO;

    NSLayoutConstraint *indexHeight = [NSLayoutConstraint constraintWithItem:indexView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeHeight multiplier:1.0 constant:indexViewH];

    [indexView addConstraint:indexHeight];
    
    NSLayoutConstraint *indexWeight = [NSLayoutConstraint constraintWithItem:indexView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeWidth multiplier:1.0 constant:indexViewW];

    [indexView addConstraint:indexWeight];

    NSLayoutConstraint *indexTop = [NSLayoutConstraint constraintWithItem:indexView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.superview attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0];
    [self.superview addConstraint:indexTop];
    
    NSLayoutConstraint *indexRight = [NSLayoutConstraint constraintWithItem:indexView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.superview attribute:NSLayoutAttributeRight multiplier:1.0 constant:0];
    [self.superview addConstraint:indexRight];
        
    
    NSInteger count = allKeyArray.count;
    
    //遍历循环 添加 索引字母 A-Z
    for (NSInteger i = 0; i < count; i++) {
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, indexViewH / count * i, indexViewW, indexViewH / count)];
        label.font = font;
        label.textColor = tintColor;
        label.textAlignment = NSTextAlignmentCenter;
        label.text = allKeyArray[i];
        
        [indexView addSubview:label];
    }
    
    //添加轻拍手势
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
    [indexView addGestureRecognizer:tap];
    
    //添加滑动手势
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panAction:)];
    [indexView addGestureRecognizer:pan];
    
    //中间字母显示的label
    UILabel *indexLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 80, 80)];
    
    indexLabel.font = [UIFont systemFontOfSize:32];
    indexLabel.textAlignment = NSTextAlignmentCenter;
    indexLabel.textColor = [UIColor whiteColor];
    indexLabel.backgroundColor = [UIColor colorWithRed:180.0 / 255.0 green:180.0 / 255.0 blue:180.0 / 255.0 alpha:0.8];
    indexLabel.layer.cornerRadius = 8;
    indexLabel.clipsToBounds = YES;
    indexLabel.center = CGPointMake([UIScreen mainScreen].bounds.size.width / 2, [UIScreen mainScreen].bounds.size.height / 2);
    indexLabel.alpha = 0;
    [[UIApplication sharedApplication].keyWindow.rootViewController.view addSubview:indexLabel];
    
    self.centerLabel = indexLabel;
}

- (void)tapAction:(UITapGestureRecognizer *)tap
{
    NSInteger index = [self touchIndexRecognizer:tap];
    
    [self scrollToRowWithIndex:index animated:YES];
}

- (void)panAction:(UIPanGestureRecognizer *)pan
{
    NSInteger index = [self touchIndexRecognizer:pan];
    
    [self scrollToRowWithIndex:index animated:NO];
}


/**
 Description 显示中间字母
 */
- (NSInteger)touchIndexRecognizer:(UIGestureRecognizer *)recognizer
{
    UIView *indexView = recognizer.view;
    
    CGFloat touchY = [recognizer locationInView:indexView].y;
    
    NSInteger index = touchY / indexView.bounds.size.height * self.allKeyArray.count;
    
    //防止滑动范围超出设置的索引范围造成中间字母显示错乱
    if (index < 0) {
        
        index = 0;
        
    } else if (index > self.allKeyArray.count - 1) {
        
        index = self.allKeyArray.count - 1;
    }
    
    self.centerLabel.text = self.allKeyArray[index];
    
    self.centerLabel.alpha = 1;
    
    if (recognizer.state == UIGestureRecognizerStateEnded) {
        
        [UIView animateWithDuration:0.3 animations:^{
            self.centerLabel.alpha = 0;
        }];
    }
    
    return index;
}

/**
 Description 跳转到指定位置
 */
- (void)scrollToRowWithIndex:(NSInteger)index animated:(BOOL)animated
{
    if ([self numberOfRowsInSection:index] == 0) return;
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:index];
    
    [self scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionTop animated:animated];
}


#pragma mark -- set 和 get 方法 --

- (void)setCenterLabel:(UILabel *)centerLabel
{
    objc_setAssociatedObject(self, @selector(centerLabel), centerLabel, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UILabel *)centerLabel
{
    return objc_getAssociatedObject(self, @selector(centerLabel));
}

- (void)setAllKeyArray:(NSArray *)allKeyArray
{
    objc_setAssociatedObject(self, @selector(allKeyArray), allKeyArray, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSArray *)allKeyArray
{
    return objc_getAssociatedObject(self, @selector(allKeyArray));
}

- (void)setGroundView:(UIView *)groundView
{
    objc_setAssociatedObject(self, @selector(groundView), groundView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIView *)groundView
{
    return objc_getAssociatedObject(self, @selector(groundView));
}

- (void)setIndexView:(UIView *)indexView
{
    objc_setAssociatedObject(self, @selector(indexView), indexView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIView *)indexView
{
    return objc_getAssociatedObject(self, @selector(indexView));
}


@end

