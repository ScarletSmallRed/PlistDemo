//
//  InfoTableVC.m
//  PlistDemo
//
//  Created by 邱圣军 on 2017/3/22.
//  Copyright © 2017年 邱圣军. All rights reserved.
//

#import "InfoTableVC.h"
#import "SearchVC.h"
#import "AddPlistVC.h"
#import "SearchCenter.h"

@interface InfoTableVC ()<UISearchBarDelegate,UISearchControllerDelegate>

@property (strong, nonatomic) AddPlistVC *addPlistVC;
@property (strong, nonatomic) SearchCenter *searchCenter;
@property (copy, nonatomic) NSString *docPath;

@end

@implementation InfoTableVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.docPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];

    self.title = @"PlistDemo";
    [self setAutomaticallyAdjustsScrollViewInsets:NO];

    [self setupNavBtn];
}

- (void)setupNavBtn {
    UIButton *addBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 25, 25)];
    [addBtn setImage:[UIImage imageNamed:@"add"] forState:UIControlStateNormal];
    [addBtn setImage:[UIImage imageNamed:@"add_selected"] forState:UIControlStateSelected];
    [addBtn addTarget:self action:@selector(addNewEvent) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightButtonItem = [[UIBarButtonItem alloc] initWithCustomView:addBtn];
    
    UIButton *addBtn1 = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 25, 25)];
    [addBtn1 setImage:[UIImage imageNamed:@"search"] forState:UIControlStateNormal];
    [addBtn1 setImage:[UIImage imageNamed:@"search_selected"] forState:UIControlStateSelected];
    [addBtn1 addTarget:self action:@selector(addSearchEvent) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightButtonItem1 = [[UIBarButtonItem alloc] initWithCustomView:addBtn1];
    
    self.navigationItem.rightBarButtonItems = @[rightButtonItem,rightButtonItem1];
}

- (void)addNewEvent {
    [self presentViewController:self.addPlistVC animated:YES completion:nil];
    [self.tableView reloadData];
}

- (AddPlistVC *)addPlistVC {
    if (!_addPlistVC) {
        _addPlistVC = [[AddPlistVC alloc] init];
    }
    return _addPlistVC;
}

- (void)addSearchEvent {
    [self presentViewController:self.searchCenter animated:YES completion:nil];
}

- (SearchCenter *)searchCenter {
    if (!_searchCenter) {
        _searchCenter = [[SearchCenter alloc] init];
    }
    return _searchCenter;
}


#pragma mark - TableView
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSFileManager *fm = [NSFileManager defaultManager];
    NSArray *docArr = [fm subpathsOfDirectoryAtPath:self.docPath error:nil];

    return docArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *reuseID = @"ruseid";
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:reuseID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:reuseID];
    }
    
    NSFileManager *fm = [NSFileManager defaultManager];
    NSArray *docArr = [fm subpathsOfDirectoryAtPath:self.docPath error:nil];
    
    NSString *cellName = [docArr objectAtIndex:indexPath.row];
    cell.textLabel.text = cellName;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        NSFileManager *fm = [NSFileManager defaultManager];
        NSArray *docArr = [fm subpathsOfDirectoryAtPath:self.docPath error:nil];
        
        NSString *fileName = [docArr objectAtIndex:indexPath.row];
        NSString *filePath = [NSString stringWithFormat:@"%@/%@",self.docPath,fileName];
        
        NSFileManager *manager = [NSFileManager defaultManager];
        [manager removeItemAtPath:filePath error:nil];
        
        [self.tableView reloadData];
    }
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end













