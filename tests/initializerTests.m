//
//  initializerTests.m
//  treesTests
//
//  Created by Mateusz Stompór on 30/09/2018.
//  Copyright © 2018 Mateusz Stompór. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "RedBlackTree.h"

@interface InitializerTests : XCTestCase
{
    RedBlackTree<NSNumber*>* tree;
}
@end

@implementation InitializerTests

- (void)testDefaultInitializer {
    tree = [[RedBlackTree alloc] init];
    XCTAssertNotNil(tree);
}

@end
