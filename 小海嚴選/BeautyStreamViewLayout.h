//
//  BeautyStreamViewLayout.h
//  小海嚴選
//
//  Created by boboRAY on 2014/5/30.
//  Copyright (c) 2014年 boboRAY. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BeautyStreamViewLayout : UICollectionViewFlowLayout
@property (nonatomic) UIEdgeInsets itemInsets;
@property (nonatomic) CGSize itemSize;
@property (nonatomic) CGFloat interItemSpacingY;
@property (nonatomic) NSInteger numberOfColumns;
@end
