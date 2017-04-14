//
//  Login.m
//  Receipt_Scanner
//
//  Created by ankur kumawat on 20/09/16.
//  Copyright © 2016 sixthsense. All rights reserved.
//

#import "Login.h"
#import "CoreDataManager.h"
#import "All_Receipt.h"
#import <CoreData/CoreData.h>
#import "IQKeyboardManager.h"
//#import "IQDropDownTextField.h"
#import "IQUIView+IQKeyboardToolbar.h"
#import "IQUITextFieldView+Additions.h"


@interface Login ()
{
    NSArray *arrayFetchedResult;
}

@end

@implementation Login

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
    
    [[_btn_outlet layer] setBorderWidth:2.0f];
    [[_btn_outlet layer] setBorderColor:[UIColor whiteColor].CGColor];
    
     [self.navigationController setNavigationBarHidden:YES];
     NSLog(@"app dir: %@",[[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject]);
    
//    _tx_userid.text=@"";
//    _tx_password.text=@"";
//    
//    NSManagedObjectContext *context = [self managedObjectContext];
//    // Create a new device
//    NSManagedObject *newDevice = [NSEntityDescription insertNewObjectForEntityForName:@"Loginuser" inManagedObjectContext:context];
//    
//    
//    
//    
//    [newDevice setValue:self.tx_userid.text forKey:@"userid"];
//    [newDevice setValue:self.tx_password.text forKey:@"password"];
//    
//    
//
//    
//    NSError *error = nil;
//    // Save the object to persistent store
//    if (![context save:&error]) {
//        NSLog(@"Can't Save! %@ %@", error, [error localizedDescription]);
//    }
//    

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

- (IBAction)login_btn:(id)sender {
    [[NSUserDefaults standardUserDefaults] setObject:@"login" forKey:@"AlreadyLogi"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init] ;
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Loginuser" inManagedObjectContext:self.managedObjectContext];
    [request setEntity:entity];
    [request setFetchLimit:1];
    NSError *error = nil;
    NSArray *results = [self.managedObjectContext executeFetchRequest:request error:&error];
    if (!results) {
        NSLog(@"Fetch error: %@", error);
        abort();
    }
    if ([results count] == 0) {
        //return NO;
        NSLog(@"efjhgrb");
        [self performSegueWithIdentifier:@"Navigation" sender:nil];
        
    }
    else if ([results count] > 0)
    {
        NSLog(@"ypypy");
        arrayFetchedResult = [[CoreDataManager sharedManager] fetchUserInfoWithEmail:_tx_userid.text andPassword:_tx_password.text];
        
        if (arrayFetchedResult.count > 0)
        {
            [[NSUserDefaults standardUserDefaults] setObject:self.tx_userid.text forKey:@"Username"];
            [[NSUserDefaults standardUserDefaults] setObject:self.tx_password.text forKey:@"Password"];
            
           
            [self performSegueWithIdentifier:@"Navigation" sender:nil];
            
        }
        else
        {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Error"
                                                           message:@"Invalide username or password"
                                                          delegate:self
                                                 cancelButtonTitle:@"OK"
                                                 otherButtonTitles:nil, nil];
            [alert show];
        }

        
    }
    
   }

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
    if ([segue.identifier isEqualToString:@"Navigation"])
        
    {
        UINavigationController *navigation = [segue destinationViewController];
        
       // All_Receipt *homeVC = (All_Receipt*)navigation.topViewController;
        
      //  UserInfo *userInfo = arrayFetchedResult[0];
        
       // homeVC.userInfoFromSignUp = userInfo;
    }
}



@end
