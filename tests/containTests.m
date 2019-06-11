//
//  containTests.m
//  tests
//
//  Created by Mateusz Stompór on 30/09/2018.
//  Copyright © 2018 Mateusz Stompór. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "RedBlackTree.h"

@interface ContainsTests : XCTestCase
{
    RedBlackTree<NSNumber*>* tree;
}
@end

@implementation ContainsTests

- (void)setUp {
    tree = [[RedBlackTree alloc] init];
}

- (void)testContainsOnEmptyTree {
    XCTAssertTrue(![tree containObject:[NSNumber numberWithInt:2]]);
}

- (void)testContainsOnOneElementTree {
    [tree addObject:[NSNumber numberWithInt:2]];
    XCTAssertTrue([tree containObject:[NSNumber numberWithInt:2]]);
}

@end

