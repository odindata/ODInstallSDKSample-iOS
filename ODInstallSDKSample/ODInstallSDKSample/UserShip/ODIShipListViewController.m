//
//  ODIShipListViewController.m
//  ODInstallSDKSample
//
//  Created by nathan on 2020/5/23.
//  Copyright © 2020 odin. All rights reserved.
//

#import "ODIShipListViewController.h"
#import "ODIUShipListCell.h"
#import "UIColor+ODExtension.h"
#import "ODInstallHeader.h"
#import "ODIUShipListSectionHeaderView.h"
#import "ODHttpTool.h"
#import "ODInstallHeader.h"
#import "NSString+ODIExtension.h"
#import "MBProgressHUD+Extension.h"
#import "MBProgressHUD.h"

@interface ODIShipListViewController ()

@end

@implementation ODIShipListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.rowHeight = 100;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerClass:[ODIUShipListCell class] forCellReuseIdentifier:NSStringFromClass([ODIUShipListCell class])];
    [self.tableView registerClass:[ODIUShipListSectionHeaderView class] forHeaderFooterViewReuseIdentifier:NSStringFromClass([ODIUShipListSectionHeaderView class])];
    
    [self loadData];
}

- (void)loadData{
    NSString *userId = [NSString currentUserId];
    NSMutableArray *userData = [NSMutableArray arrayWithArray:@[
        @{
            @"title":@"我的账号",
            @"users":@[@{@"imgIcon":@"us_00",@"userId":userId}]
        }
    ]];
    
    NSString *upUserId = [NSString upUserId];
    if (upUserId) {
        [userData addObject:@{
            @"title":@"父级关系",
            @"users":@[@{@"imgIcon":@"us_01",@"userId":upUserId}]
        }];
    }
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [ODHttpTool getWithUrlString:ODIUserPath parameters:@{@"userId":userId} success:^(NSDictionary * _Nonnull data) {
    
        NSArray *userDataArrary = (NSArray *)data;
        NSMutableArray *userIdArray = [NSMutableArray array];
        for (NSString *userId in userDataArrary) {
            if (![userId isMemberOfClass:[NSNull class]]) {
                [userIdArray addObject:@{@"imgIcon":@"us_02",@"userId":userId}];
            }
        }
        if (userIdArray.count>0) {
            [userData addObject:@{@"title":@"子集关系",@"users":userIdArray}];
        }
      
        self.data = userData;
        dispatch_async(dispatch_get_main_queue(), ^{
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            [self.tableView reloadData];
        });
    } failure:^(NSError * _Nonnull error) {
        if (error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [MBProgressHUD hideHUDForView:self.view animated:YES];
                [MBProgressHUD showTitle:@"数据获取失败"];
            });
        }
    }];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return self.data.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSArray *data = self.data[section][@"users"];
    return data.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ODIUShipListCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([ODIUShipListCell class]) forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    NSArray *data = self.data[indexPath.section][@"users"];
    cell.userDic =  data[indexPath.row];
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    ODIUShipListSectionHeaderView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:NSStringFromClass([ODIUShipListSectionHeaderView class])];
    if (headerView == nil) {
        headerView = [[ODIUShipListSectionHeaderView alloc] initWithReuseIdentifier:NSStringFromClass([ODIUShipListSectionHeaderView class])];
    }
    headerView.text = self.data[section][@"title"];
    return headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 44;
}

- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section{
    UITableViewHeaderFooterView *header = (UITableViewHeaderFooterView *)view;
    header.contentView.backgroundColor = [UIColor whiteColor];
}

@end
