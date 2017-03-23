//
//  SearchVC.m
//  PlistDemo
//
//  Created by 邱圣军 on 2017/3/22.
//  Copyright © 2017年 邱圣军. All rights reserved.
//

#import "SearchVC.h"

@interface SearchVC ()

@property (copy, nonatomic) NSString *docPath;

@end

@implementation SearchVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStyleGrouped];
    [self setAutomaticallyAdjustsScrollViewInsets:NO];
    
    self.docPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    self.resultArr = [[NSMutableArray alloc] init];
}

- (void)updateSearchResultsForSearchController:(UISearchController *)searchController {
    [self.resultArr removeAllObjects];
    
    NSFileManager *fm = [NSFileManager defaultManager];
    NSArray *plistArr = [fm subpathsOfDirectoryAtPath:self.docPath error:nil];
    
    NSMutableArray *dataArr = [[NSMutableArray alloc] init];
    for (int i = 0;i < plistArr.count;i++) {
        NSString *fileName = [plistArr objectAtIndex:i];
        NSString *filePath = [NSString stringWithFormat:@"%@/%@",self.docPath,fileName];
        NSMutableDictionary *plistDict = [[NSMutableDictionary alloc] initWithContentsOfFile:filePath];
        NSArray *arr = plistDict.allValues;
        [dataArr addObjectsFromArray:arr];
    }
    
    [dataArr addObjectsFromArray:plistArr];

    for (NSString *keyStr in dataArr) {
        if ([keyStr containsString:searchController.searchBar.text]) {
            [self.resultArr addObject:keyStr];
        }
    }
    
    [self.tableView reloadData];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return @"Result:";
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.resultArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *reuseID = @"reuseid";
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:reuseID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:reuseID];
    }
    
    cell.textLabel.text = [self.resultArr objectAtIndex:indexPath.row];
    
    return cell;
}

- (void)viewWillAppear:(BOOL)animated {
    self.tableView.frame = CGRectMake(0, 64, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.width);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
