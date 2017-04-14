//
//  Setting.m
//  Receipt_Scanner
//
//  Created by ankur kumawat on 19/09/16.
//  Copyright © 2016 sixthsense. All rights reserved.
//

#import "Setting.h"

#import <CoreData/CoreData.h>
#import "AddPaymentType.h"
#import "All_Receipt.h"
#import "Loginuser.h"
#import "CoreDataManager.h"
#import "activity_cell.h"
#import "payment_cell.h"
#import "Receipt_Details.h"


@interface Setting ()
@property (strong) NSMutableArray *devices;
@property (strong) NSMutableArray *device;
@property (strong) NSMutableArray *dev;
@end

@implementation Setting
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
     NSLog(@"app dir: %@",[[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject]);
    // Do any additional setup after loading the view.
    self.activity_activity.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.activity_activity.layer.borderWidth = 0.5;
    self.activity_glaccount.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.activity_glaccount.layer.borderWidth = 0.5;
    self.payment_des.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.payment_des.layer.borderWidth = 0.5;
    self.payment_detail.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.payment_detail.layer.borderWidth = 0.5;
    

}
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    // Fetch the devices from persistent data store
    NSManagedObjectContext *managedObjectContext = [self managedObjectContext];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"Addpayment"];
    self.devices = [[managedObjectContext executeFetchRequest:fetchRequest error:nil] mutableCopy];
    [self.table_view reloadData];
    
    NSManagedObjectContext *managedObjectContex = [self managedObjectContext];
    NSFetchRequest *fetchReques = [[NSFetchRequest alloc] initWithEntityName:@"Addactivity"];
    self.device = [[managedObjectContex executeFetchRequest:fetchReques error:nil] mutableCopy];
    
    
    [self.tableview_activity reloadData];
    
    
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
                
    }
    else if ([results count] > 0)
    {
        NSLog(@"ypypy");
        NSManagedObjectContext *managedObjectConte = [self managedObjectContext];
        NSFetchRequest *fetchReque = [[NSFetchRequest alloc] initWithEntityName:@"Loginuser"];
        self.dev = [[managedObjectConte executeFetchRequest:fetchReque error:nil] mutableCopy];
        
        NSManagedObject *data = _dev;
        
        NSArray*getdata =  [data  valueForKey:@"userid"];
        
        NSArray*getpwd =  [data  valueForKey:@"password"];
        
        NSString *myString = [getdata objectAtIndex:0];
        NSString *mypwd = [getpwd objectAtIndex:0];
        
        _tx_username.text=myString;
        _tx_password.text=mypwd;
        
        NSLog(@"data %@",myString);

        
        
    }
    


    

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if(tableView==self.table_view){
        return 1;
    }
    else if (tableView==self.tableview_activity){
        return 1;
    
    }else
        return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(tableView==self.table_view){
        return [self.devices count];
    }else
        return self.device.count;
   }



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    if(tableView == self.table_view)
    
    {
        static  NSString *simpaletableidentifier=@"SimpaleTableItem";
        payment_cell *cell = [tableView dequeueReusableCellWithIdentifier:simpaletableidentifier];
        if (cell==nil) {
            cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpaletableidentifier];
        }
        
        //    //NSLog(@"tableview cell");
        if (indexPath.row % 2) {
            cell.contentView.backgroundColor = [[UIColor alloc]initWithRed:255/255.0 green:246/255.0 blue:246/255.0 alpha:1] ;
        } else {
            cell.contentView.backgroundColor = [UIColor whiteColor] ;
        }
    // Configure the cell...
    NSManagedObject *device = [self.devices objectAtIndex:indexPath.row];
        [cell.des setText:[device valueForKey:@"des"]];
        [cell.detail setText:[device valueForKey:@"detail"]];
        
        cell.des_lbl
        .layer.borderColor = [UIColor lightGrayColor].CGColor;
        cell.des_lbl.layer.borderWidth = 0.5;
        
        cell.detail_lbl.layer.borderColor = [UIColor lightGrayColor].CGColor;
        cell.detail_lbl.layer.borderWidth = 0.5;
//    [cell.textLabel setText:[NSString stringWithFormat:@"%@", [device valueForKey:@"des"]]];
//    [cell.detailTextLabel setText:[device valueForKey:@"detail"]];
        return cell;
    }
    
    else //  (tableView==self.tableview_activity);
    {
        static  NSString *simpaletableidentifier=@"SimpaleTableIte";
        activity_cell *cell = [tableView dequeueReusableCellWithIdentifier:simpaletableidentifier];
        if (cell==nil) {
            cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpaletableidentifier];
        }
        
        //    //NSLog(@"tableview cell");
        if (indexPath.row % 2) {
            cell.contentView.backgroundColor = [[UIColor alloc]initWithRed:255/255.0 green:246/255.0 blue:246/255.0 alpha:1] ;
        } else {
            cell.contentView.backgroundColor = [UIColor whiteColor] ;
        }
        
            NSManagedObject *device = [self.device objectAtIndex:indexPath.row];
        [cell.activity setText:[device valueForKey:@"activityname"]];
         [cell.glaccount setText:[device valueForKey:@"gl_account"]];
        
        cell.activity_lbl
        .layer.borderColor = [UIColor lightGrayColor].CGColor;
        cell.activity_lbl.layer.borderWidth = 0.5;
        
        cell.gl_account_lbl.layer.borderColor = [UIColor lightGrayColor].CGColor;
        cell.gl_account_lbl.layer.borderWidth = 0.5;
//            [cell.textLabel setText:[NSString stringWithFormat:@"%@", [device valueForKey:@"activityname"]]];
//            [cell.detailTextLabel setText:[device valueForKey:@"gl_account"]];
        return cell;
            
        }
    //return cell;
    }


- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}


- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSManagedObjectContext *context = [self managedObjectContext];
    if(tableView == self.table_view)
    {
    
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
    }
    }
    else
    {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete object from database
        [context deleteObject:[self.device objectAtIndex:indexPath.row]];
        
        NSError *error = nil;
        if (![context save:&error]) {
            NSLog(@"Can't Delete! %@ %@", error, [error localizedDescription]);
            return;
        }
        
        // Remove device from table view
        [self.device removeObjectAtIndex:indexPath.row];
        [self.tableview_activity deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
    }
    
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
   
}

- (IBAction)save_setting:(id)sender {
    
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
        NSManagedObjectContext *context = [self managedObjectContext];
        
            // Create a new device
            NSManagedObject *newDevice = [NSEntityDescription insertNewObjectForEntityForName:@"Loginuser" inManagedObjectContext:context];
            
            
            
            [newDevice setValue:self.tx_username.text forKey:@"userid"];
            [newDevice setValue:self.tx_password.text forKey:@"password"];
        for (UIViewController *controller in self.navigationController.viewControllers)
        {
            if ([controller isKindOfClass:[All_Receipt class]])
            {
                [self.navigationController popToViewController:controller
                                                      animated:YES];
                break;
            }
        }

        
        
        NSError *error = nil;
        // Save the object to persistent store
        if (![context save:&error]) {
            NSLog(@"Can't Save! %@ %@", error, [error localizedDescription]);
        }

    }
    else if ([results count] > 0)
    {
        NSLog(@"ypypy");
            NSFetchRequest *fetchRequest=[NSFetchRequest fetchRequestWithEntityName:@"Loginuser"];
        
            Loginuser *newVehicle=[[self.managedObjectContext executeFetchRequest:fetchRequest error:nil] firstObject];
        
              [newVehicle setValue: _tx_username.text forKey:@"userid"];
            [newVehicle setValue: _tx_password.text forKey:@"password"];
        
            [self.managedObjectContext save:nil];
        
            for (UIViewController *controller in self.navigationController.viewControllers)
            {
                if ([controller isKindOfClass:[All_Receipt class]])
                {
                    [self.navigationController popToViewController:controller
                                                          animated:YES];
                    break;
                }
            }
    }
   
   // return YES;



    /////////////////////////////////////////////////////////
//    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
//    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Loginuser" inManagedObjectContext:self.managedObjectContext];
//    [fetchRequest setEntity:entity];
//    
//    NSError *error = nil;
//    NSArray *fetchedObjects = [self.managedObjectContext executeFetchRequest:fetchRequest error:&error];
//    if (fetchedObjects == nil) {
//        NSLog(@"Could not delete Entity Objects");
//    }
//    
//    for (Receipt_Details *currentObject in fetchedObjects) {
//        [self.managedObjectContext deleteObject:currentObject];
//    }
//     [self saveContext];
//   }
//- (void)saveContext
//{
//    NSError *error = nil;
//    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
//    if (managedObjectContext != nil) {
//        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
//            
//            NSLog(@"Saving didn't work so well.. Error: %@, %@", error, [error userInfo]);
//            abort();
//        }
//    }
}
@end
