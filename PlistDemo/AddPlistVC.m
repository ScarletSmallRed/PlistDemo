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
static NSString * const imageKey = @"image";

@interface AddPlistVC ()<UIImagePickerControllerDelegate>

@property (weak, nonatomic) IBOutlet UITextField *textField_name;
@property (weak, nonatomic) IBOutlet UITextField *textField_content;
@property (weak, nonatomic) IBOutlet UITextField *textField_tag;
@property (weak, nonatomic) IBOutlet UITextField *textFied_others;
@property (copy, nonatomic) NSString *docPath;
@property (copy, nonatomic) UIImage *chosen_image;

@end

@implementation AddPlistVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.docPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
}

- (IBAction)choose:(UIButton *)sender {
    if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypePhotoLibrary]) {
        UIImagePickerController *imagePC = [[UIImagePickerController alloc] init];
        imagePC.delegate = self;
        imagePC.allowsEditing = false;
        imagePC.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        
        [self presentViewController:imagePC animated:true completion:nil];
    }
}


- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    self.chosen_image = (UIImage *)info[UIImagePickerControllerOriginalImage];
    [self dismissViewControllerAnimated:true completion:nil];
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
    NSData *imageData =UIImagePNGRepresentation(self.chosen_image);
    
    NSMutableDictionary *infoDict = [[NSMutableDictionary alloc] init];
    [infoDict setObject:content forKey:contentKey];
    [infoDict setObject:tag forKey:tagKey];
    [infoDict setObject:others forKey:othersKey];
    [infoDict setObject:imageData forKey:imageKey];
    [infoDict writeToFile:plistPath atomically:YES];
    
    self.textField_name.text = nil;
    self.textField_content.text = nil;
    self.textFied_others.text = nil;
    self.textField_tag.text = nil;
    
    NSLog(@"%@",plistPath);
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
