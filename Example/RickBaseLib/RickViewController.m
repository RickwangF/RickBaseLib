//
//  RickViewController.m
//  RickBaseLib
//
//  Created by wangweiyu on 09/03/2019.
//  Copyright (c) 2019 wangweiyu. All rights reserved.
//

#import "RickViewController.h"
#import <RickBaseLib/RickBaseLib.h>

@interface RickViewController ()

@property (nonatomic, strong) UIView *testView;

@end

@implementation RickViewController

#pragma mark - Lazy Init

- (UIView *)testView{
    if (_testView == nil) {
        _testView = [[UIView alloc] init];
        _testView.backgroundColor = [UIColor colorWithHex:@"#000"];
        [self.view addSubview:_testView];
    }
    return _testView;
}

#pragma mark - Life Circle

- (void)viewDidLoad{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    self.testView.frame = CGRectCenterMake(self.view.centerX, self.view.centerY, 100, 100);
}

- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
