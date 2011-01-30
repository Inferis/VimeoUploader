// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Account.h instead.

#import <CoreData/CoreData.h>








@interface AccountID : NSManagedObjectID {}
@end

@interface _Account : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (AccountID*)objectID;



@property (nonatomic, retain) NSString *name;

//- (BOOL)validateName:(id*)value_ error:(NSError**)error_;



@property (nonatomic, retain) NSString *accessToken;

//- (BOOL)validateAccessToken:(id*)value_ error:(NSError**)error_;



@property (nonatomic, retain) NSString *username;

//- (BOOL)validateUsername:(id*)value_ error:(NSError**)error_;



@property (nonatomic, retain) NSString *accessTokenSecret;

//- (BOOL)validateAccessTokenSecret:(id*)value_ error:(NSError**)error_;





+ (NSArray*)fetchAll:(NSManagedObjectContext*)moc_ ;
+ (NSArray*)fetchAll:(NSManagedObjectContext*)moc_ error:(NSError**)error_;



@end

@interface _Account (CoreDataGeneratedAccessors)

@end

@interface _Account (CoreDataGeneratedPrimitiveAccessors)

- (NSString*)primitiveName;
- (void)setPrimitiveName:(NSString*)value;


- (NSString*)primitiveAccessToken;
- (void)setPrimitiveAccessToken:(NSString*)value;


- (NSString*)primitiveUsername;
- (void)setPrimitiveUsername:(NSString*)value;


- (NSString*)primitiveAccessTokenSecret;
- (void)setPrimitiveAccessTokenSecret:(NSString*)value;



@end
