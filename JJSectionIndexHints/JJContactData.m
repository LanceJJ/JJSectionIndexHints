//
//  JJContactData.m
//  JJSectionIndexHints
//
//  Created by Lance on 2018/4/28.
//  Copyright © 2018年 Lance. All rights reserved.
//

#import "JJContactData.h"
#import "ChineseToPinyin.h"

@implementation JJContactData

- (instancetype)init
{
    self = [super init];
    
    if (self) {
        //        初始化contactIndex类 只有初始化完成 才能够在下方循环中 调用addressBook类 添加联系人方法
        self.contactIndex = [[JJContactIndex alloc]init];
    }
    return self;
}

// 本地测试数据
- (void)myData
{
    for (int i = 0; i < 100; i++) {
        
        // 随机电话
        NSArray *segment =@[@"134",@"135",@"136",@"137",@"138",@"139",@"147",@"150",@"151",@"152",@"157",@"158",@"159",@"187",@"188",@"130",@"131",@"132",@"155",@"156",@"185",@"186",@"133",@"153",@"180",@"189"];
        
        NSInteger i = [segment count];
        
        NSString *number = [NSString stringWithFormat:@"%@%d",segment[arc4random()%i],(arc4random()%90000000 + 10000001)] ;
        
        NSString *contactPhoneNumber = number;
        
        
        // 随机姓名
        NSString *surname = @"啊鄂王李张刘陈杨黄赵吴周徐孙马朱胡郭何高林郑谢罗梁宋唐许韩冯邓曹彭曾肖田董袁潘于蒋蔡余杜叶程苏魏吕丁任沈姚卢姜崔钟谭陆汪范金石廖贾夏韦付方白邹孟熊秦邱江尹薛闫段雷侯龙史陶黎贺顾毛郝龚邵万钱严覃武戴莫孔向汤阿锕凸";
        
        NSString *sur = [surname substringWithRange:NSMakeRange(arc4random()%[surname length], 1)];
        
        NSString *lastname = @"嘉哲俊博妍乐佳涵晨宇怡泽子凡悦思奕依浩泓彤冰媛凯伊淇淳一洁茹清吉源渊和函妤宜云琪菱宣沂健信欣可洋萍荣榕含佑明雄梅芝英义淑卿乾亦芬萱昊芸天岚昕尧鸿棋琳孜娟宸林乔琦丞安毅凌泉坤晴竹娴婕恒渝菁龄弘佩勋宁元栋盈江卓春晋逸沅倩昱绮海圣承民智棠容羚峰钰涓新莉恩羽妮旭维家泰诗谚阳彬书苓汉蔚坚茵耘喆国仑良裕融致富德易虹纲筠奇平蓓真之凰桦玫强村沛汶锋彦延庭霞冠益劭钧薇亭瀚桓东滢恬瑾达群茜先洲溢楠基轩月美心茗丹森学文";
        
        NSString *name1 = [lastname substringWithRange:NSMakeRange(arc4random()%[lastname length], 1)];
        NSString *name2 = [lastname substringWithRange:NSMakeRange(arc4random()%[lastname length], 1)];
        
        NSString *contactName =  [NSString stringWithFormat:@"%@%@%@",sur,name1,name2];
        
        
        //        取联系人的姓名 并且转化成拼音 取首字母 当做该联系人的分组
        NSString *group = [[ChineseToPinyin pinyinFromChiniseString:contactName] substringToIndex:1];
        
        
        //        添加联系人方法 每一次循环都要添加一次
        [self.contactIndex addContactWithName:contactName phone:contactPhoneNumber group:group];
        
    }
    
}

@end
