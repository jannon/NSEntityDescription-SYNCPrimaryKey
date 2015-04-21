@import CoreData;

static NSString * const HYPPrimaryKeyDefaultLocal = @"remoteID";
static NSString * const HYPPrimaryKeyDefaultRemote = @"id";

static NSString * const SyncCustomLocalKey = @"hyper.isPrimaryKey";
static NSString * const SyncCustomRemoteKey = @"hyper.remoteKey";

@interface NSEntityDescription (HYPPrimaryKey)

- (NSAttributeDescription *)hyp_primaryKeyAttribute;

- (NSString *)hyp_localKey;

- (NSString *)hyp_remoteKey;

@end
