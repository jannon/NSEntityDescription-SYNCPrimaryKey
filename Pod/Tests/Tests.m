@import CoreData;
@import XCTest;

#import "DATAStack.h"
#import "NSEntityDescription+HYPPrimaryKey.h"

@interface Tests : XCTestCase

@end

@implementation Tests

- (NSEntityDescription *)entityForName:(NSString *)name {
    DATAStack *dataStack = [[DATAStack alloc] initWithModelName:@"Pod"
                                                         bundle:[NSBundle bundleForClass:[self class]]
                                                      storeType:DATAStackInMemoryStoreType];

    return  [NSEntityDescription entityForName:name
                        inManagedObjectContext:dataStack.mainContext];

}

- (void)testPrimaryKeyAttribute {
    NSEntityDescription *entity = [self entityForName:@"User"];

    NSAttributeDescription *attribute = [entity hyp_primaryKeyAttribute];
    XCTAssertEqualObjects(attribute.attributeValueClassName, @"NSNumber");
    XCTAssertEqual(attribute.attributeType, NSInteger32AttributeType);

    entity = [self entityForName:@"Note"];
    attribute = [entity hyp_primaryKeyAttribute];
    XCTAssertEqualObjects(attribute.attributeValueClassName, @"NSNumber");
    XCTAssertEqual(attribute.attributeType, NSInteger32AttributeType);

    entity = [self entityForName:@"Tag"];
    attribute = [entity hyp_primaryKeyAttribute];
    XCTAssertEqualObjects(attribute.attributeValueClassName, @"NSNumber");
    XCTAssertEqual(attribute.attributeType, NSInteger32AttributeType);

    entity = [self entityForName:@"NoID"];
    attribute = [entity hyp_primaryKeyAttribute];
    XCTAssertNil(attribute);
}

- (void)testLocalKey {
    NSEntityDescription *entity = [self entityForName:@"User"];

    XCTAssertEqualObjects([entity hyp_localKey], @"remoteID");

    entity = [self entityForName:@"Note"];
    XCTAssertEqualObjects([entity hyp_localKey], @"uniqueID");

    entity = [self entityForName:@"Tag"];
    XCTAssertEqualObjects([entity hyp_localKey], @"randomId");

    entity = [self entityForName:@"NoID"];
    XCTAssertNil([entity hyp_localKey]);
}

- (void)testRemoteKey {
    NSEntityDescription *entity = [self entityForName:@"User"];
    XCTAssertEqualObjects([entity hyp_remoteKey], @"id");

    entity = [self entityForName:@"Note"];
    XCTAssertEqualObjects([entity hyp_remoteKey], @"unique_id");

    entity = [self entityForName:@"Tag"];
    XCTAssertEqualObjects([entity hyp_remoteKey], @"random_id");

    entity = [self entityForName:@"NoID"];
    XCTAssertNil([entity hyp_remoteKey]);
}

@end
