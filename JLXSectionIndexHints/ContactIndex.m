//
//  ContactIndex.m
//  JLXSectionIndexHints
//
//  Created by Huatan on 2017/10/16.
//  Copyright © 2017年 huatan. All rights reserved.
//

#import "ContactIndex.h"
#import "ContactModel.h"

@implementation ContactIndex

- (instancetype)init
{
    self = [super init];
    if (self) {
        //        装载所有key值的数组初始化
        self.allKeyArray = @[@"A",@"B",@"C",@"D",@"E",@"F",@"G",@"H",@"I",@"J",@"K",@"L",@"M",@"N",@"O",@"P",@"Q",@"R",@"S",@"T",@"U",@"V",@"W",@"X",@"Y",@"Z",@"#"];
        
        //        创建一个大数组 这个大数组 专门装载所有与key值对应的小数组 也就是所有value数组(这个大数组只是用来初始化用)
        NSMutableArray *allContactArray = [NSMutableArray array];
        
        //        循环创建创建装载与每一个key值对应的小数组
        for (int i = 0; i < _allKeyArray.count; i++) {
            //            总共创建26次 每一个小数组都是与26key值对应的value
            NSMutableArray *everyContactArray = [NSMutableArray array];
            [allContactArray addObject:everyContactArray];
        }
        
        //        初始化装载所有联系人的字典
        self.allContactDic = [NSMutableDictionary dictionaryWithObjects:allContactArray forKeys:_allKeyArray];
    }
    
    return self;
}

//添加联系人
- (void)addContactWithName:(NSString *)name phone:(NSString *)phone group:(NSString *)group
{
    //    该方法 是由data类里 每循环一次 就会调用一次
    //    相当于 每次在这个方法里 需要把model进行初始化 并且赋值新值
    ContactModel *contact = [[ContactModel alloc]init];
    contact.name = name;
    contact.phone = phone;
    contact.group = group;
    
    BOOL isHave = NO;
    
    for (NSString *key in self.allKeyArray) {
        
        isHave = [key isEqualToString:group] || isHave ? YES : NO;
        
    }
    
    NSMutableArray *everyContactArray = isHave ? [_allContactDic objectForKey:group] : [_allContactDic objectForKey:@"#"];
    
    //    根据分组 来找到对应的小数组 将小数组添加联系人
    //    分组就是联系人的名字 取首字母
    [everyContactArray addObject:contact];
}

@end
