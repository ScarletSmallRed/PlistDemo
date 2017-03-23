//
//  AddPlistVC.m
//  PlistDemo
//
//  Created by 邱圣军 on 2017/3/22.
//  Copyright © 2017年 邱圣军. All rights reserved.
//

#import "AddPlistVC.h"

static NSString * const contentKey = @"content";
static NSString * const tagKey = @"tag";
static NSString * const othersKey = @"others";

@interface AddPlistVC ()

@property (weak, nonatomic) IBOutlet UITextField *textField_name;
@property (weak, nonatomic) IBOutlet UITextField *textField_content;
@property (weak, nonatomic) IBOutlet UITextField *textField_tag;
@property (weak, nonatomic) IBOutlet UITextField *textFied_others;
@property (copy, nonatomic) NSString *docPath;

@end

@implementation AddPlistVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.docPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
}

- (IBAction)savePlist:(id)sender {
    NSString *plistName = [NSString stringWithFormat:@"%@.plist",self.textField_name.text];
    NSString *plistPath = [self.docPath stringByAppendingPathComponent:plistName];
    
    NSString *content = [[NSString alloc] init];
    content = self.textField_content.text;
    NSString *tag = [[NSString alloc] init];
    tag = self.textField_tag.text;
    NSString *others = [[NSString alloc] init];
    others = self.textFied_others.text;
    
    NSMutableDictionary *infoDict = [[NSMutableDictionary alloc] init];
    [infoDict setObject:content forKey:contentKey];
    [infoDict setObject:tag forKey:tagKey];
    [infoDict setObject:others forKey:othersKey];
    [infoDict writeToFile:plistPath atomically:YES];
    
    self.textField_name.text = nil;
    self.textField_content.text = nil;
    self.textFied_others.text = nil;
    self.textField_tag.text = nil;
}
- (IBAction)dismissView:(id)sender {
    [self dismissViewControllerAnimated:self completion:nil];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.textField_name resignFirstResponder];
    [self.textField_content resignFirstResponder];
    [self.textField_tag resignFirstResponder];
    [self.textFied_others resignFirstResponder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
