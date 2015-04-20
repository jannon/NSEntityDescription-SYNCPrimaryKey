@import CoreData;

static NSString * const SyncDefaultLocalPrimaryKey = @"remoteID";
static NSString * const SyncDefaultRemotePrimaryKey = @"id";

static NSString * const SyncCustomPrimaryKey = @"hyper.isPrimaryKey";
static NSString * const SyncCustomRemoteKey = @"hyper.remoteKey";

@interface NSEntityDescription (HYPPrimaryKey)

- (NSString *)hyp_remoteKey;

- (NSString *)hyp_localKey;

- (NSAttributeDescription *)hyp_primaryKeyAttribute;

@end
