//
//  ViewController.m
//  ICDanbo
//
//  Created by itchyCat on 16/3/21.
//  Copyright © 2016年 itchyCat321. All rights reserved.
//

#import "ViewController.h"
#import "ICDanboModel.h"
#import "ICDanboView.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
   
    // Do any additional setup after loading the view, typically from a nib.
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    ICDanboView * danbo = [ICDanboView createDanboWithName:@"itchycat"];
    
    [self.view addSubview:danbo];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
