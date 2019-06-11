//
//  deleteCaseOneTests.m
//  tests
//
//  Created by Mateusz Stompór on 30/09/2018.
//  Copyright © 2018 Mateusz Stompór. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "RedBlackTree.h"
#import "../../../redblacktree/internal/RedBlackNode.h"

@interface RedBlackTree (Tests)

-(RedBlackNode<id> *) root;

@end

@interface DeleteCaseOneTests : XCTestCase
{
    RedBlackTree<NSNumber*>* tree;
}
@end

@implementation DeleteCaseOneTests

- (void) setUp {
    tree = [[RedBlackTree alloc] init];
}

- (void) testDeleteOnEmptyTree {
    XCTAssertNoThrow([tree removeObject:[NSNumber numberWithInt:2]]);
}

-(void) testDeleteOnRootOnlyTree {
    [tree addObject:[NSNumber numberWithInt:2]];
    
    XCTAssertNoThrow([tree removeObject:[NSNumber numberWithInt:2]]);
    XCTAssertTrue(![tree containObject:[NSNumber numberWithInt:2]]);
}

-(void) testDeleteColoringOnRootWithLeftChildTree {
    [tree addObject:[NSNumber numberWithInt:2]];
    [tree addObject:[NSNumber numberWithInt:1]];
    
    XCTAssertNoThrow([tree removeObject:[NSNumber numberWithInt:1]]);
    
    XCTAssertEqual(BLACK, [[tree root] color]);
}

-(void) testDeleteStructureOnRootWithLeftChildTree {
    [tree addObject:[NSNumber numberWithInt:2]];
    [tree addObject:[NSNumber numberWithInt:1]];
    
    XCTAssertNoThrow([tree removeObject:[NSNumber numberWithInt:1]]);
    
    XCTAssertTrue([[tree root] right] == nil);
    XCTAssertTrue([[tree root] left] == nil);
}

-(void) testDeleteColoringOnRootWithRightChildTree {
    [tree addObject:[NSNumber numberWithInt:2]];
    [tree addObject:[NSNumber numberWithInt:3]];
    
    XCTAssertNoThrow([tree removeObject:[NSNumber numberWithInt:3]]);
    
    XCTAssertEqual(BLACK, [[tree root] color]);
}

-(void) testDeleteStructureOnRootWithRightChildTree {
    [tree addObject:[NSNumber numberWithInt:2]];
    [tree addObject:[NSNumber numberWithInt:3]];
    
    XCTAssertNoThrow([tree removeObject:[NSNumber numberWithInt:3]]);
    
    XCTAssertTrue([[tree root] right] == nil);
    XCTAssertTrue([[tree root] left] == nil);
}

-(void) testStructureRemoveRootOnRootRightChildTree {
    [tree addObject:[NSNumber numberWithInt:2]];
    [tree addObject:[NSNumber numberWithInt:3]];
    
    XCTAssertNoThrow([tree removeObject:[NSNumber numberWithInt:2]]);
    
    XCTAssertTrue([[tree root] right] == nil);
    XCTAssertTrue([[tree root] left] == nil);
}

-(void) testColoringRemoveRootOnRootRightChildTree {
    [tree addObject:[NSNumber numberWithInt:2]];
    [tree addObject:[NSNumber numberWithInt:3]];
    
    XCTAssertNoThrow([tree removeObject:[NSNumber numberWithInt:2]]);
    
    XCTAssertEqual(BLACK, [[tree root] color]);
}

@end
