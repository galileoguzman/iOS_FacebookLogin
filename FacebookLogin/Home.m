//
//  ViewController.m
//  FacebookLogin
//
//  Created by Galileo Guzman on 5/9/16.
//  Copyright © 2016 Galileo Guzman. All rights reserved.
//

#import "Home.h"

@interface Home ()
@property (strong, nonatomic) NSMutableDictionary *profile;
@end

@implementation Home

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.profile = [NSMutableDictionary alloc];
    
    self.lblName.hidden = YES;
    self.lblEmail.hidden = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btnLoginPressed:(id)sender {
    FBSDKLoginManager *login = [[FBSDKLoginManager alloc] init];
    [login logInWithReadPermissions: @[@"public_profile", @"email"] fromViewController:self handler:^(FBSDKLoginManagerLoginResult *result, NSError *error) {
         if (error) {
             NSLog(@"Process error");
         } else if (result.isCancelled) {
             NSLog(@"Cancelled");
         } else {
             if ([result.grantedPermissions containsObject:@"email"] && [result.grantedPermissions containsObject:@"public_profile"]) {
 
                 // ----------------------------------------------------------
                 // Do work
                 // ----------------------------------------------------------
                 if ([FBSDKAccessToken currentAccessToken]) {
 
                     NSMutableDictionary* parameters = [NSMutableDictionary dictionary];
                     [parameters setValue:@"id,name,email" forKey:@"fields"];
 
                     [[[FBSDKGraphRequest alloc] initWithGraphPath:@"me" parameters:parameters]
                      startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id result, NSError *error) {
                          if (!error) {
 
                              NSLog(@"Facebook result dict : %@", result);
                              self.profile = (NSMutableDictionary*)result;
                              
                              NSString *urlImageProfile = [NSString stringWithFormat:@"https://graph.facebook.com/%@/picture?type=large", [result objectForKey:@"id"]];
                              
                              [self showUserProfileWith:self.profile andImageProfile:urlImageProfile];
                              
                              
                              
                          }
                      }];
                 }
                 
             }
         }
     }];

}


-(void)showUserProfileWith:(NSMutableDictionary*)userData andImageProfile:(NSString*)imageUrl{
    self.lblName.text = [userData objectForKey:@"name"];
    self.lblEmail.text = [userData objectForKey:@"email"];
    
    
    
    
    
    dispatch_async(dispatch_get_main_queue(), ^{
        NSURL *url = [NSURL URLWithString:imageUrl];
        
        NSData *data = [NSData dataWithContentsOfURL:url];
        self.imgProfile.image = [UIImage imageWithData:data];
        
        self.vProfile.backgroundColor = [UIColor grayColor];
        self.lblName.hidden = NO;
        self.lblEmail.hidden = NO;
    });
    
}
@end
