//
//  BeautyStreamViewLayout.m
//  小海嚴選
//
//  Created by boboRAY on 2014/5/30.
//  Copyright (c) 2014年 boboRAY. All rights reserved.
//

#import "BeautyStreamViewLayout.h"

static NSString * const BeautyStreamLayoutPhotoCellKind = @"BeautyStreamCell";

@interface BeautyStreamViewLayout ()

@property (nonatomic, strong) NSDictionary *layoutInfo;

@end

@implementation BeautyStreamViewLayout





- (void)prepareLayout {
    self.itemSize = CGSizeMake(160, 160);
    self.minimumInteritemSpacing = 0;
    self.minimumLineSpacing = 0;
    self.scrollDirection = UICollectionViewScrollDirectionVertical;
}

// indicate that we want to redraw as we scroll


- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
    return YES;
}



@end
