//
//  HomeNavVC.m
//  PlistDemo
//
//  Created by 邱圣军 on 2017/3/22.
//  Copyright © 2017年 邱圣军. All rights reserved.
//

#import "HomeNavVC.h"

@interface HomeNavVC ()

@end

@implementation HomeNavVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationBar setBarTintColor:[UIColor blackColor]];
    [self.navigationBar setTintColor:[UIColor whiteColor]];
    [self.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont fontWithName:@"HelveticaNeue" size:17],NSForegroundColorAttributeName:[UIColor whiteColor]}];
    self.navigationBar.translucent = NO;
}

-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
