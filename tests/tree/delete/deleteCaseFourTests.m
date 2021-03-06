//
//  deleteCaseFourTests.m
//  tests
//
//  Created by Mateusz Stompór on 30/09/2018.
//  Copyright © 2018 Mateusz Stompór. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "RedBlackTree.h"
#import "../../../redblacktree/internal/RedBlackNode.h"

@interface RedBlackTree (Tests)

@property (nonatomic) NSUInteger count;

-(RedBlackNode<id> *) root;
-(void) setRoot: (RedBlackNode<id> *) root;

@end

@interface DeleteCaseFourTests : XCTestCase
{
    RedBlackTree<NSNumber*>* tree;
}
@end

@implementation DeleteCaseFourTests

- (void) setUp {
    tree = [[RedBlackTree alloc] init];
    id node = [[RedBlackNode alloc] initWithParent:nil andValue: [NSNumber numberWithInt: 10] color: BLACK];
    [node setLeft:[[RedBlackNode alloc] initWithParent:node andValue: [NSNumber numberWithInt: -10] color: BLACK]];
    [node setRight:[[RedBlackNode alloc] initWithParent:node andValue: [NSNumber numberWithInt: 30] color: RED]];
    [[node right] setRight:[[RedBlackNode alloc] initWithParent:[node right] andValue: [NSNumber numberWithInt: 38] color: BLACK]];
    [[node right] setLeft:[[RedBlackNode alloc] initWithParent:[node right] andValue: [NSNumber numberWithInt: 20] color: BLACK]];
    [tree setRoot: node];
    [tree setCount: 5];
}

- (void) testIfAfterDeletionColorseOfNodesAreValid {
    XCTAssertNoThrow([tree removeObject: [NSNumber numberWithInt: 20]]);

    XCTAssertEqual(BLACK, [[tree root] color]);
    XCTAssertEqual(BLACK, [[[tree root] left] color]);
    XCTAssertEqual(BLACK, [[[tree root] right] color]);
    XCTAssertEqual(RED, [[[[tree root] right] right] color]);
}

- (void) testIfAfterDeletionValuesOfNodesAreValid {
    XCTAssertNoThrow([tree removeObject: [NSNumber numberWithInt: 20]]);
    
    XCTAssertEqual(10, [[[tree root] data] intValue]);
    XCTAssertEqual(-10, [[[[tree root] left] data] intValue]);
    XCTAssertEqual(30, [[[[tree root] right] data] intValue]);
    XCTAssertEqual(38, [[[[[tree root] right] right] data] intValue]);
}

- (void) testCountAfterDeletion {
    XCTAssertEqual(5, [tree count]);
    
    XCTAssertNoThrow([tree removeObject: [NSNumber numberWithInt: 20]]);

    XCTAssertEqual(4, [tree count]);
}

- (void) testIfAfterStructureOfNodesIsValid {
    XCTAssertNoThrow([tree removeObject: [NSNumber numberWithInt: 20]]);
    
    XCTAssertNil([[tree root] parent]);
    XCTAssertEqual([tree root], [[[tree root] left] parent]);
    XCTAssertEqual([tree root], [[[tree root] right] parent]);
    XCTAssertNil([[[tree root] left] left]);
    XCTAssertNil([[[tree root] left] right]);
    
    XCTAssertNil([[[tree root] right] left]);
    XCTAssertEqual([[tree root] right], [[[[tree root] right] right] parent]);
    XCTAssertNil([[[[tree root] right] right] right]);
    XCTAssertNil([[[[tree root] right] right] left]);
}

@end
