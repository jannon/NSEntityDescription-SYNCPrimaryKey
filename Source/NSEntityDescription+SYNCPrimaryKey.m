#import "NSEntityDescription+SYNCPrimaryKey.h"

#import "NSString+HYPNetworking.h"

@interface NSEntityDescriptionPrimaryKeyStorage : NSObject

@property (nonatomic, strong) NSMutableDictionary *storage;
@property (nonatomic, strong) NSLock *lock;

@end

@implementation NSEntityDescriptionPrimaryKeyStorage

+ (instancetype)sharedInstance {
    static dispatch_once_t once;
    static NSEntityDescriptionPrimaryKeyStorage *sharedInstance;
    dispatch_once(&once, ^{
        sharedInstance = [self new];
    });
    return sharedInstance;
}

- (NSMutableDictionary *)storage {
    if (!_storage) {
        _storage = [NSMutableDictionary new];
    }

    return _storage;
}

- (NSLock *)lock {
    if (!_lock) {
        _lock = [NSLock new];
    }

    return _lock;
}

@end

@implementation NSEntityDescription (SYNCPrimaryKey)

- (nonnull NSAttributeDescription *)sync_primaryKeyAttribute {
    __block NSAttributeDescription *primaryKeyAttribute = [[[NSEntityDescriptionPrimaryKeyStorage sharedInstance] storage] objectForKey:self.name];
    if (primaryKeyAttribute) {
        return primaryKeyAttribute;
    } else {
        [self.propertiesByName enumerateKeysAndObjectsUsingBlock:^(NSString *key,
                                                                   NSAttributeDescription *attributeDescription,
                                                                   BOOL *stop) {
            NSString *isPrimaryKey = attributeDescription.userInfo[SYNCCustomLocalPrimaryKey];
            BOOL hasCustomPrimaryKey = (isPrimaryKey &&
                                        ([isPrimaryKey isEqualToString:SYNCCustomLocalPrimaryKeyValue] || [isPrimaryKey isEqualToString:SYNCCustomLocalPrimaryKeyAlternativeValue]) );
            if (hasCustomPrimaryKey) {
                primaryKeyAttribute = attributeDescription;
                *stop = YES;
            }

            if ([key isEqualToString:SYNCDefaultLocalPrimaryKey] || [key isEqualToString:SYNCDefaultLocalCompatiblePrimaryKey]) {
                primaryKeyAttribute = attributeDescription;
            }
        }];

        [[[NSEntityDescriptionPrimaryKeyStorage sharedInstance] lock] lock];
        if (primaryKeyAttribute) {
            [[[NSEntityDescriptionPrimaryKeyStorage sharedInstance] storage] setObject:primaryKeyAttribute forKey:self.name];
        } else {
            [[[NSEntityDescriptionPrimaryKeyStorage sharedInstance] storage] removeObjectForKey:self.name];
        }
        [[[NSEntityDescriptionPrimaryKeyStorage sharedInstance] lock] unlock];

        return primaryKeyAttribute;
    }
}

- (nonnull NSString *)sync_localPrimaryKey {
    NSAttributeDescription *primaryAttribute = [self sync_primaryKeyAttribute];
    NSString *localKey = primaryAttribute.name;

    return localKey;
}

- (nonnull NSString *)sync_remotePrimaryKey {
    NSAttributeDescription *primaryKeyAttribute = [self sync_primaryKeyAttribute];
    NSString *remoteKey = primaryKeyAttribute.userInfo[SYNCCustomRemoteKey];

    if (!remoteKey) {
        if ([primaryKeyAttribute.name isEqualToString:SYNCDefaultLocalPrimaryKey] || [primaryKeyAttribute.name isEqualToString:SYNCDefaultLocalCompatiblePrimaryKey]) {
            remoteKey = SYNCDefaultRemotePrimaryKey;
        } else {
            remoteKey = [primaryKeyAttribute.name hyp_remoteString];
        }

    }

    return remoteKey;
}

- (nonnull NSString *)sync_localKey {
    return [self sync_localPrimaryKey];
}

- (nonnull NSString *)sync_remoteKey {
    return [self sync_remotePrimaryKey];
}

@end
