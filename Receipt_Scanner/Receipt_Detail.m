//
//  Receipt_Detail.m
//  Receipt_Scanner
//
//  Created by ankur kumawat on 17/09/16.
//  Copyright © 2016 sixthsense. All rights reserved.
//

#import "Receipt_Detail.h"
#import "All_Receipt.h"
#import "Receipt_Details.h"
#import "CoreDataManager.h"

@interface Receipt_Detail ()
{
    UIImage*image;
    UIImage *chosenImage;
}
@property (strong) NSMutableArray *activity;
@property (strong) NSMutableArray *payment;


@end

@implementation Receipt_Detail
@synthesize device;
UIDatePicker *datePicker;




- (NSManagedObjectContext *)managedObjectContext {
    NSManagedObjectContext *context = nil;
    id delegate = [[UIApplication sharedApplication] delegate];
    if ([delegate performSelector:@selector(managedObjectContext)]) {
        context = [delegate managedObjectContext];
    }
    return context;
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"dd/MM/YYYY"];
    NSDate *todaysDate;
    todaysDate = [NSDate date];
     NSLog(@"Todays date is %@",[formatter stringFromDate:todaysDate]);
    _tx_date.text=[formatter stringFromDate:todaysDate];

        
    self.activity_table.hidden=YES;
    self.payment_table.hidden=YES; 
    
   
   
    datePicker = [[UIDatePicker alloc]init];
    [datePicker setDate:[NSDate date]];
    datePicker.datePickerMode = UIDatePickerModeDate;
    [datePicker addTarget:self action:@selector(dateTextField:) forControlEvents:UIControlEventValueChanged];
    [_tx_date setInputView:datePicker];
   
    // Do any additional setup after loading the view.
    if (self.device) {
        [self.tx_company setText:[self.device valueForKey:@"company"]];
        [self.tx_tax setText:[self.device valueForKey:@"tax"]];
        [self.tx_date setText:[self.device valueForKey:@"date"]];
         [self.tx_notes setText:[self.device valueForKey:@"notes"]];
         [self.tx_total setText:[self.device valueForKey:@"total"]];
         [self.tx_payment setText:[self.device valueForKey:@"payment"]];
         [self.tx_activity setText:[self.device valueForKey:@"activity"]];
      
       UIImage *image = [UIImage imageWithData:[device valueForKey:@"receiptimage"]];
        
        _camera_img.image= image;
      
    }
    if ([[device valueForKey:@"isDone"] isEqualToString:@"true"]) {
        self.sync_img.image = [UIImage imageNamed:@"fav.png"];
        self.sync_lbl.text=@"synced";
        
    }
    else if ([[device valueForKey:@"isDone"] isEqualToString:@"false"]){
         self.sync_img.image = [UIImage imageNamed:@"minus-4-512.png"];
        self.sync_lbl.text=@"synced";

    }

}
-(void) dateTextField:(id)sender
{
    UIDatePicker *picker = (UIDatePicker*)_tx_date.inputView;
    [picker setMaximumDate:[NSDate date]];
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    NSDate *eventDate = picker.date;
    [dateFormat setDateFormat:@"dd/MM/yyyy"];
    
    NSString *dateString = [dateFormat stringFromDate:eventDate];
    _tx_date.text = [NSString stringWithFormat:@"%@",dateString];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    // Fetch the devices from persistent data store
    NSManagedObjectContext *managedObjectContext = [self managedObjectContext];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"Addpayment"];
    self.payment = [[managedObjectContext executeFetchRequest:fetchRequest error:nil] mutableCopy];
    [self.payment_table reloadData];
    [self.payment_table.layer setBorderWidth: 1.0];
    [self.payment_table.layer setCornerRadius:8.0f];
    [self.payment_table.layer setMasksToBounds:YES];
    [self.payment_table.layer setBorderColor:[[UIColor blackColor] CGColor]];

    
    NSManagedObjectContext *managedObjectContex = [self managedObjectContext];
    NSFetchRequest *fetchReques = [[NSFetchRequest alloc] initWithEntityName:@"Addactivity"];
    self.activity = [[managedObjectContex executeFetchRequest:fetchReques error:nil] mutableCopy];
    
    // NSManagedObject *device = [self.devices objectAtIndex];
    //  NSLog(@"get data %@",device valueForKey:@"detail");
    
    [self.activity_table reloadData];
    [self.activity_table.layer setBorderWidth: 1.0];
    [self.activity_table.layer setCornerRadius:8.0f];
    [self.activity_table.layer setMasksToBounds:YES];
    [self.activity_table.layer setBorderColor:[[UIColor blackColor] CGColor]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if(tableView==self.activity_table){
        NSInteger numOfSections = 0;
        if ([self.activity count] > 0)
        {
            self.activity_table.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
            numOfSections                 = 1;
            //yourTableView.backgroundView   = nil;
            self.activity_table.backgroundView = nil;
        }
        else
        {
            UILabel *noDataLabel         = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.activity_table.bounds.size.width, self.activity_table.bounds.size.height)];
            noDataLabel.text = @"Add Activity Go To Setting";
            noDataLabel.textColor        = [UIColor blueColor];
            noDataLabel.textAlignment    = NSTextAlignmentCenter;
            noDataLabel.numberOfLines = 0;
            //yourTableView.backgroundView = noDataLabel;
            //yourTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
            self.activity_table.backgroundView = noDataLabel;
            self.activity_table.separatorStyle = UITableViewCellSeparatorStyleNone;
        }
        
        return numOfSections;
        //return 1;
    }
    else
    {
        NSInteger numOfSection = 0;
        if ([self.payment count] > 0)
        {
            self.payment_table.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
            numOfSection                 = 1;
            //yourTableView.backgroundView   = nil;
            self.payment_table.backgroundView = nil;
        }
        else
        {
            UILabel *noDataLabel         = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.payment_table.bounds.size.width, self.payment_table.bounds.size.height)];
            noDataLabel.text = @"Add Payment Type Go To Setting";
            noDataLabel.textColor        = [UIColor blueColor];
            noDataLabel.textAlignment    = NSTextAlignmentCenter;
            noDataLabel.numberOfLines = 0;
            //yourTableView.backgroundView = noDataLabel;
            //yourTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
            self.payment_table.backgroundView = noDataLabel;
            self.payment_table.separatorStyle = UITableViewCellSeparatorStyleNone;
        }
        
        return numOfSection;
       // return 1;
    }
   
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(tableView==self.activity_table){
        return [self.activity count];
    }else
        return self.payment.count;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static  NSString *simpaletableidentifier=@"SimpaleTableItem";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpaletableidentifier];
    if (cell==nil) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpaletableidentifier];
    }
    
    //    //NSLog(@"tableview cell");
    if (indexPath.row % 2) {
        cell.contentView.backgroundColor = [[UIColor alloc]initWithRed:255/255.0 green:246/255.0 blue:246/255.0 alpha:1] ;
    } else {
        cell.contentView.backgroundColor = [UIColor whiteColor] ;
    }
    
    if(tableView == self.payment_table)
        
    {
        // Configure the cell...
        NSManagedObject *device = [self.payment objectAtIndex:indexPath.row];
        [cell.textLabel setText:[NSString stringWithFormat:@"%@", [device valueForKey:@"des"]]];
        //[cell.detailTextLabel setText:[device valueForKey:@"detail"]];
        return cell;
    }
    
    else //  (tableView==self.tableview_activity);
    {
        NSManagedObject *device = [self.activity objectAtIndex:indexPath.row];
        [cell.textLabel setText:[NSString stringWithFormat:@"%@", [device valueForKey:@"activityname"]]];
       // [cell.detailTextLabel setText:[device valueForKey:@"gl_account"]];
        return cell;
        
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView==self.activity_table) {
        UITableViewCell *cell =[self.activity_table cellForRowAtIndexPath:indexPath];
        //[self.btnoutlet setTitle:cell.textLabel.text forState:UIControlStateNormal];
        self.activity_table.hidden=YES;
        self.tx_activity.text= cell.textLabel.text;
    }else if (tableView==self.payment_table){
        UITableViewCell *cell =[self.payment_table cellForRowAtIndexPath:indexPath];
        self.tx_payment.text= cell.textLabel.text;
        self.payment_table.hidden=YES;
        
    }
}

- (IBAction)take_recept:(id)sender {
    
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        picker.allowsEditing = YES;
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    
        [self presentViewController:picker animated:YES completion:NULL];
}

#pragma  mark - ImagePickerDelegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [picker dismissViewControllerAnimated:YES completion:nil];
    NSLog(@"Info = %@", info);
    
   chosenImage = [info objectForKey:UIImagePickerControllerEditedImage];
    self.camera_img.image= chosenImage;
   }


- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {

    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}


- (IBAction)confirm:(id)sender {
    if (![self isFormValid]) {
        
        return;
        
    }
    
    NSError *error;
    
    
    if (!error)
    {
        // call webservice for succes

    
    NSManagedObjectContext *context = [self managedObjectContext];
    
    if (self.device) {
        // Update existing device
        [self.device setValue:self.tx_activity.text forKey:@"activity"];
        [self.device setValue:self.tx_payment.text forKey:@"payment"];
        [self.device setValue:self.tx_total.text forKey:@"total"];
        [self.device setValue:self.tx_notes.text forKey:@"notes"];
        [self.device setValue:self.tx_date.text forKey:@"date"];
        [self.device setValue:self.tx_tax.text forKey:@"tax"];
        [self.device setValue:self.tx_company.text forKey:@"company"];
        NSData *imageData = UIImagePNGRepresentation(chosenImage);
        [self.device setValue:imageData forKey:@"receiptimage"];
   

        
    } else {
        // Create a new device
        NSManagedObject *newDevice = [NSEntityDescription insertNewObjectForEntityForName:@"Receipt_Details" inManagedObjectContext:context];
        
       
        
        NSData *imageData = UIImagePNGRepresentation(chosenImage);
        [newDevice setValue:imageData forKey:@"receiptimage"];
        
        
        
        [newDevice setValue:self.tx_activity.text forKey:@"activity"];
        [newDevice setValue:self.tx_payment.text forKey:@"payment"];
        [newDevice setValue:self.tx_total.text forKey:@"total"];
        [newDevice setValue:self.tx_notes.text forKey:@"notes"];
        [newDevice setValue:self.tx_date.text forKey:@"date"];
        [newDevice setValue:self.tx_tax.text forKey:@"tax"];
        [newDevice setValue:self.tx_company.text forKey:@"company"];
        
        
//        [[NSUserDefaults standardUserDefaults] setObject:_tx_total.text forKey:@"Username"];
//        [[NSUserDefaults standardUserDefaults] setObject:_tx_tax.text forKey:@"Password"];
    }
    
    NSError *error = nil;
    // Save the object to persistent store
    if (![context save:&error]) {
        NSLog(@"Can't Save! %@ %@", error, [error localizedDescription]);
    }
   // [self dismissViewControllerAnimated:YES completion:nil];
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

}

- (IBAction)cancel:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)activity_action:(id)sender {
    if (self.activity_table.hidden==YES) {
        self.activity_table.hidden=NO;
    }else{
        self.activity_table.hidden=YES;
    }

}

- (IBAction)payment_action:(id)sender {
    if (self.payment_table.hidden==YES) {
        self.payment_table.hidden=NO;
    }else{
        self.payment_table.hidden=YES;
    }
}



- (BOOL)textFieldShouldReturn:(UITextField *)textField

{
    [self.tx_date resignFirstResponder];
    [self.tx_payment resignFirstResponder];
    [self.tx_activity resignFirstResponder];
    [self.tx_tax resignFirstResponder];
    [self.tx_notes resignFirstResponder];
    [self.tx_total resignFirstResponder];
    [self.tx_company resignFirstResponder];
 

    return YES;
}

-(BOOL)isFormValid
{
    if (_tx_company.text && _tx_company.text.length==0)
    {
        [self showErrorMessage:@"Please Enter Company"];
        return NO;
    }
    
    
    else if (_tx_activity.text && _tx_activity.text.length==0)
    {
        [self showErrorMessage:@"Please Select Activity"];
        return NO;
    }
    else if (_tx_tax.text && _tx_tax.text.length==0)
    {
        [self showErrorMessage:@"Please Enter Tax"];
        return NO;
    }
    else if (_tx_total.text && _tx_total.text.length==0)
    {
        [self showErrorMessage:@"Please Enter Total"];
        return NO;
    }
        else if (_tx_payment.text && _tx_payment.text.length==0)
        {
            [self showErrorMessage:@"Please select payment"];
            return NO;
        }
        else if (_tx_notes.text && _tx_notes.text.length==0)
        {
            [self showErrorMessage:@"Please Enter Note"];
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
