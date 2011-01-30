//
//  DataConnector.h
//  WinFakt
//
//  Created by Tom Adriaenssen on 17/01/11.
//  Copyright 2011 10to1. Some Rights Reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface DataConnector : NSObject {
	NSManagedObjectContext *managedObjectContext_;
    NSManagedObjectModel *managedObjectModel_;
    NSPersistentStoreCoordinator *persistentStoreCoordinator_;
}

@property (nonatomic, retain, readonly) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain, readonly) NSManagedObjectModel *managedObjectModel;
@property (nonatomic, retain, readonly) NSUndoManager *undoManager;
@property (nonatomic, retain, readonly) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (NSString *)applicationDocumentsDirectory;

+ (DataConnector *)sharedInstance;

@end
