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
    node.right = [[RBNode alloc] initWithParent:node andValue:[NSNumber numberWithInt:2] color:RB_RED];
    node.left = [[RBNode alloc] initWithParent:node andValue:[NSNumber numberWithInt:3] color:RB_RED];
    XCTAssertTrue([node getRedChild] == node.left || [node getRedChild] == node.right);
}

- (void)testBothBlackChildren {
    node.right = [[RBNode alloc] initWithParent:node andValue:[NSNumber numberWithInt:2] color:RB_BLACK];
    node.left = [[RBNode alloc] initWithParent:node andValue:[NSNumber numberWithInt:3] color:RB_BLACK];
    XCTAssertNil([node getRedChild]);
}

- (void)testOneLeftRedChild {
    node.left = [[RBNode alloc] initWithParent:node andValue:[NSNumber numberWithInt:3] color:RB_RED];
    XCTAssertEqual(node.left, [node getRedChild]);
}

- (void)testOneRightChild {
    node.right = [[RBNode alloc] initWithParent:node andValue:[NSNumber numberWithInt:3] color:RB_RED];
    XCTAssertEqual(node.right, [node getRedChild]);
}

- (void)testOneLeftBlackChild {
    node.left = [[RBNode alloc] initWithParent:node andValue:[NSNumber numberWithInt:3] color:RB_BLACK];
    XCTAssertNil([node getRedChild]);
}

- (void)testOneRightBlackChild {
    node.right = [[RBNode alloc] initWithParent:node andValue:[NSNumber numberWithInt:3] color:RB_BLACK];
    XCTAssertNil([node getRedChild]);
}

@end
