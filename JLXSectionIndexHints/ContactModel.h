//
//  ContactModel.h
//  JLXSectionIndexHints
//
//  Created by Huatan on 2017/10/16.
//  Copyright © 2017年 huatan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ContactModel : NSObject

//姓名
@property(nonatomic, copy)NSString *name;
//电话
@property(nonatomic, copy)NSString *phone;
//分组
@property(nonatomic, copy)NSString *group;

@end
