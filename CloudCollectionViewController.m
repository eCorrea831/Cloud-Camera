//
//  CloudCollectionViewController.m
//  Camera&Cloud
//
//  Created by Aditya Narayan on 6/29/16.
//  Copyright © 2016 TurnToTech. All rights reserved.
//

#import "CloudCollectionViewController.h"
#import "CollectionViewCell.h"
#import "PicDetailsviewController.h"

@interface CloudCollectionViewController ()

@property (nonatomic, retain) PicDetailsViewController * picDetailsVC;

@end

@implementation CloudCollectionViewController

static NSString * const reuseIdentifier = @"CollectionViewCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.picDetailsVC = [[PicDetailsViewController alloc]init];
    
    self.title = @"Cloud";
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    
    UINib * cellNib = [UINib nibWithNibName:@"CollectionViewCell" bundle:nil];
    [self.collectionView registerNib:cellNib forCellWithReuseIdentifier:@"Cell1"];
    
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

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString * CellIdentifier = @"Cell1";
    CollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];

    UIImage * iv = [self.imageArray objectAtIndex:indexPath.row];
    cell.imageView.image = iv;

    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    
    [self.picDetailsVC setModalPresentationStyle:UIModalPresentationFullScreen];
    [self.picDetailsVC setPicImage:[self.imageArray objectAtIndex:indexPath.row]];
    [self presentViewController:self.picDetailsVC animated:YES completion:nil];
    
//    Company * company = [[self.dao.companyList objectAtIndex:indexPath.row] retain];
//    
//
//    [self editInfoForCompany:company];
//
//    self.productCollectionViewController.title = company.companyName;
//    self.productCollectionViewController.company = company;
//    [self.navigationController pushViewController:self.productCollectionViewController animated:YES];

}


@end
