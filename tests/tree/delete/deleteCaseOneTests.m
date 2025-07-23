//
//  Created by Mateusz Stompór on 30/09/2018.
//  Copyright © 2018 Mateusz Stompór. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <redblacktree/redblacktree.h>

@interface RBTree (Tests)

-(RBNode<id> *) root;

@end

@interface DeleteCaseOneTests : XCTestCase
{
    RBTree<NSNumber*>* tree;
}
@end

@implementation DeleteCaseOneTests

- (void) setUp {
    tree = [[RBTree alloc] init];
}

- (void) testDeleteOnEmptyTree {
    XCTAssertNoThrow([tree removeObject:[NSNumber numberWithInt:2]]);
}

-(void) testDeleteOnRootOnlyTree {
    [tree addObject:[NSNumber numberWithInt:2]];
    
    XCTAssertNoThrow([tree removeObject:[NSNumber numberWithInt:2]]);
    XCTAssertTrue(![tree containsObject:[NSNumber numberWithInt:2]]);
}

-(void) testDeleteColoringOnRootWithLeftChildTree {
    [tree addObject:[NSNumber numberWithInt:2]];
    [tree addObject:[NSNumber numberWithInt:1]];
    
    XCTAssertNoThrow([tree removeObject:[NSNumber numberWithInt:1]]);
    
    XCTAssertEqual(RB_BLACK, [[tree root] color]);
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
    
    XCTAssertEqual(RB_BLACK, [[tree root] color]);
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
    
    XCTAssertEqual(RB_BLACK, [[tree root] color]);
}

@end
