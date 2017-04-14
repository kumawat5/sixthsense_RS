//
//  ConfirmPayment.m
//  Receipt_Scanner
//
//  Created by ankur kumawat on 19/09/16.
//  Copyright © 2016 sixthsense. All rights reserved.
//

#import "ConfirmPayment.h"
#import "Setting.h"

@interface ConfirmPayment ()

@end

@implementation ConfirmPayment
@synthesize device;

- (NSManagedObjectContext *)managedObjectContext {
    NSManagedObjectContext *context = nil;
    id delegate = [[UIApplication sharedApplication] delegate];
    if ([delegate performSelector:@selector(managedObjectContext)]) {
        context = [delegate managedObjectContext];
    }
    return context;
}


- (void)viewDidLoad {
    [super viewDidLoad];
   
    _tx_des.text= _des;
    _tx_detail.text= _detail;
   
    // Do any additional setup after loading the view.
    
    }

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)cancel:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)confirm:(id)sender {
    if (![self isFormValid]) {
        
        return;
        
    }
    
    NSError *error;
    
    
    if (!error)
    {
        
    
    NSManagedObjectContext *context = [self managedObjectContext];
    
    if (self.device) {
        // Update existing device
        [self.device setValue:self.tx_des.text forKey:@"des"];
        [self.device setValue:self.tx_detail.text forKey:@"detail"];
        
        
        
    } else {
        // Create a new device
        NSManagedObject *newDevice = [NSEntityDescription insertNewObjectForEntityForName:@"Addpayment" inManagedObjectContext:context];
        
        [newDevice setValue:self.tx_des.text forKey:@"des"];
        [newDevice setValue:self.tx_detail.text forKey:@"detail"];
        
    }
    
    NSError *error = nil;
    // Save the object to persistent store
    if (![context save:&error]) {
        NSLog(@"Can't Save! %@ %@", error, [error localizedDescription]);
    }
   // [self dismissViewControllerAnimated:YES completion:nil];
    for (UIViewController *controller in self.navigationController.viewControllers)
    {
        if ([controller isKindOfClass:[Setting class]])
        {
            [self.navigationController popToViewController:controller
                                                  animated:YES];
            break;
        }
    }

    }
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField

{
    [self.tx_des resignFirstResponder];
    [self.tx_detail resignFirstResponder];
    
    
    
    return YES;
}
-(BOOL)isFormValid
{
    if (_tx_des.text && _tx_des.text.length==0)
    {
        [self showErrorMessage:@"Please Enter Description"];
        return NO;
    }
    
    
    else if (_tx_detail.text && _tx_detail.text.length==0)
    {
        [self showErrorMessage:@"Please Enter Details"];
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
