@import CoreData;

static NSString * const SyncDefaultLocalPrimaryKey = @"remoteID";
static NSString * const SyncDefaultRemotePrimaryKey = @"id";

static NSString * const SyncCustomPrimaryKey = @"hyper.isPrimaryKey";
static NSString * const SyncCustomRemoteKey = @"hyper.remoteKey";

@interface NSEntityDescription (HYPPrimaryKey)

- (NSAttributeDescription *)hyp_primaryKeyAttribute;

- (NSString *)hyp_localKey;

- (NSString *)hyp_remoteKey;

@end
