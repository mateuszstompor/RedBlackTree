//
//  insertTests.m
//  insertTests
//
//  Created by Mateusz Stompór on 30/05/2017.
//  Copyright © 2017 Mateusz Stompór. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "RedBlackTree.h"
#import "../redblacktree/internal/RedBlackNode.h"

@interface RedBlackTree (Tests)

-(RedBlackNode<id> *) root;

@end

@interface InsertTests : XCTestCase
{
    RedBlackTree<NSNumber*>* tree;
}
@end

@implementation InsertTests

- (void) setUp {
    tree = [[RedBlackTree alloc] init];
}

- (void) tearDown {
    [super tearDown];
}

- (void) testInsertionToEmptyTree {
    [tree add: [NSNumber numberWithInt:3]];
    XCTAssertNotNil([tree root]);
    XCTAssertEqual([[tree root] color], BLACK);
    XCTAssertNil([[tree root] parent]);
    XCTAssertNil([[tree root] left]);
    XCTAssertNil([[tree root] right]);
}

@end
