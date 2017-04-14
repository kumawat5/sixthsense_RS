//
//  Receipt_Details.h
//  Receipt_Scanner
//
//  Created by ankur kumawat on 20/09/16.
//  Copyright © 2016 sixthsense. All rights reserved.
//
#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface Receipt_Details : NSManagedObject


//@property (nonatomic, retain) NSDate * dob;
//@property (nonatomic, retain) NSString * name;
//@property (nonatomic, retain) NSString * email;
//@property (nonatomic, retain) NSString * gender;
@property (nonatomic, retain) NSString * isDone;
@property (nonatomic, retain) NSData * receiptimage;
@end
