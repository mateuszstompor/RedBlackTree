//
//  deleteCaseFourTests.m
//  tests
//
//  Created by Mateusz Stompór on 30/09/2018.
//  Copyright © 2018 Mateusz Stompór. All rights reserved.
//

#import <XCTest/XCTest.h>


#import "RedBlackTree.h"
#import "../../redblacktree/internal/RedBlackNode.h"

@interface RedBlackTree (Tests)

-(RedBlackNode<id> *) root;

@end

@interface DeleteCaseFourTests : XCTestCase
{
    RedBlackTree<NSNumber*>* tree;
}
@end

@implementation DeleteCaseFourTests

- (void) setUp {
    tree = [[RedBlackTree alloc] init];
    [tree addObject: [NSNumber numberWithInt: 10]];
    [tree addObject: [NSNumber numberWithInt: -10]];
    [tree addObject: [NSNumber numberWithInt: 30]];
    [tree addObject: [NSNumber numberWithInt: 20]];
    [tree addObject: [NSNumber numberWithInt: 38]];
}

- (void) testIfDeletionDoNotThrow {
    XCTAssertNoThrow([tree removeObject: [NSNumber numberWithInt: 20]]);
}

- (void) testIfAfterDeletionColorsOfNodesAreValid {
    [tree removeObject: [NSNumber numberWithInt: 20]];
    
    XCTAssertEqual(4, [tree count]);
}

@end
