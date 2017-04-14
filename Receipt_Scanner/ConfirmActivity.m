//
//  ConfirmActivity.m
//  Receipt_Scanner
//
//  Created by ankur kumawat on 19/09/16.
//  Copyright © 2016 sixthsense. All rights reserved.
//

#import "ConfirmActivity.h"
#import "Setting.h"

@interface ConfirmActivity ()

@end

@implementation ConfirmActivity
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
    _tx_activityname.text= _des;
    _gl_account.text= _detail;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
        [self.device setValue:self.tx_activityname.text forKey:@"activityname"];
        [self.device setValue:self.gl_account.text forKey:@"gl_account"];
        
        
        
    } else {
    
      
        // Create a new device
        NSManagedObject *newDevice = [NSEntityDescription insertNewObjectForEntityForName:@"Addactivity" inManagedObjectContext:context];
        
          [newDevice setValue:self.tx_activityname.text forKey:@"activityname"];
          
        [newDevice setValue:self.gl_account.text forKey:@"gl_account"];
        
    }
    
    NSError *error = nil;
    // Save the object to persistent store
    if (![context save:&error]) {
        NSLog(@"Can't Save! %@ %@", error, [error localizedDescription]);
    }
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
    [self.tx_activityname resignFirstResponder];
    [self.gl_account resignFirstResponder];
    
    
    
    return YES;
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
