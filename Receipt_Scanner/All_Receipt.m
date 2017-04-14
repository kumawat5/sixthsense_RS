//
//  All_Receipt.m
//  Receipt_Scanner
//
//  Created by ankur kumawat on 17/09/16.
//  Copyright © 2016 sixthsense. All rights reserved.
//

#import "All_Receipt.h"
#import "Receipt_Detail.h"
#import "All_Receipt_Cell.h"
#import <CoreData/CoreData.h>
#import "Loginuser.h"
#import "CoreDataManager.h"
#import "Setting.h"
#import "Login.h"

@interface All_Receipt ()
{
    
    NSMutableArray*selectedButton;
    int selectedIndex;
}

@property (strong) NSMutableArray *devices;
@property (nonatomic, retain) NSIndexPath* checkedIndexPath;@end

@implementation All_Receipt
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
    
    selectedButton = [[NSMutableArray alloc]init];//i've already defined the array at the .h file
    
    for (int i = 0; i<90000; i++) //yourTableSize = how many rows u got
    {
        [selectedButton addObject:@"NO"];
    }
    // Do any additional setup after loading the view.
    NSLog(@"app dir: %@",[[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject]);
    
    if (self.fromSplash == YES)
    {
        NSString *email = [[NSUserDefaults standardUserDefaults]objectForKey:@"Username"];
        
        _userInfoFromSignUp = [[CoreDataManager sharedManager] fetchUserInfoWithEmail:email];
        
        
        
    }
    

    self.date_lbl.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.date_lbl.layer.borderWidth = 0.5;
    self.company_lbl.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.company_lbl.layer.borderWidth = 0.5;
    self.sync_lbl.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.sync_lbl.layer.borderWidth = 0.5;
    self.total_lbl.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.total_lbl.layer.borderWidth = 0.5;
    self.currency_lbl.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.currency_lbl.layer.borderWidth = 0.5;


}
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    // Fetch the devices from persistent data store
    NSManagedObjectContext *managedObjectContext = [self managedObjectContext];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"Receipt_Details"];
    self.devices = [[managedObjectContext executeFetchRequest:fetchRequest error:nil] mutableCopy];
    
    [self.table_view reloadData];
    //_table_view.editing=YES;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
       // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return self.devices.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //NSLog(@"tableview cell");
    All_Receipt_Cell *cell = [_table_view dequeueReusableCellWithIdentifier:@"htrcell"];
    if (cell==nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"Cell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    if (indexPath.row % 2) {
        cell.contentView.backgroundColor = [[UIColor alloc]initWithRed:255/255.0 green:246/255.0 blue:246/255.0 alpha:1] ;
    } else {
        cell.contentView.backgroundColor = [UIColor whiteColor] ;
    }
    
    

     NSManagedObject *device = [self.devices objectAtIndex:indexPath.row];
    [cell.date_lbl setText:[device valueForKey:@"date"]];
    [cell.company_lbl setText:[device valueForKey:@"company"]];
    [cell.total_lbl setText:[device valueForKey:@"total"]];
    cell.currency_lbl.text = @"$";
        UIButton*toggleButton= cell.toggleButton;
   
   // if (![self.userInfoFromProfile.isDone   isEqualToString:@"true"])
    
    
    
    UIImage *img = [UIImage imageNamed:@"images.jpeg"];

   
   [toggleButton setImage:img forState:UIControlStateNormal];
    img = [UIImage imageNamed:@"images.png"];
    [toggleButton setImage:img forState:UIControlStateSelected];
    [toggleButton setTag:indexPath.row+100];//set the tag whichever way you wanted it, i set it this way so that the button will have tags that is corresponding with the table's indexpath.row
  [toggleButton setTitle:@"Your" forState:UIControlStateNormal];
    [toggleButton addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [cell.contentView addSubview:toggleButton];
    
    if ([[device valueForKey:@"isDone"] isEqualToString:@"false"] )
    {
        NSLog(@"is equl");
         int x = toggleButton.tag - 100;
       
        
        [selectedButton replaceObjectAtIndex:x withObject:@"NO"];
        [toggleButton setSelected:NO];
         [toggleButton setImage: [UIImage imageNamed:@"images.jpeg"] forState:UIControlStateNormal];

        
       
    }
    else if ([[device valueForKey:@"isDone"] isEqualToString:@"true"] )
        
    {
        NSLog(@"false");
        int x = toggleButton.tag - 100;
        
        
        [selectedButton replaceObjectAtIndex:x withObject:@"YES"];
        [toggleButton setSelected:YES];
        [toggleButton setImage: [UIImage imageNamed:@"images.jpeg"] forState:UIControlStateNormal];
        
    }
    
    
    //and now we set the button's selected state, everytime the table reuse/redraw the cell the button will set it's selected state according to the array
    
    if([[selectedButton objectAtIndex:indexPath.row]isEqualToString:@"NO"])
    {
        [toggleButton setSelected:NO];
    }
    else 
    {
        [toggleButton setSelected:YES];
    }
    
    
  
    cell.date_lbl.layer.borderColor = [UIColor lightGrayColor].CGColor;
    cell.date_lbl.layer.borderWidth = 0.5;
    
    cell.company_lbl.layer.borderColor = [UIColor lightGrayColor].CGColor;
    cell.company_lbl.layer.borderWidth = 0.5;
    
    cell.total_lbl.layer.borderColor = [UIColor lightGrayColor].CGColor;
    cell.total_lbl.layer.borderWidth = 0.5;
    
    cell.currency_lbl.layer.borderColor = [UIColor lightGrayColor].CGColor;
    cell.currency_lbl.layer.borderWidth = 0.5;
    
    cell.box.layer.borderColor = [UIColor lightGrayColor].CGColor;
    cell.box.layer.borderWidth = 0.5;
    

    return  cell;
}
-(void)buttonPressed:(UIButton*)sender
{
    int x = sender.tag - 100; //get the table's row
    if([sender isSelected] ) //if the button is selected, deselect it, and then replace the "YES" in the array with "NO"
    {
        [selectedButton replaceObjectAtIndex:x withObject:@"NO"];
        [sender setSelected:NO];
        NSLog(@"unselected");
        
        Receipt_Detail *newVehicle=[self.devices objectAtIndex:x];
        
        [newVehicle setValue:@"false" forKey:@"isDone"];
        
        [self.managedObjectContext save:nil];
           }
    
    else if (![sender isSelected]) //if the button is unselected, select it, and then replace the "NO" in the array with "YES"
    {
        [selectedButton replaceObjectAtIndex:x withObject:@"YES"];
        [sender setSelected:YES];
         NSLog(@"selected %@",sender.titleLabel.text);
        

        Receipt_Detail *newVehicle=[self.devices objectAtIndex:x];
        [newVehicle setValue:@"true" forKey:@"isDone"];
        
        [self.managedObjectContext save:nil];

         }
}


- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSManagedObjectContext *context = [self managedObjectContext];
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete object from database
        [context deleteObject:[self.devices objectAtIndex:indexPath.row]];
        
        NSError *error = nil;
        if (![context save:&error]) {
            NSLog(@"Can't Delete! %@ %@", error, [error localizedDescription]);
            return;
        }
        
        
        // Remove device from table view
        [self.devices removeObjectAtIndex:indexPath.row];
        [self.table_view deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
//        if ([indexPath section] < 0) {
//            [self.devices removeObjectAtIndex:indexPath.row];
//            [self.table_view deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
//        } else if ([indexPath section] == 0) {
//            [self.table_view deleteSections:[NSIndexSet indexSetWithIndex:[indexPath section]] withRowAnimation:UITableViewRowAnimationFade];
//        }
        
    }
}

//- (UITableViewCellEditingStyle)tableView:(UITableView *)aTableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    if (_table_view.editing)
//    {
//        return UITableViewCellEditingStyleDelete;
//    }
//    
//    return UITableViewCellEditingStyleNone;
//}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}



#pragma mark - Segue

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"UpdateDevice"]) {
        NSManagedObject *selectedDevice = [self.devices objectAtIndex:[[self.table_view indexPathForSelectedRow] row]];
        Receipt_Detail *destViewController = segue.destinationViewController;
        destViewController.device = selectedDevice;
    }
//    else if ([segue.identifier isEqualToString:@"segueName"])
//    {
//        viewController *dvc = (viewController *)[segue destinationViewController];
//        [dvc setSelected:selectedIndex];
//    };
   // }
}




- (IBAction)logout:(id)sender {
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Warning!!" message:@"Are you sure ?" delegate:self cancelButtonTitle:@"No" otherButtonTitles:@"Yes", nil];
    
    [alert show];
    
    

}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex==1)
    {
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"Password"];
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"Username"];
        
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"AlreadyLogi"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        //// adding a new viwcontroller
        
        Login *LoginVC = [self.storyboard instantiateViewControllerWithIdentifier:NSStringFromClass([Login class])];
        
        NSMutableArray *arrayVC = [self.navigationController viewControllers].mutableCopy;
        [arrayVC addObjectsFromArray:@[LoginVC]];
        [self.navigationController setViewControllers:arrayVC animated:NO];
        
        
        //NSArray *arrVC = self.navigationController.viewControllers;
        NSLog(@"ViewControllers%@", arrayVC);
        // [self.navigationController popViewControllerAnimated:YES];
        //        for (UIViewController *aVC in arrayVC)
        //        {
        //            if ([aVC isKindOfClass:[LoginViewController class]])
        //            {
        //                [self.navigationController popToViewController:aVC animated:YES];
        //                break;
        //            }
        //        }
        
    }
}

@end
