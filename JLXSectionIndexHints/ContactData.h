//
//  ContactData.h
//  JLXSectionIndexHints
//
//  Created by Huatan on 2017/10/16.
//  Copyright © 2017年 huatan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ContactIndex.h"

@interface ContactData : NSObject

@property(nonatomic, strong) ContactIndex *contactIndex;

- (void)myData;

@end
