//
//  countTests.m
//  treesTests
//
//  Created by Mateusz Stompór on 30/09/2018.
//  Copyright © 2018 Mateusz Stompór. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "RedBlackTree.h"

@interface CountTests : XCTestCase
{
    RedBlackTree<NSNumber*>* tree;
}
@end

@implementation CountTests

- (void)setUp {
    tree = [[RedBlackTree alloc] init];
}

- (void)testCountOnEmptyTree {
    XCTAssertEqual(0, [tree count]);
}

- (void)testCountOnOneElementTree {
    [tree addObject:[NSNumber numberWithInt:2]];
    XCTAssertEqual(1, [tree count]);
}

@end
