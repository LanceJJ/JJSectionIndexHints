//
//  ContactIndex.h
//  JLXSectionIndexHints
//
//  Created by Huatan on 2017/10/16.
//  Copyright © 2017年 huatan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ContactIndex : NSObject

//声明一个装载所有key值的数组 所有key值 相当于A-Z
@property(nonatomic, strong) NSArray *allKeyArray;
//声明一个装载所有联系人的字典
@property(nonatomic, strong) NSMutableDictionary *allContactDic;

//添加联系人
- (void)addContactWithName:(NSString *)name phone:(NSString *)phone group:(NSString *)group;

@end
