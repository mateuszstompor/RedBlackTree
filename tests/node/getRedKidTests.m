//
//  Created by Mateusz Stompor on 11/06/2019.
//  Copyright © 2019 Mateusz Stompór. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <redblacktree/redblacktree.h>

@interface getRedKidTests : XCTestCase
{
    RBNode<NSNumber*>* node;
}
@end

@implementation getRedKidTests

- (void)setUp {
    node = [RBNode new];
}

- (void)testNoChildren {
    XCTAssertNil([node getBlackChild]);
}

- (void)testBothRedChildren {
    node.right = [[RBNode alloc] initWithParent:node andValue:[NSNumber numberWithInt:2] color:RED];
    node.left = [[RBNode alloc] initWithParent:node andValue:[NSNumber numberWithInt:3] color:RED];
    XCTAssertTrue([node getRedKid] == node.left || [node getRedKid] == node.right);
}

- (void)testBothBlackChildren {
    node.right = [[RBNode alloc] initWithParent:node andValue:[NSNumber numberWithInt:2] color:BLACK];
    node.left = [[RBNode alloc] initWithParent:node andValue:[NSNumber numberWithInt:3] color:BLACK];
    XCTAssertNil([node getRedKid]);
}

- (void)testOneLeftRedChild {
    node.left = [[RBNode alloc] initWithParent:node andValue:[NSNumber numberWithInt:3] color:RED];
    XCTAssertEqual(node.left, [node getRedKid]);
}

- (void)testOneRightChild {
    node.right = [[RBNode alloc] initWithParent:node andValue:[NSNumber numberWithInt:3] color:RED];
    XCTAssertEqual(node.right, [node getRedKid]);
}

- (void)testOneLeftBlackChild {
    node.left = [[RBNode alloc] initWithParent:node andValue:[NSNumber numberWithInt:3] color:BLACK];
    XCTAssertNil([node getRedKid]);
}

- (void)testOneRightBlackChild {
    node.right = [[RBNode alloc] initWithParent:node andValue:[NSNumber numberWithInt:3] color:BLACK];
    XCTAssertNil([node getRedKid]);
}

@end
