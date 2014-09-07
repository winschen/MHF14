//
//  LoginScreenViewController.h
//  Tardy
//
//  Created by apple on 9/6/14.
//  Copyright (c) 2014 Apple Test. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FacebookSDK/FacebookSDK.h>

@interface LoginScreenViewController : UIViewController <FBLoginViewDelegate>

@property (weak, nonatomic) IBOutlet FBLoginView *loginView;
@property (weak, nonatomic) IBOutlet UIButton *continueButton;

@end
