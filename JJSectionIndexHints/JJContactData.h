//
//  JJContactData.h
//  JJSectionIndexHints
//
//  Created by Lance on 2018/4/28.
//  Copyright © 2018年 Lance. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JJContactIndex.h"

@interface JJContactData : NSObject

@property(nonatomic, strong) JJContactIndex *contactIndex;

- (void)myData;

@end
