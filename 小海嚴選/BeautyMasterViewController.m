//
//  BeautyMasterViewController.m
//  小海嚴選
//
//  Created by boboRAY on 2014/5/29.
//  Copyright (c) 2014年 boboRAY. All rights reserved.
//

#import "BeautyMasterViewController.h"
#import <RestKit/RestKit.h>
#import "BeautyStream.h"
#import "BeautyStreamCell.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface BeautyMasterViewController ()<UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>
@property(nonatomic, weak) IBOutlet UICollectionView *collectionView;

@property(nonatomic,strong) NSMutableArray *beauties;


@end

@implementation BeautyMasterViewController

{
    int page;
}

-(void)viewWillAppear:(BOOL)animated{
    [self.collectionView registerNib:[UINib nibWithNibName:@"BeautyStreamCell" bundle:[NSBundle mainBundle]]
        forCellWithReuseIdentifier:@"BeautyStreamCell"];
    [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationNone];

}



- (void)viewDidLoad
{
    [super viewDidLoad];
    [[UIApplication sharedApplication] setStatusBarHidden:YES];
    
    _beauties = [NSMutableArray new];
    page = 0;
    
    [self configureRestKit];
    [self loadBeautyStream];
     

}

- (BOOL)prefersStatusBarHidden {
    return YES;
}


-(void)configureRestKit
{
    // initialize AFNetworking HTTPClient
    NSURL *baseURL = [NSURL URLWithString:@"http://curator.im/api/"];
    AFHTTPClient *client = [[AFHTTPClient alloc] initWithBaseURL:baseURL];
    
    // initialize RestKit
    RKObjectManager *objectManager = [[RKObjectManager alloc] initWithHTTPClient:client];
    
    // setup object mappings
    RKObjectMapping *beautyStreamMapping = [RKObjectMapping mappingForClass:[BeautyStream  class]];
    [beautyStreamMapping addAttributeMappingsFromArray:@[@"name",@"image"]];
    
    // register mappings with the provider using a response descriptor
    RKResponseDescriptor *responseDescriptor =
    [RKResponseDescriptor responseDescriptorWithMapping:beautyStreamMapping
                                                 method:RKRequestMethodGET
                                            pathPattern:@"stream/"
                                                keyPath:@"results"
                                            statusCodes:[NSIndexSet indexSetWithIndex:200]];
    
    [objectManager addResponseDescriptor:responseDescriptor];
}

-(void)loadBeautyStream
{
    page += 1;
    NSString *pageString = [NSString stringWithFormat:@"%d",page];
    NSDictionary *queryParams = @{@"token": @"c24002ad802041c7bc9270cfa7dcd99a",
                                  @"page": pageString };
    
    [[RKObjectManager sharedManager] getObjectsAtPath:@"stream/"
                                           parameters:queryParams
                                              success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
                                                  
                                                  [_beauties addObjectsFromArray:mappingResult.array];
                                                  
                                                  [self.collectionView reloadData];
                                              }
                                              failure:^(RKObjectRequestOperation *operation, NSError *error) {
                                                  NSLog(@"\n\n error \n\n");
                                              }];
}










- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




#pragma mark - Collection View Data Source

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _beauties.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    BeautyStreamCell *cell = (BeautyStreamCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"BeautyStreamCell" forIndexPath:indexPath];
    
    BeautyStream *beauty = _beauties[indexPath.row];
    [cell.beautyStreamImageView setImageWithURL:[NSURL URLWithString:beauty.image]
              placeholderImage:[UIImage imageNamed:@"avatar-placeholder.png"]
                       options:SDWebImageRefreshCached];
    cell.nameLabel.text = beauty.name;
    
    
    if (indexPath.item  == _beauties.count - 8) {
        [self configureRestKit];
        [self loadBeautyStream];
    }
    
    
    
    
    return cell;
}




@end
