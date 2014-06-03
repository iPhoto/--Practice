//
//  BeautyStreamDetailViewController.h
//  小海嚴選
//
//  Created by boboRAY on 2014/6/3.
//  Copyright (c) 2014年 boboRAY. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BeautyStream.h"


@interface BeautyStreamDetailViewController : UIViewController


@property(strong,nonatomic) BeautyStream *beauty;

@property(weak,nonatomic)IBOutlet UIImageView *image;

@property(weak,nonatomic)IBOutlet UILabel *nameLabel;



@end
