//
//  SearchCenter.m
//  PlistDemo
//
//  Created by 邱圣军 on 2017/3/23.
//  Copyright © 2017年 邱圣军. All rights reserved.
//

#import "SearchCenter.h"
#import "SearchVC.h"

@interface SearchCenter ()<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate,UISearchControllerDelegate>

@property (weak, nonatomic) IBOutlet UITableView *searchTableView;
@property (strong, nonatomic) UISearchController *searchController;
@property (strong, nonatomic) SearchVC *searchVC;


@end

@implementation SearchCenter

- (void)viewDidLoad {
    [super viewDidLoad];
    self.searchTableView.tableHeaderView = self.searchController.searchBar;
}

- (UISearchController *)searchController {
    if (!_searchController) {
        _searchController = [[UISearchController alloc] initWithSearchResultsController:self.searchVC];
        _searchController.searchBar.placeholder = @"Search Plist Files";
        _searchController.searchResultsUpdater = self.searchVC;
        _searchController.searchBar.delegate = self;
        _searchController.delegate = self;
        self.definesPresentationContext = YES;
    }
    return _searchController;
}

- (SearchVC *)searchVC {
    if (!_searchVC) {
        _searchVC = [[SearchVC alloc] init];
    }
    return _searchVC;
}


- (IBAction)done:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *reuseID = @"reuseid";
    UITableViewCell *cell = [self.searchTableView dequeueReusableCellWithIdentifier:reuseID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:reuseID];
    }
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
