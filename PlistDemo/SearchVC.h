//
//  SearchVC.h
//  PlistDemo
//
//  Created by 邱圣军 on 2017/3/22.
//  Copyright © 2017年 邱圣军. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SearchVC : UITableViewController<UISearchResultsUpdating>

@property (strong, nonatomic) NSMutableArray *resultArr;

@end
