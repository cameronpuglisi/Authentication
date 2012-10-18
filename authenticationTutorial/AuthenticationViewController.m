//
//  AuthenticationViewController.m
//  authenticationTutorial
//
//  Created by iffytheperfect on 10/17/12.
//  Copyright (c) 2012 iffytheperfect. All rights reserved.
//

#import "AuthenticationViewController.h"
#import "ViewController.h"

@interface AuthenticationViewController ()
{
    NSFileManager *fileManager;
    NSString *fullPath;
    NSFileHandle *fileHandle;
}

@end

@implementation AuthenticationViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // setup path and filename to store and read from (our text file that we referto)
    
    self.passwordTextField.secureTextEntry = YES;
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *filePath = [paths objectAtIndex:0];
    
    fileManager = [NSFileManager defaultManager];
    fileHandle = [NSFileHandle fileHandleForUpdatingAtPath:[filePath stringByAppendingPathComponent:@"mySuperSecretKey.txt"]];
    
    [fileManager changeCurrentDirectoryPath:filePath];
    fullPath = [NSString stringWithFormat:@"%@", [filePath stringByAppendingPathComponent:@"mySuperSecretKey.txt"]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (IBAction)setUserNameAndPasswordButton:(id)sender {
    
    BOOL fileExist = [[NSFileManager defaultManager]fileExistsAtPath:fullPath];
    
    if (!fileExist) {
        [fileManager createFileAtPath:fullPath contents:nil attributes:nil];
    }
    
    NSString *userNameAndPasswordString = [NSString stringWithFormat:@"%@\n%@",self.setUserNameTextField.text, self.setPasswordTextField.text];
    
    fileHandle = [NSFileHandle fileHandleForUpdatingAtPath:fullPath];
    NSData *data;
    const char *bytesOfUserNameAndPassword = [userNameAndPasswordString UTF8String];
    data = [NSData dataWithBytes:bytesOfUserNameAndPassword length:strlen(bytesOfUserNameAndPassword)];
    [data writeToFile:fullPath atomically:YES];
    
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Done Setting Username and Password" message:@"Completed" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
    [alert show];
}

- (IBAction)signInButton:(id)sender {
    BOOL fileExist = [[NSFileManager defaultManager]fileExistsAtPath:fullPath];
    if (!fileExist) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Havn't set username and passwod" message:@"Please set username and password" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
        [alert show];
    }
    else
    {
        fileHandle = [NSFileHandle fileHandleForUpdatingAtPath:fullPath];
        NSString *stringFromFile = [NSString stringWithContentsOfFile:fullPath encoding:NSASCIIStringEncoding error:nil];
        
        const char *charsFromFile = [stringFromFile UTF8String];
        
        NSString *userNameFromFile = [[NSString alloc]init];
        NSString *passwordFromFile = [[NSString alloc]init];
        
        int count = 0;
        for (int i = 0; i < strlen(charsFromFile); i++) {
            if (charsFromFile[i]=='\n') {
                ++count;
            }
            else if(count == 0) // append characters to usernamefromfile
            {
                userNameFromFile = [userNameFromFile stringByAppendingString:[NSString stringWithFormat:@"%c", charsFromFile[i]]];
            }
            else    // append characters to passwordfromfile
            {
                passwordFromFile = [passwordFromFile stringByAppendingString:[NSString stringWithFormat:@"%c", charsFromFile[i]]];
            }
        }
        
        if ([userNameFromFile isEqualToString:self.userNameTextField.text] && [passwordFromFile isEqualToString:self.passwordTextField.text]) {
            ViewController *vc = [[ViewController alloc]init];
            [self presentViewController:vc animated:YES completion:nil];
        }
        else
        {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Mismatch" message:@"Username or Password is incorrect" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
            [alert show];
        }
        
    }
}
@end
