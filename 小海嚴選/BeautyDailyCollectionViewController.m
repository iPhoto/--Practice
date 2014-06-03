//
//  BeautyDailyCollectionViewController.m
//  小海嚴選
//
//  Created by boboRAY on 2014/6/3.
//  Copyright (c) 2014年 boboRAY. All rights reserved.
//

#import "BeautyDailyCollectionViewController.h"
#import <RestKit/RestKit.h>
#import "BeautyDaily.h"
#import "BeautyDailyCell.h"
#import <SDWebImage/UIImageView+WebCache.h>


@interface BeautyDailyCollectionViewController ()

@property(nonatomic,strong) NSMutableArray *beautiesDaily;

@end

@implementation BeautyDailyCollectionViewController

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
    _beautiesDaily = [NSMutableArray new];
    
    [self configureRestKit];
    [self loadBeautyDaily];
}


-(void)configureRestKit
{
    // initialize AFNetworking HTTPClient
    NSURL *baseURL = [NSURL URLWithString:@"http://curator.im/api/"];
    AFHTTPClient *dailyClient = [[AFHTTPClient alloc] initWithBaseURL:baseURL];
    
    // initialize RestKit
    RKObjectManager *dailyObjectManager = [[RKObjectManager alloc] initWithHTTPClient:dailyClient];
    
    // setup object mappings
    RKObjectMapping *beautyDailyMapping = [RKObjectMapping mappingForClass:[BeautyDaily class]];
    [beautyDailyMapping addAttributeMappingsFromArray:@[@"name",@"image"]];
    
    // register mappings with the provider using a response descriptor
    RKResponseDescriptor *responseDescriptorDaily =
    [RKResponseDescriptor responseDescriptorWithMapping:beautyDailyMapping
                                                 method:RKRequestMethodGET
                                            pathPattern:nil
                                                keyPath:@"results"
                                            statusCodes:[NSIndexSet indexSetWithIndex:200]];
    
    [dailyObjectManager addResponseDescriptor:responseDescriptorDaily];
}

-(void)loadBeautyDaily
{
    //page += 1;
    //NSString *pageString = [NSString stringWithFormat:@"%d",page];
    NSDictionary *queryParams = @{@"token": @"c24002ad802041c7bc9270cfa7dcd99a"};
    
    [[RKObjectManager sharedManager] getObjectsAtPath:@"girl_of_the_day/"
                                           parameters:queryParams
                                              success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
                                                  
                                                  [_beautiesDaily addObjectsFromArray:mappingResult.array];
                                                  
                                                  
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
#pragma mark - Collection View Data Source

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _beautiesDaily.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    BeautyDailyCell *cell =(BeautyDailyCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"BeautyDailyCell" forIndexPath:indexPath];
    
    BeautyDaily *beauty = _beautiesDaily[indexPath.row];
    
    [cell.image setImageWithURL:[NSURL URLWithString:beauty.image]
                               placeholderImage:[UIImage imageNamed:@"Loading_placeholder.png"]
                                        options:SDWebImageRefreshCached];
    cell.name.text = beauty.name;
    return cell;
}
















@end
