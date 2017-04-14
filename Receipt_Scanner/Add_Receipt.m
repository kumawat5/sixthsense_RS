//
//  Add_Receipt.m
//  Receipt_Scanner
//
//  Created by ankur kumawat on 17/09/16.
//  Copyright © 2016 sixthsense. All rights reserved.
//

#import "Add_Receipt.h"
#import <CoreData/CoreData.h>

@interface Add_Receipt ()

@end

@implementation Add_Receipt

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

- (IBAction)cnfrm:(id)sender {
    NSManagedObjectContext *context = [self managedObjectContext];
    
//    if (self.device) {
//        // Update existing device
//        [self.device setValue:self.tx_activity.text forKey:@"activity"];
//        [self.device setValue:self.tx_payment.text forKey:@"payment"];
//        [self.device setValue:self.tx_total.text forKey:@"total"];
//        [self.device setValue:self.tx_notes.text forKey:@"notes"];
//        [self.device setValue:self.tx_date.text forKey:@"date"];
//        [self.device setValue:self.tx_tax.text forKey:@"tax"];
//        [self.device setValue:self.tx_company.text forKey:@"company"];
//        
//        
//        
//    } else {
        // Create a new device
        NSManagedObject *newDevice = [NSEntityDescription insertNewObjectForEntityForName:@"Receipt_Details" inManagedObjectContext:context];
        
        [newDevice setValue:self.tx_activity.text forKey:@"activity"];
        [newDevice setValue:self.tx_payment.text forKey:@"payment"];
        [newDevice setValue:self.tx_total.text forKey:@"total"];
        [newDevice setValue:self.tx_notes.text forKey:@"notes"];
        [newDevice setValue:self.tx_date.text forKey:@"date"];
        [newDevice setValue:self.tx_tax.text forKey:@"tax"];
        [newDevice setValue:self.tx_company.text forKey:@"company"];
    //}
    
    NSError *error = nil;
    // Save the object to persistent store
    if (![context save:&error]) {
        NSLog(@"Can't Save! %@ %@", error, [error localizedDescription]);
    }
    //[self dismissViewControllerAnimated:YES completion:nil];
    
}
@end
