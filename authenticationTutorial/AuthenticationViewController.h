//
//  AuthenticationViewController.h
//  authenticationTutorial
//
//  Created by iffytheperfect on 10/17/12.
//  Copyright (c) 2012 iffytheperfect. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AuthenticationViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *setUserNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *setPasswordTextField;
@property (weak, nonatomic) IBOutlet UITextField *userNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;

- (IBAction)setUserNameAndPasswordButton:(id)sender;
- (IBAction)signInButton:(id)sender;

@end
