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

@interface CloudCollectionViewController ()

@property (nonatomic, retain) PicDetailsViewController * picDetailsVC;

@end

@implementation CloudCollectionViewController

static NSString * const reuseIdentifier = @"CollectionViewCell";
static NSString * const ViewIdentifier = @"CollectionReusableView";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    
    UINib * cellNib = [UINib nibWithNibName:@"CollectionViewCell" bundle:nil];
    [self.collectionView registerNib:cellNib forCellWithReuseIdentifier:@"Cell1"];
    
    UINib * headerNib = [UINib nibWithNibName:@"CollectionReusableView" bundle:nil];
    [self.collectionView registerNib:headerNib forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"Header1"];
    
    UIImage * image1 = [UIImage imageNamed:@"camera.png"];
    UIImage * image2 = [UIImage imageNamed:@"cloud.png"];
    UIImage * image3 = [UIImage imageNamed:@"thumbs_up.png"];
    
    self.imageArray = [[NSMutableArray alloc]initWithObjects:image1, image2, image3, nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {

    return self.imageArray.count;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewFlowLayout*)collectionViewFlowLayout referenceSizeForHeaderInSection:(NSInteger)section {
    
    UICollectionViewFlowLayout * flowLayout = collectionViewFlowLayout;
    flowLayout.headerReferenceSize = CGSizeMake(self.collectionView.frame.size.width, 50);

    return flowLayout.headerReferenceSize;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewFlowLayout *)collectionViewFlowLayout insetForSectionAtIndex:(NSInteger)section {
    
    UICollectionViewFlowLayout * flowLayout = collectionViewFlowLayout;
    flowLayout.sectionInset = UIEdgeInsetsMake(10, 1, 1, 1);
    
    return flowLayout.sectionInset;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    
    static NSString * ViewIdentifier = @"Header1";
    CollectionReusableView * headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:ViewIdentifier forIndexPath:indexPath];
    
    return headerView;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString * CellIdentifier = @"Cell1";
    CollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    
    UIImage * iv = [self.imageArray objectAtIndex:indexPath.row];
    cell.imageView.image = iv;
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    self.picDetailsVC = [[PicDetailsViewController alloc]init];
    UIStoryboard * storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    self.picDetailsVC = [storyboard instantiateViewControllerWithIdentifier:@"Pic Details View Controller"];
    self.picDetailsVC.picImage = [[UIImageView alloc]initWithImage:[self.imageArray objectAtIndex:indexPath.row]];
    
    [self.picDetailsVC setModalPresentationStyle:UIModalPresentationFullScreen];
    [self presentViewController:self.picDetailsVC animated:YES completion:nil];
}

@end
