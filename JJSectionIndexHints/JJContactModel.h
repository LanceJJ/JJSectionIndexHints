//
//  JJContactModel.h
//  JJSectionIndexHints
//
//  Created by Lance on 2018/4/28.
//  Copyright © 2018年 Lance. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JJContactModel : NSObject

//姓名
@property (nonatomic, copy) NSString *name;
//电话
@property (nonatomic, copy )NSString *phone;
//分组
@property (nonatomic, copy) NSString *group;

@end
