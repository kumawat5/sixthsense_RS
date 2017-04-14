//
//  AddActivity.m
//  Receipt_Scanner
//
//  Created by ankur kumawat on 19/09/16.
//  Copyright © 2016 sixthsense. All rights reserved.
//

#import "AddActivity.h"
#import "ConfirmActivity.h"

@interface AddActivity ()

@end

@implementation AddActivity

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField

{
    [self.tx_activityname resignFirstResponder];
    [self.gl_account resignFirstResponder];
    
    
    
    return YES;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"confirm"]) {
        ConfirmActivity *destViewController = segue.destinationViewController;
        destViewController.des = _tx_activityname.text;
        destViewController.detail= _gl_account.text;
    }
}

- (IBAction)add:(id)sender {
    if (![self isFormValid]) {
        
        return;
        
    }
    
    NSError *error;
    
    
    if (!error)
    {
        [self performSegueWithIdentifier:@"confirm" sender:nil];
    }
}
-(BOOL)isFormValid
{
    if (_tx_activityname.text && _tx_activityname.text.length==0)
    {
        [self showErrorMessage:@"Please Enter Activity Name"];
        return NO;
    }
    
    
    else if (_gl_account.text && _gl_account.text.length==0)
    {
        [self showErrorMessage:@"Please Enter GL Account"];
        return NO;
    }
    return YES;
}


-(void)showErrorMessage:(NSString *)message
{
    
    UIAlertController * alert = [UIAlertController
                                 alertControllerWithTitle:@"Error"message:message
                                 preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* yesButton = [UIAlertAction
                                actionWithTitle:@"OK"style:UIAlertActionStyleCancel
                                handler:^(UIAlertAction * action) {
                                    //Handle your yes please button action here
                                }];
    
    
    
    [alert addAction:yesButton];
    
    
    [self presentViewController:alert animated:YES completion:nil];
    
}

@end
