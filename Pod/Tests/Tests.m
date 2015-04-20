@import CoreData;
@import XCTest;

#import "DATAStack.h"
#import "NSEntityDescription+HYPPrimaryKey.h"

@interface Tests : XCTestCase

@end

@implementation Tests

- (DATAStack *)dataStack {
    return [[DATAStack alloc] initWithModelName:@"Pod"
                                         bundle:[NSBundle bundleForClass:[self class]]
                                      storeType:DATAStackInMemoryStoreType];
}


- (void)testRemoteKey {
    DATAStack *dataStack = [self dataStack];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"User"
                                              inManagedObjectContext:dataStack.mainContext];

    XCTAssertEqualObjects([entity hyp_remoteKey], @"id");
}

- (void)testLocalKey {
    DATAStack *dataStack = [self dataStack];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"User"
                                              inManagedObjectContext:dataStack.mainContext];

    XCTAssertEqualObjects([entity hyp_localKey], @"remoteID");
}

- (void)testPrimaryKeyAttribute {
    DATAStack *dataStack = [self dataStack];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"User"
                                              inManagedObjectContext:dataStack.mainContext];

    NSAttributeDescription *attribute = [entity hyp_primaryKeyAttribute];
    XCTAssertEqualObjects(attribute.attributeValueClassName, @"NSNumber");
    XCTAssertEqual(attribute.attributeType, NSInteger32AttributeType);
}

@end
