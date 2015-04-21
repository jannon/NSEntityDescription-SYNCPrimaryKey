#import "NSEntityDescription+HYPPrimaryKey.h"

#import "NSString+HYPNetworking.h"

@implementation NSEntityDescription (HYPPrimaryKey)

- (NSAttributeDescription *)hyp_primaryKeyAttribute {
    __block NSAttributeDescription *primaryKeyAttribute;

    [self.propertiesByName enumerateKeysAndObjectsUsingBlock:^(NSString *key,
                                                               NSAttributeDescription *attributeDescription,
                                                               BOOL *stop) {
        NSString *isPrimaryKey = attributeDescription.userInfo[SyncCustomLocalKey];
        BOOL hasCustomPrimaryKey = (isPrimaryKey &&
                                    [isPrimaryKey isEqualToString:@"YES"]);
        if (hasCustomPrimaryKey) {
            primaryKeyAttribute = attributeDescription;
            *stop = YES;
        }

        if ([key isEqualToString:HYPPrimaryKeyDefaultLocal]) {
            primaryKeyAttribute = attributeDescription;
        }
    }];

    return primaryKeyAttribute;
}

- (NSString *)hyp_localKey {
    NSAttributeDescription *primaryAttribute = [self hyp_primaryKeyAttribute];
    NSString *localKey = primaryAttribute.name;

    return localKey;
}

- (NSString *)hyp_remoteKey {
    NSAttributeDescription *primaryAttribute = [self hyp_primaryKeyAttribute];
    NSString *remoteKey = primaryAttribute.userInfo[SyncCustomRemoteKey];

    if (!remoteKey) {
        if ([primaryAttribute.name isEqualToString:HYPPrimaryKeyDefaultLocal]) {
            remoteKey = HYPPrimaryKeyDefaultRemote;
        } else {
            remoteKey = [primaryAttribute.name hyp_remoteString];
        }

    }

    return remoteKey;
}

@end


