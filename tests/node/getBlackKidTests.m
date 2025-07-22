//
//  Created by Mateusz Stompor on 11/06/2019.
//  Copyright © 2019 Mateusz Stompór. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "../../redblacktree/internal/RedBlackNode.h"

@interface getBlackKidTests : XCTestCase
{
    RedBlackNode<NSNumber*>* node;
}
@end

@implementation getBlackKidTests

- (void)setUp {
    node = [RedBlackNode new];
}

- (void)testNoChildren {
    XCTAssertNil([node getBlackChild]);
}

- (void)testBothRedChildren {
    node.right = [[RedBlackNode alloc] initWithParent:node andValue:[NSNumber numberWithInt:2] color:RED];
    node.left = [[RedBlackNode alloc] initWithParent:node andValue:[NSNumber numberWithInt:3] color:RED];
    XCTAssertNil([node getBlackChild]);
}

- (void)testBothBlackChildren {
    node.right = [[RedBlackNode alloc] initWithParent:node andValue:[NSNumber numberWithInt:2] color:BLACK];
    node.left = [[RedBlackNode alloc] initWithParent:node andValue:[NSNumber numberWithInt:3] color:BLACK];
    XCTAssertTrue([node getBlackChild] == node.right || [node getBlackChild] == node.left);
}

- (void)testOneLeftRedChild {
    node.left = [[RedBlackNode alloc] initWithParent:node andValue:[NSNumber numberWithInt:3] color:RED];
    XCTAssertNil([node getBlackChild]);
}

- (void)testOneRightChild {
    node.right = [[RedBlackNode alloc] initWithParent:node andValue:[NSNumber numberWithInt:3] color:RED];
    XCTAssertNil([node getBlackChild]);
}

- (void)testOneLeftBlackChild {
    node.left = [[RedBlackNode alloc] initWithParent:node andValue:[NSNumber numberWithInt:3] color:BLACK];
    XCTAssertEqual(node.left, [node getBlackChild]);
}

- (void)testOneRightBlackChild {
    node.right = [[RedBlackNode alloc] initWithParent:node andValue:[NSNumber numberWithInt:3] color:BLACK];
    XCTAssertEqual(node.right, [node getBlackChild]);
}

@end
