//
//  BeautyStreamDetailViewController.m
//  小海嚴選
//
//  Created by boboRAY on 2014/6/3.
//  Copyright (c) 2014年 boboRAY. All rights reserved.
//

#import "BeautyStreamDetailViewController.h"
#import "BeautyStream.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface BeautyStreamDetailViewController ()
@end
@implementation BeautyStreamDetailViewController





- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    
    [self.image setImageWithURL:[NSURL URLWithString:_beauty.image]
                         placeholderImage:[UIImage imageNamed:@"Loading_placeholder.png"]
                                  options:SDWebImageRefreshCached];
    self.nameLabel.text = _beauty.name;
// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/



@end
