//
//  ViewController.m
//  ClientTest
//
//  Created by 王鹏飞 on 16/7/1.
//  Copyright © 2016年 王鹏飞. All rights reserved.
//

#import "ViewController.h"
#import "BasicViewController.h"

@interface ViewController () 

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.title = @"获取设备信息";
    
    if (@available(iOS 11.0, *))
    {
        self.navigationController.navigationBar.prefersLargeTitles = YES;
        self.navigationController.navigationBar.largeTitleTextAttributes = @{NSFontAttributeName:[UIFont fontWithName:@"PingFangSC-Medium" size:28], NSForegroundColorAttributeName:[UIColor blackColor]};
    }
    
    NSArray *types = @[
                       @"硬件信息",
                       @"电池信息",
                       @"IP和MAC信息",
                       @"CPU信息",
                       @"存储信息"
                       ];
    
    float frameY = self.navigationController.navigationBar.frame.origin.y + self.navigationController.navigationBar.frame.size.height;
    float widthSpacing = 30.0f;
    float buttonHeight = 50.0f;
    float buttonWidth = self.view.frame.size.width - widthSpacing * 2;
    float heightSpacing = (self.view.frame.size.height - frameY - types.count * buttonHeight) / (types.count + 1);
    for (int f = 0; f < types.count; f++)
    {
        UIButton *button = [[UIButton alloc] init];
        button.tag = f + 1;
        [button addTarget:self action:@selector(buttonPress:) forControlEvents:UIControlEventTouchUpInside];
        button.frame = CGRectMake(widthSpacing, (heightSpacing + buttonHeight) * f + heightSpacing + frameY, buttonWidth, buttonHeight);
        [button setTitle:types[f] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        button.backgroundColor = [UIColor darkGrayColor];
        [self.view addSubview:button];
    }
}

#pragma mark - Event Response

- (void)buttonPress:(UIButton *)button
{
    switch (button.tag)
    {
        case 1:
            [self _pushVCWithType:BasicInfoTypeHardWare sender:button];
            break;
        case 2:
            [self _pushVCWithType:BasicInfoTypeBattery sender:button];
            break;
        case 3:
            [self _pushVCWithType:BasicInfoTypeIpAddress sender:button];
            break;
        case 4:
            [self _pushVCWithType:BasicInfoTypeCPU sender:button];
            break;
        case 5:
            [self _pushVCWithType:BasicInfoTypeDisk sender:button];
            break;
        default:
            break;
    }
}

- (void)_pushVCWithType:(BasicInfoType)type sender:(UIButton *)sender
{
    BasicViewController *basicVC = [[BasicViewController alloc] initWithType:type];
    basicVC.navigationItem.title = sender.titleLabel.text;
    [self.navigationController pushViewController:basicVC  animated:YES];
}

@end
