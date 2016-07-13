//
//  PicDetailsViewController.m
//  Camera&Cloud
//
//  Created by Aditya Narayan on 6/29/16.
//  Copyright © 2016 TurnToTech. All rights reserved.
//

#import "PicDetailsViewController.h"
#import "TableViewCell.h"
#import "DAO.h"

@interface PicDetailsViewController ()

@end

@implementation PicDetailsViewController

static NSString * const reuseIdentifier = @"TableViewCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.commentsTableView.delegate = self;
    self.commentsTableView.dataSource = self;
    self.picCommentTextField.delegate = self;
    
    UINib * cellNib = [UINib nibWithNibName:@"TableViewCell" bundle:nil];
    [self.commentsTableView registerNib:cellNib forCellReuseIdentifier:@"Cell2"];
        
    [self.commentsTableView.layer setBorderColor:[[UIColor colorWithRed:0.82 green:0.81 blue:0.81 alpha:1.0]CGColor]];
    [self.commentsTableView.layer setBorderWidth:1.0];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardDidShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillBeHidden:) name:UIKeyboardWillHideNotification object:nil];

}

- (void)viewDidAppear:(BOOL)animated {

    if (self.cloudImage.commentsArray.count >= 1) {
        self.commentsTableView.hidden = NO;
    } else {
        self.commentsTableView.hidden = YES;
    }
    
    self.picImage.image = self.cloudImage.image;
    self.picCommentTextField.hidden = YES;
    
    if (self.cloudImage.numLikes >= 1) {
        self.numLikesLabel.hidden = NO;
    } else {
        self.numLikesLabel.hidden = YES;
        self.heartButton.imageView.image = [UIImage imageNamed:@"icn_like"];
    }
    [self.commentsTableView reloadData];
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
    //TODO:firebase
}

- (IBAction)moreOptionsClicked:(id)sender {
    
    UIAlertController * alert = [UIAlertController alertControllerWithTitle:nil
                                                                   message:nil
                                                            preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction * deleteAction = [UIAlertAction actionWithTitle:@"Delete Photo"
                                                            style:UIAlertActionStyleDestructive
                                                          handler:^(UIAlertAction * action) {
                                                              [self deletePhoto];
                                                          }];
    
    UIAlertAction * cancelAction = [UIAlertAction actionWithTitle:@"Cancel"
                                                            style:UIAlertActionStyleCancel
                                                          handler:^(UIAlertAction * action) {}];
    
    [alert addAction:deleteAction];
    [alert addAction:cancelAction];
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)deletePhoto {
    
    [[[DAO sharedInstance] imageArray] removeObject:self.cloudImage];
    //TODO:firebase
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (IBAction)commentClicked:(id)sender {
    
    self.picCommentTextField.hidden = NO;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self addItem];
    return YES;
}

- (void)keyboardWillShow:(NSNotification*)aNotification {
    [UIView animateWithDuration:0.25 animations:^ {
        
        CGSize keyboardSize = [[[aNotification userInfo] objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
        CGRect newFrame = self.picCommentTextField.frame;
        newFrame.origin.y -= keyboardSize.height;
        self.picCommentTextField.frame = newFrame;
        
     }completion:^(BOOL finished) {
     }];
}

- (void)keyboardWillBeHidden:(NSNotification*)aNotification {
    [UIView animateWithDuration:0.25 animations:^ {
        
        CGSize keyboardSize = [[[aNotification userInfo] objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
        CGRect newFrame = self.picCommentTextField.frame;
        newFrame.origin.y += keyboardSize.height;
        self.picCommentTextField.frame = newFrame;
        
     }completion:^(BOOL finished) {
     }];
}

- (void)addItem {
    
    self.picCommentTextField.hidden = YES;
    [self.cloudImage.commentsArray addObject:self.picCommentTextField.text];
    [self.commentsTableView reloadData];
    //TODO:firebase
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    [self.picCommentTextField resignFirstResponder];
    [[self view] endEditing:YES];
}

@end
