//
//  RBTInsertTests.m
//  RBTInsertTests
//
//  Created by Mateusz Stompór on 30/05/2017.
//  Copyright © 2017 Mateusz Stompór. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "RedBlackTree.h"
#import "RedBlackColor.h"

@interface RBTInsertTests : XCTestCase
{
    RedBlackTree<NSNumber*>* tree;
}
@end

@implementation RBTInsertTests

- (void)setUp {
    [super setUp];
    tree= [[RedBlackTree alloc] init];
}

- (void)tearDown {
    [super tearDown];
}

-(void)testInsertValuesCorrect1 {
    XCTAssertTrue([tree countAllNodes] == 0);
    [tree insert:[[NSNumber alloc]initWithInt: 1]];
    XCTAssertTrue([tree countAllNodes] == 1);
    XCTAssertTrue([[tree inOrder:[tree getRoot]] isEqualToString:@"1B "]);
    XCTAssertTrue([tree isValid]);
    [tree insert:[[NSNumber alloc]initWithInt: 2]];
    XCTAssertTrue([tree countAllNodes] == 2);
    XCTAssertTrue([[[tree getRoot] getData] intValue] == 1);
    XCTAssertTrue([[tree getRoot] getColor] == BLACK);
    XCTAssertTrue([tree isValid]);
    XCTAssertTrue([[tree inOrder:[tree getRoot]] isEqualToString:@"1B 2R "]);
    XCTAssertTrue([[tree getRoot] getColor] == BLACK);
    XCTAssertTrue([[[tree getRoot] getData] intValue] == 1);
    [tree insert:[[NSNumber alloc]initWithInt: 3]];
    XCTAssertTrue([tree countAllNodes] == 3);
    XCTAssertTrue([[tree getRoot] getColor] == BLACK);
    XCTAssertTrue([tree isValid]);
    NSLog(@"3 LOG: %@", [tree inOrder:[tree getRoot]]);
    XCTAssertTrue([[tree inOrder:[tree getRoot]] isEqualToString:@"1R 2B 3R "]);
    XCTAssertTrue([[[tree getRoot] getData] intValue] == 2);
    [tree insert:[[NSNumber alloc]initWithInt: 4]];
    XCTAssertTrue([tree countAllNodes] == 4);
    NSLog(@"4 LOG: %@", [tree inOrder:[tree getRoot]]);
    XCTAssertTrue([[tree getRoot] getColor] == BLACK);
    XCTAssertTrue([tree isValid]);
    XCTAssertTrue([[tree inOrder:[tree getRoot]] isEqualToString:@"1B 2B 3B 4R "]);
    NSLog(@"5 LOG: %@", [tree inOrder:[tree getRoot]]);
    XCTAssertTrue([[[tree getRoot] getData] intValue] == 2);
    [tree insert:[[NSNumber alloc]initWithInt: 5]];
    XCTAssertTrue([tree countAllNodes] == 5);
    XCTAssertTrue([tree isValid]);
    XCTAssertTrue([[tree getRoot] getColor] == BLACK);
    XCTAssertTrue([[tree inOrder:[tree getRoot]] isEqualToString:@"1B 2B 3R 4B 5B "]);
}

-(void)testReferences {
    
}

-(void)testInsertValuesCorrect2 {
    [tree insert:[[NSNumber alloc]initWithInt: 1]];
    XCTAssertTrue([[tree inOrder:[tree getRoot]] isEqualToString:@"1B "]);
    [tree insert:[[NSNumber alloc]initWithInt: -1]];
    XCTAssertTrue([[tree inOrder:[tree getRoot]] isEqualToString:@"-1R 1B "]);
    [tree insert:[[NSNumber alloc]initWithInt: -2]];
    XCTAssertTrue([[tree inOrder:[tree getRoot]] isEqualToString:@"-2R -1B 1R "]);
}
@end
