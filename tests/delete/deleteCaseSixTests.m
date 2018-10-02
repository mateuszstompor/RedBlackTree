//
//  deleteCaseSixTests.m
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

@interface DeleteCaseSixTests : XCTestCase
{
    RedBlackTree<NSNumber*>* tree;
}
@end

@implementation DeleteCaseSixTests

- (void) setUp {
    tree = [[RedBlackTree alloc] init];
    id node = [[RedBlackNode alloc] initWithParent:nil andValue: [NSNumber numberWithInt: 10] color: BLACK];
    [node setLeft:[[RedBlackNode alloc] initWithParent:node andValue: [NSNumber numberWithInt: -10] color: BLACK]];
    [node setRight:[[RedBlackNode alloc] initWithParent:node andValue: [NSNumber numberWithInt: 30] color: BLACK]];
    [[node right] setRight:[[RedBlackNode alloc] initWithParent:[node right] andValue: [NSNumber numberWithInt: 40] color: RED]];
    [[node right] setLeft:[[RedBlackNode alloc] initWithParent:[node right] andValue: [NSNumber numberWithInt: 25] color: RED]];
    [tree setRoot: node];
    [tree setCount: 5];
}

@end
