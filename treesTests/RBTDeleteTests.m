//
//  RBTDeleteTests.m
//  RED_BLACK_TREES
//
//  Created by Mateusz Stompór on 30/05/2017.
//  Copyright © 2017 Mateusz Stompór. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "RedBlackTree.h"

@interface RBTDeleteTests : XCTestCase
{
    RedBlackTree<NSNumber*>* tree;
}
@end

@implementation RBTDeleteTests

- (void)setUp {
    [super setUp];
    tree = [[RedBlackTree alloc] initWithComparingBlock:^(NSNumber* a,NSNumber* b){
        if( [a isGreaterThan:b] ){
            return 1;
        } else if ( [a isEqual:b] ){
            return 0;
        } else {
            return -1;
        }
    }];
}

- (void)tearDown {
    [super tearDown];
}

- (void)testAddRootAndDelete {
    [tree insert:[[NSNumber alloc]initWithInt: 34]];
    [tree deleteValue:[[NSNumber alloc]initWithInt: 34]];
    XCTAssertTrue([[tree stringFromInOrder] isEqualToString:@""]);
}

@end
