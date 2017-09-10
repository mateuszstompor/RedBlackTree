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

-(void)testInsertValuesCorrect1 {
    XCTAssertTrue([tree countAllNodes] == 0);
    [tree insert:[[NSNumber alloc]initWithInt: 1]];
    XCTAssertTrue([tree countAllNodes] == 1);
    XCTAssertTrue([[tree stringFromInOrder] isEqualToString:@"1B "]);
    XCTAssertTrue([tree isValid]);
    [tree insert:[[NSNumber alloc]initWithInt: 2]];
    XCTAssertTrue([tree countAllNodes] == 2);
    XCTAssertTrue([[[tree getRoot] getData] intValue] == 1);
    XCTAssertTrue([[tree getRoot] getColor] == BLACK);
    XCTAssertTrue([tree isValid]);
    XCTAssertTrue([[tree stringFromInOrder] isEqualToString:@"1B 2R "]);
    XCTAssertTrue([[tree getRoot] getColor] == BLACK);
    XCTAssertTrue([[[tree getRoot] getData] intValue] == 1);
    [tree insert:[[NSNumber alloc]initWithInt: 3]];
    XCTAssertTrue([tree countAllNodes] == 3);
    XCTAssertTrue([[tree getRoot] getColor] == BLACK);
    XCTAssertTrue([tree isValid]);
    XCTAssertTrue([[tree stringFromInOrder] isEqualToString:@"1R 2B 3R "]);
    XCTAssertTrue([[[tree getRoot] getData] intValue] == 2);
    [tree insert:[[NSNumber alloc]initWithInt: 4]];
    XCTAssertTrue([tree countAllNodes] == 4);
    XCTAssertTrue([[tree getRoot] getColor] == BLACK);
    XCTAssertTrue([tree isValid]);
    XCTAssertTrue([[tree stringFromInOrder] isEqualToString:@"1B 2B 3B 4R "]);
    XCTAssertTrue([[[tree getRoot] getData] intValue] == 2);
    [tree insert:[[NSNumber alloc]initWithInt: 5]];
    XCTAssertTrue([tree countAllNodes] == 5);
    XCTAssertTrue([tree isValid]);
    XCTAssertTrue([[tree getRoot] getColor] == BLACK);
    XCTAssertTrue([[tree stringFromInOrder] isEqualToString:@"1B 2B 3R 4B 5R "]);
    //add 6th value
    [tree insert:[[NSNumber alloc]initWithInt: 6]];
    XCTAssertTrue([tree countAllNodes] == 6);
    XCTAssertTrue([tree isValid]);
    XCTAssertTrue([[tree getRoot] getColor] == BLACK);
    XCTAssertTrue([[tree stringFromInOrder] isEqualToString:@"1B 2B 3B 4R 5B 6R "]);
    //add 7th value
    [tree insert:[[NSNumber alloc]initWithInt: 7]];
    XCTAssertTrue([tree countAllNodes] == 7);
    XCTAssertTrue([tree isValid]);
    XCTAssertTrue([[tree getRoot] getColor] == BLACK);
    XCTAssertTrue([[tree stringFromInOrder] isEqualToString:@"1B 2B 3B 4R 5R 6B 7R "]);
}

-(void)testReferences {
    RedBlackTree<NSNumber*>* tempTree = [[RedBlackTree alloc] initWithComparingBlock:^(NSNumber* a,NSNumber* b){
        if( [a isGreaterThan:b] ){
            return 1;
        } else if ( [a isEqual:b] ){
            return 0;
        } else {
            return -1;
        }
    }];
    XCTAssertTrue([tempTree getRoot] == nil);
    [tempTree insert:[[NSNumber alloc] initWithInt:2]];
    XCTAssertNil([[tempTree getRoot] parent]);
    [tempTree insert:[[NSNumber alloc] initWithInt:3]];
    XCTAssertNil([[tempTree getRoot] parent]);
    XCTAssertNil([[tempTree getRoot] leftChild]);
    XCTAssertNotNil([[tempTree getRoot] rightChild]);
    XCTAssertNotNil([[[tempTree getRoot] rightChild] parent]);
    XCTAssertNil([[[tempTree getRoot] rightChild] leftChild]);
    XCTAssertNil([[[tempTree getRoot] rightChild] rightChild]);
}

-(void)testEnumeration {
    __block NSMutableString* mutStr = [[NSMutableString alloc] init];
    [tree insert:[[NSNumber alloc] initWithInt:3]];
    void (^myBlock)(NSNumber*) = ^(NSNumber* number){[mutStr appendString:[[NSString alloc] initWithFormat:@"%i ", [number intValue]]];};
    [tree inOrderCallingBlock:myBlock];
    XCTAssertTrue([mutStr isEqualToString:@"3 "]);
}

-(void)testZigZagRotations {
    [tree insert:[[NSNumber alloc] initWithInt:1]];
    XCTAssertTrue([[tree stringFromInOrder] isEqualToString:@"1B "]);
    [tree insert:[[NSNumber alloc] initWithInt:2]];
    XCTAssertTrue([[tree stringFromInOrder] isEqualToString:@"1B 2R "]);
    [tree insert:[[NSNumber alloc] initWithInt:3]];
    [tree insert:[[NSNumber alloc] initWithInt:55]];
    [tree insert:[[NSNumber alloc] initWithInt:70]];
    [tree insert:[[NSNumber alloc] initWithInt:677]];
    XCTAssertTrue([[tree stringFromInOrder] isEqualToString:@"1B 2B 3B 55R 70B 677R "]);
    [tree insert:[[NSNumber alloc] initWithInt:550]];
    XCTAssertTrue([[tree stringFromInOrder] isEqualToString:@"1B 2B 3B 55R 70R 550B 677R "]);
}

-(void)testZagZigRotations {
    [tree insert:[[NSNumber alloc] initWithInt:1]];
    XCTAssertTrue([[tree stringFromInOrder] isEqualToString:@"1B "]);
    [tree insert:[[NSNumber alloc] initWithInt:-2]];
    XCTAssertTrue([[tree stringFromInOrder] isEqualToString:@"-2R 1B "]);
    [tree insert:[[NSNumber alloc] initWithInt:-3]];
    [tree insert:[[NSNumber alloc] initWithInt:-55]];
    [tree insert:[[NSNumber alloc] initWithInt:-70]];
    [tree insert:[[NSNumber alloc] initWithInt:-677]];
    XCTAssertTrue([[tree stringFromInOrder] isEqualToString:@"-677R -70B -55R -3B -2B 1B "]);
    [tree insert:[[NSNumber alloc] initWithInt:-550]];
    XCTAssertTrue([[tree stringFromInOrder] isEqualToString:@"-677R -550B -70R -55R -3B -2B 1B "]);
}

-(void)testInsertValuesCorrect2 {
    [tree insert:[[NSNumber alloc]initWithInt: 1]];
    XCTAssertTrue([[tree stringFromInOrder] isEqualToString:@"1B "]);
    [tree insert:[[NSNumber alloc]initWithInt: -1]];
    XCTAssertTrue([[tree stringFromInOrder] isEqualToString:@"-1R 1B "]);
    [tree insert:[[NSNumber alloc]initWithInt: -2]];
    XCTAssertTrue([[tree stringFromInOrder] isEqualToString:@"-2R -1B 1R "]);
}
@end
