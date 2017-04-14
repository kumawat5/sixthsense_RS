//
//  SplashViewController.m
//  LoginDemo
//
//  Created by InfoEnumY04 on 27/06/15.
//  Copyright (c) 2015 InfoEnumY04. All rights reserved.
//

#import "SplashViewController.h"
#import "All_Receipt.h"
#import "Login.h"
//#import "AppButton.h"
//#import "UIColor+AppTheme.h"

@interface SplashViewController ()
{
    IBOutlet UILabel *labelSplash;
    All_Receipt *homeVC;
}

@end

@implementation SplashViewController


#pragma mark - View LifeCycle


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:YES];
  //  self.navigationController.navigationBar.tintColor = [UIColor appGreenColor];
    
    
    //// code for animation of splash......
    
    labelSplash.alpha = 0.3;
    [UIView animateWithDuration:2.0
                     animations:^
     {    labelSplash.alpha = 0.3;
         
         labelSplash.transform = CGAffineTransformMakeScale(1.5, 1.5);
         labelSplash.alpha = 1.0;
         labelSplash.transform = CGAffineTransformMakeScale(1, 1);
         
     } completion:^(BOOL finished)
     
     //// this code runs just after the animation......
     
     {
         
         homeVC = [self.storyboard instantiateViewControllerWithIdentifier:NSStringFromClass([All_Receipt class])];
         
         if ([[NSUserDefaults standardUserDefaults]objectForKey:@"Username"] != nil)
         {
             //// adding  new ViewControllers to the NavigationController stack.....
             
             //// this will get exicuted when the user has not logged out and opns the app .....
             
             NSLog(@"Controllers: %@", self.navigationController.viewControllers);
             
             //            homeVC = [self.storyboard instantiateViewControllerWithIdentifier:NSStringFromClass([HomeViewController class])];
             //
             //            LoginViewController *loginVC = [self.storyboard instantiateViewControllerWithIdentifier:NSStringFromClass([LoginViewController class])];
             //
             
             
             //            NSMutableArray *arrayVC = [self.navigationController viewControllers].mutableCopy;
             //
             //            [arrayVC addObjectsFromArray:@[loginVC,homeVC]];
             
             //[self.navigationController setViewControllers:@[self,loginVC] animated:YES];
             
             [self performSegueWithIdentifier:@"Navigation" sender:nil];
             
             NSLog(@"Controllers: %@", self.navigationController.viewControllers);
             
         }
         else
         {
             homeVC.fromSplash = NO;
             [self performSelector:@selector(splash) withObject:nil afterDelay:0.0];
         }
         
         //        AppButton *button = [[AppButton alloc] initWithFrame:CGRectMake(100, 100, 100, 50)];
         //        [button setTitle:@"Program" forState:UIControlStateNormal];
         //        NSLog(@"Button = %@", button);
         //        [self.view addSubview:button];
         
         
     }];
}

#pragma mark - Segue method

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"Navigation"])
    {
        //        homeVC = [segue destinationViewController];
        //        homeVC.fromSplash = YES;
        
        //accessing the object of HomeViewController through NavigationController object......
        
        
        UINavigationController *navigation = [segue destinationViewController];
        
        All_Receipt *homeVC2 = (All_Receipt *)navigation.topViewController;
        homeVC2.fromSplash = YES;
        //
    }
    
}


- (void)splash
{
    [self performSegueWithIdentifier:@"LoginViewController" sender:nil];
}


@end
