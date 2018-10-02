//
//  deleteCaseThreeTests.m
//  tests
//
//  Created by Mateusz Stompór on 30/09/2018.
//  Copyright © 2018 Mateusz Stompór. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "RedBlackTree.h"
#import "../../redblacktree/internal/RedBlackNode.h"

@interface RedBlackTree (Tests)

@property (nonatomic) NSUInteger count;

-(RedBlackNode<id> *) root;
-(void) setRoot: (RedBlackNode<id> *) root;

@end

@interface DeleteCaseThreeTests : XCTestCase
{
    RedBlackTree<NSNumber*>* tree;
}
@end

@implementation DeleteCaseThreeTests

- (void) setUp {
    tree = [[RedBlackTree alloc] init];
    id node = [[RedBlackNode alloc] initWithParent:nil andValue: [NSNumber numberWithInt: 10] color: BLACK];
    [node setLeft:[[RedBlackNode alloc] initWithParent:node andValue: [NSNumber numberWithInt: -30] color: BLACK]];
    [node setRight:[[RedBlackNode alloc] initWithParent:node andValue: [NSNumber numberWithInt: 50] color: BLACK]];
    
    [[node right] setRight:[[RedBlackNode alloc] initWithParent:[node right] andValue: [NSNumber numberWithInt: 70] color: BLACK]];
    [[node right] setLeft:[[RedBlackNode alloc] initWithParent:[node right] andValue: [NSNumber numberWithInt: 30] color: RED]];
    
    [[node left] setRight:[[RedBlackNode alloc] initWithParent:[node left] andValue: [NSNumber numberWithInt: -20] color: BLACK]];
    [[node left] setLeft:[[RedBlackNode alloc] initWithParent:[node left] andValue: [NSNumber numberWithInt: -40] color: BLACK]];
    
    [[[node right] left] setLeft:[[RedBlackNode alloc] initWithParent:[[node right] left] andValue: [NSNumber numberWithInt: 15] color: BLACK]];
    [[[node right] left] setRight:[[RedBlackNode alloc] initWithParent:[[node right] left] andValue: [NSNumber numberWithInt: 40] color: BLACK]];
    
    [tree setRoot: node];
    [tree setCount:9];
}

- (void) testCountAfterDeletion {
    XCTAssertEqual(9, [tree count]);
    
    XCTAssertNoThrow([tree removeObject: [NSNumber numberWithInt: -40]]);
    
//    XCTAssertEqual(8, [tree count]);
}

- (void) testValuesAfterDeletion {
    XCTAssertNoThrow([tree removeObject: [NSNumber numberWithInt: -40]]);
    
    XCTAssertEqual([[[tree root] data] intValue], 30);
    XCTAssertEqual([[[[tree root] left] data] intValue], 10);
    XCTAssertEqual([[[[[tree root] left] right] data] intValue], 15);
    XCTAssertEqual([[[[[tree root] left] left] data] intValue], -30);
    XCTAssertEqual([[[[[[tree root] left] left] right] data] intValue], -20);
    XCTAssertEqual([[[[tree root] right] data] intValue], 50);
    XCTAssertEqual([[[[[tree root] right] right] data] intValue], 70);
    XCTAssertEqual([[[[[tree root] right] left] data] intValue], 40);
}

@end

