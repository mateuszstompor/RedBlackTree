//
//  Created by Mateusz Stompor on 11/06/2019.
//  Copyright © 2019 Mateusz Stompór. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <redblacktree/redblacktree.h>

@interface getBlackKidTests : XCTestCase
{
    RBNode<NSNumber*>* node;
}
@end

@implementation getBlackKidTests

- (void)setUp {
    node = [RBNode new];
}

- (void)testNoChildren {
    XCTAssertNil([node getBlackChild]);
}

- (void)testBothRedChildren {
    node.right = [[RBNode alloc] initWithParent:node andValue:[NSNumber numberWithInt:2] color:RB_RED];
    node.left = [[RBNode alloc] initWithParent:node andValue:[NSNumber numberWithInt:3] color:RB_RED];
    XCTAssertNil([node getBlackChild]);
}

- (void)testBothBlackChildren {
    node.right = [[RBNode alloc] initWithParent:node andValue:[NSNumber numberWithInt:2] color:RB_BLACK];
    node.left = [[RBNode alloc] initWithParent:node andValue:[NSNumber numberWithInt:3] color:RB_BLACK];
    XCTAssertTrue([node getBlackChild] == node.right || [node getBlackChild] == node.left);
}

- (void)testOneLeftRedChild {
    node.left = [[RBNode alloc] initWithParent:node andValue:[NSNumber numberWithInt:3] color:RB_RED];
    XCTAssertNil([node getBlackChild]);
}

- (void)testOneRightChild {
    node.right = [[RBNode alloc] initWithParent:node andValue:[NSNumber numberWithInt:3] color:RB_RED];
    XCTAssertNil([node getBlackChild]);
}

- (void)testOneLeftBlackChild {
    node.left = [[RBNode alloc] initWithParent:node andValue:[NSNumber numberWithInt:3] color:RB_BLACK];
    XCTAssertEqual(node.left, [node getBlackChild]);
}

- (void)testOneRightBlackChild {
    node.right = [[RBNode alloc] initWithParent:node andValue:[NSNumber numberWithInt:3] color:RB_BLACK];
    XCTAssertEqual(node.right, [node getBlackChild]);
}

@end
