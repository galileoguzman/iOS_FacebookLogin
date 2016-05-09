//
//  ViewController.h
//  FacebookLogin
//
//  Created by Galileo Guzman on 5/9/16.
//  Copyright © 2016 Galileo Guzman. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>

@interface Home : UIViewController

@property (weak, nonatomic) IBOutlet UIView *vProfile;
@property (weak, nonatomic) IBOutlet UILabel *lblName;
@property (weak, nonatomic) IBOutlet UILabel *lblEmail;
@property (weak, nonatomic) IBOutlet UIImageView *imgProfile;

- (IBAction)btnLoginPressed:(id)sender;
@end

