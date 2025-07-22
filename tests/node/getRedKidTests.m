//
//  Created by Mateusz Stompor on 11/06/2019.
//  Copyright © 2019 Mateusz Stompór. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "../../redblacktree/internal/RedBlackNode.h"

@interface getRedKidTests : XCTestCase
{
    RedBlackNode<NSNumber*>* node;
}
@end

@implementation getRedKidTests

- (void)setUp {
    node = [RedBlackNode new];
}

- (void)testNoChildren {
    XCTAssertNil([node getBlackChild]);
}

- (void)testBothRedChildren {
    node.right = [[RedBlackNode alloc] initWithParent:node andValue:[NSNumber numberWithInt:2] color:RED];
    node.left = [[RedBlackNode alloc] initWithParent:node andValue:[NSNumber numberWithInt:3] color:RED];
    XCTAssertTrue([node getRedKid] == node.left || [node getRedKid] == node.right);
}

- (void)testBothBlackChildren {
    node.right = [[RedBlackNode alloc] initWithParent:node andValue:[NSNumber numberWithInt:2] color:BLACK];
    node.left = [[RedBlackNode alloc] initWithParent:node andValue:[NSNumber numberWithInt:3] color:BLACK];
    XCTAssertNil([node getRedKid]);
}

- (void)testOneLeftRedChild {
    node.left = [[RedBlackNode alloc] initWithParent:node andValue:[NSNumber numberWithInt:3] color:RED];
    XCTAssertEqual(node.left, [node getRedKid]);
}

- (void)testOneRightChild {
    node.right = [[RedBlackNode alloc] initWithParent:node andValue:[NSNumber numberWithInt:3] color:RED];
    XCTAssertEqual(node.right, [node getRedKid]);
}

- (void)testOneLeftBlackChild {
    node.left = [[RedBlackNode alloc] initWithParent:node andValue:[NSNumber numberWithInt:3] color:BLACK];
    XCTAssertNil([node getRedKid]);
}

- (void)testOneRightBlackChild {
    node.right = [[RedBlackNode alloc] initWithParent:node andValue:[NSNumber numberWithInt:3] color:BLACK];
    XCTAssertNil([node getRedKid]);
}

@end
