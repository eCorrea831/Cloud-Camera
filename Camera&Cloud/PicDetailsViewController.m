//
//  PicDetailsViewController.m
//  Camera&Cloud
//
//  Created by Aditya Narayan on 6/29/16.
//  Copyright © 2016 TurnToTech. All rights reserved.
//

#import "PicDetailsViewController.h"
#import "TableViewCell.h"

@interface PicDetailsViewController ()

@end

@implementation PicDetailsViewController

static NSString * const reuseIdentifier = @"TableViewCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.commentsTableView.delegate = self;
    self.commentsTableView.dataSource = self;
    self.picCommentTextField.delegate = self;
    
    [self.cloudImage.commentsArray addObject:@"I am a test comment."];
    [self.cloudImage.commentsArray addObject:@"So am I."];
    
    self.commentsTableView.hidden = YES;
    
    if (self.cloudImage.commentsArray.count >= 1) {
        self.commentsTableView.hidden = NO;
    }
    
    UINib * cellNib = [UINib nibWithNibName:@"TableViewCell" bundle:nil];
    [self.commentsTableView registerNib:cellNib forCellReuseIdentifier:@"Cell2"];
        
    [self.commentsTableView.layer setBorderColor:[[UIColor colorWithRed:0.82 green:0.81 blue:0.81 alpha:1.0]CGColor]];
    [self.commentsTableView.layer setBorderWidth:1.0];
}

- (void)viewDidAppear:(BOOL)animated {
    
    self.picImage.image = self.cloudImage.image;
    self.picCommentTextField.hidden = YES;
    
    if (self.cloudImage.numLikes >= 1) {
        self.numLikesLabel.hidden = NO;
    } else {
        self.numLikesLabel.hidden = YES;
        self.heartButton.imageView.image = [UIImage imageNamed:@"icn_like"];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.cloudImage.commentsArray.count;
}

 - (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
     
     static NSString * CellIdentifier = @"Cell2";
     TableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
     
     cell.userNameLabel.text = @"eCorrea831";
     cell.pictureCommentTextView.text = self.cloudImage.commentsArray[indexPath.row];

 return cell;
 }

- (IBAction)heartClicked:(id)sender {

    self.cloudImage.numLikes ++;
    self.numLikesLabel.text = [NSString stringWithFormat:@"%d likes",self.cloudImage.numLikes];
    self.numLikesLabel.hidden = NO;
}

- (IBAction)moreOptionsClicked:(id)sender {
    //TODO:bring up delete options
    //TODO:delete locally & from firebase
}

- (IBAction)commentClicked:(id)sender {
    
    self.picCommentTextField.hidden = NO;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self addItem];
    return YES;
}

- (void)addItem {
    
    self.picCommentTextField.hidden = YES;
    [self.cloudImage.commentsArray addObject:self.picCommentTextField.text];
    [self.commentsTableView reloadData];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    [self.picCommentTextField resignFirstResponder];
    [[self view] endEditing:YES];
}

@end
