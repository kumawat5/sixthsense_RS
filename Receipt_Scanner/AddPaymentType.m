//
//  AddPaymentType.m
//  Receipt_Scanner
//
//  Created by ankur kumawat on 19/09/16.
//  Copyright © 2016 sixthsense. All rights reserved.
//

#import "AddPaymentType.h"
#import "ConfirmPayment.h"

@interface AddPaymentType ()

@end

@implementation AddPaymentType
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

- (IBAction)submit:(id)sender {
//    NSManagedObjectContext *context = [self managedObjectContext];
//    
//    if (self.device) {
//        // Update existing device
//        [self.device setValue:self.tx_description.text forKey:@"des"];
//        [self.device setValue:self.tx_details.text forKey:@"detail"];
//        
//        
//        
//    } else {
//        // Create a new device
//        NSManagedObject *newDevice = [NSEntityDescription insertNewObjectForEntityForName:@"Addpayment" inManagedObjectContext:context];
//        
//        [newDevice setValue:self.tx_description.text forKey:@"des"];
//        [newDevice setValue:self.tx_details.text forKey:@"detail"];
//        
//    }
//    
//    NSError *error = nil;
//    // Save the object to persistent store
//    if (![context save:&error]) {
//        NSLog(@"Can't Save! %@ %@", error, [error localizedDescription]);
//    }
  //  [self dismissViewControllerAnimated:YES completion:nil];
    if (![self isFormValid]) {
        
        return;
        
    }
    
    NSError *error;
    
    
    if (!error)
    {
     [self performSegueWithIdentifier:@"confirm" sender:nil];
    }
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField

{
    [self.tx_details resignFirstResponder];
    [self.tx_description resignFirstResponder];
   
    
    
    return YES;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"confirm"]) {
        ConfirmPayment *destViewController = segue.destinationViewController;
        destViewController.des = _tx_description.text;
        destViewController.detail= _tx_details.text;
    }
}

-(BOOL)isFormValid
{
    if (_tx_description.text && _tx_description.text.length==0)
    {
        [self showErrorMessage:@"Please Enter Description"];
        return NO;
    }
    
    
    else if (_tx_details.text && _tx_details.text.length==0)
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
