//
//  CoreDataManager.h
//  CoreDataMinProject
//
//  Created by InfoEnumY04 on 23/07/15.
//  Copyright (c) 2015 InfoEnumY04. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@import CoreData;

@class Receipt_Details;

@interface CoreDataManager : NSObject

+ (instancetype)sharedManager;

//Accessors
- (Receipt_Details*)newUserInfo;
-(NSArray*)fetchUserInfo;
-(Receipt_Details*)fetchUserInfoWithEmail:(NSString*)email;
-(NSArray*)fetchUserInfoWithEmail:(NSString*)email andPassword:(NSString*)password;

//Core data stack
@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

@end
