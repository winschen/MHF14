//
//  LoginScreenViewController.m
//  Tardy
//
//  Created by apple on 9/6/14.
//  Copyright (c) 2014 Apple Test. All rights reserved.
//

#import "LoginScreenViewController.h"
//#import <FacebookSDK/FacebookSDK.h>
#import <Parse/Parse.h>

@interface LoginScreenViewController ()

@end

@implementation LoginScreenViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //FBLoginView *loginView = [[FBLoginView alloc] init];
    //[self.view addSubview:loginView];
    
    self.loginView.readPermissions = @[@"public_profile", @"email", @"user_friends", @"user_events"];
    [self.continueButton setHidden:YES];
    
//    PFUser *user = [PFUser user];
//    user.username = @"winschen";
//    user.password = @"parsePass";
//    user.email = @"winschen@umich.edu";
//    
//    // other fields can be set if you want to save more information
//    user[@"phone"] = @"248-675-7875";
//    
//    [user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
//        if (!error) {
//            // Hooray! Let them use the app now.
//        } else {
//            NSString *errorString = [error userInfo][@"error"];
//            // Show the errorString somewhere and let the user try again.
//        }
//    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loginViewFetchedUserInfo:(FBLoginView *)loginView user:(id<FBGraphUser>)user {
    NSLog(@"%@", user.name);
}

- (void) loginViewShowingLoggedInUser:(FBLoginView *)loginView {
    NSLog(@"You are logged in!");
    [self.continueButton setHidden:NO];
}

- (void)loginViewShowingLoggedOutUser:(FBLoginView *)loginView {
    NSLog(@"You are logged out!");
    [self.continueButton setHidden:YES];
}

- (void)loginView:(FBLoginView *)loginView handleError:(NSError *)error {
    NSString *alertMessage, *alertTitle;
    
    if ([FBErrorUtility shouldNotifyUserForError:error])
    {
        alertTitle = @"Facebook error";
        alertMessage = [FBErrorUtility userMessageForError:error];
    }
    else if ([FBErrorUtility errorCategoryForError:error] == FBErrorCategoryAuthenticationReopenSession)
    {
        alertTitle = @"Session Error";
        alertMessage = @"Your current session is no longer valid. Please log in again.";
    }
    else if ([FBErrorUtility errorCategoryForError:error] == FBErrorCategoryUserCancelled)
    {
        NSLog(@"user cancelled login");
    }
    else
    {
        alertTitle = @"Something went wrong";
        alertMessage = @"Please try again later.";
        NSLog(@"Unexpected error:%@", error);
    }
    
    if (alertMessage)
    {
        [[[UIAlertView alloc] initWithTitle:alertTitle
                                    message:alertMessage
                                   delegate:nil
                          cancelButtonTitle:@"OK"
                          otherButtonTitles:nil] show];
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
