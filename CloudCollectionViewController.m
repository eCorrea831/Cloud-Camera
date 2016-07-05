//
//  CloudCollectionViewController.m
//  Camera&Cloud
//
//  Created by Aditya Narayan on 6/29/16.
//  Copyright © 2016 TurnToTech. All rights reserved.
//

#import "CloudCollectionViewController.h"
#import "CollectionViewCell.h"
#import "CollectionReusableView.h"
#import "PicDetailsviewController.h"
#import "DAO.h"

@interface CloudCollectionViewController ()

@property (nonatomic, retain) PicDetailsViewController * picDetailsVC;
@property (nonatomic, retain) DAO * dao;
@end

@implementation CloudCollectionViewController

static NSString * const reuseIdentifier = @"CollectionViewCell";
static NSString * const ViewIdentifier = @"CollectionReusableView";

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dao = [DAO sharedInstance];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    
    UINib * cellNib = [UINib nibWithNibName:@"CollectionViewCell" bundle:nil];
    [self.collectionView registerNib:cellNib forCellWithReuseIdentifier:@"Cell1"];
    
    UINib * headerNib = [UINib nibWithNibName:@"CollectionReusableView" bundle:nil];
    [self.collectionView registerNib:headerNib forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"Header1"];

    UIStoryboard * storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    self.picDetailsVC = [storyboard instantiateViewControllerWithIdentifier:@"PicDetailsViewController"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dao.imageArray.count;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewFlowLayout*)collectionViewFlowLayout referenceSizeForHeaderInSection:(NSInteger)section {
    
    UICollectionViewFlowLayout * flowLayout = collectionViewFlowLayout;
    flowLayout.headerReferenceSize = CGSizeMake(self.collectionView.frame.size.width, 50);

    return flowLayout.headerReferenceSize;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    
    static NSString * ViewIdentifier = @"Header1";
    CollectionReusableView * headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:ViewIdentifier forIndexPath:indexPath];
    
    return headerView;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    CGSize collectionViewSize = collectionView.bounds.size;
    collectionViewSize.width = collectionViewSize.height = collectionViewSize.width/3.0;

    
    return collectionViewSize;
}

- (UIEdgeInsets)collectionView:(UICollectionView*)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    
    return 0.0;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    
    return 0.0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString * CellIdentifier = @"Cell1";
    CollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    
    CloudImage * iv = [self.dao.imageArray objectAtIndex:indexPath.row];
    cell.cellImageView.image = iv.image;
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {

    self.picDetailsVC.cloudImage = [self.dao.imageArray objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:self.picDetailsVC animated:YES];
}

@end