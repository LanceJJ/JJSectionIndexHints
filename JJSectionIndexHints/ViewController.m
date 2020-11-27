//
//  ViewController.m
//  JJSectionIndexHints
//
//  Created by Lance on 2018/4/28.
//  Copyright © 2018年 Lance. All rights reserved.
//

#import "ViewController.h"
#import "UITableView+JJSectionIndexHints.h"
#import "JJContactModel.h"
#import "JJContactData.h"

@interface ViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) JJContactData *contactData;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"通讯录";
    self.navigationController.navigationBar.translucent = NO;
    
    [self setupTableView];
}

- (void)setupTableView
{
    self.contactData = [[JJContactData alloc] init];
    //    调用模拟数据
    [self.contactData myData];
    
    //    创建tableView
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 64) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.rowHeight = 60;
    [self.view addSubview:_tableView];
    
    //添加索引显示
    [self.tableView addSectionIndexWithAllKeyArray:_contactData.contactIndex.allKeyArray tintColor:nil font:nil];
}

#pragma mark --返回分区个数--
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _contactData.contactIndex.allKeyArray.count;
}
#pragma mark --返回每个分区下有多少行--
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //    找到当前这个分区 key 就是A- Z 之中的一个分区
    NSString *key = [_contactData.contactIndex.allKeyArray objectAtIndex:section];
    //    在根据key 找到与其 对应的数组
    NSArray *everyContactArray = [_contactData.contactIndex.allContactDic objectForKey:key];
    
    return everyContactArray.count;
    
}
#pragma mark --返回cell方法--
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIndentifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIndentifier];
    }
    //    找到分区
    NSString *key = _contactData.contactIndex.allKeyArray[indexPath.section];
    //    找到与该分区对应的数组
    NSArray *array = [_contactData.contactIndex.allContactDic objectForKey:key];
    //    找到该数组中对应的联系人
    JJContactModel *contact = array[indexPath.row];
    cell.textLabel.text = contact.name;
    cell.detailTextLabel.text = contact.phone;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

#pragma mark --赋值每个分区的标题--
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSString *key = _contactData.contactIndex.allKeyArray[section];
    //    如果该分区下所对应的数组 没有一个联系人 我们则不显示该分区的标题 如果有联系人 我们才显示该分区下的标题
    NSArray *everyContactArray = [_contactData.contactIndex.allContactDic objectForKey:key];
    if (everyContactArray.count != 0) {
        return key;
    }
    return nil;
}
//#pragma mark --返回右边标题--
//- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
//{
//    return _contactData.contactIndex.allKeyArray;
//}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
