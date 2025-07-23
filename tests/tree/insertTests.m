//
//  Created by Mateusz Stompór on 30/05/2017.
//  Copyright © 2017 Mateusz Stompór. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <redblacktree/redblacktree.h>

@interface RBTree (Tests)

-(RBNode<id> *) root;

@end

@interface InsertTests : XCTestCase
{
    RBTree<NSNumber*>* tree;
}
@end

@implementation InsertTests

- (void) setUp {
    tree = [[RBTree alloc] init];
}

- (void) tearDown {
    [super tearDown];
}

- (void) testInsertionToEmptyTree {
    [tree addObject: [NSNumber numberWithInt:3]];
    
    XCTAssertNotNil([tree root]);
    XCTAssertEqual([[tree root] color], RB_BLACK);
    XCTAssertNil([[tree root] parent]);
    XCTAssertNil([[tree root] left]);
    XCTAssertNil([[tree root] right]);
}

- (void) testInsertionOnParentAndRightChild {
    [tree addObject: [NSNumber numberWithInt:3]];
    [tree addObject: [NSNumber numberWithInt:4]];
    
    XCTAssertEqual([[tree root] color], RB_BLACK);
    XCTAssertEqual([[[tree root] right] color], RB_RED);
    XCTAssertEqual([[[tree root] right] parent], [tree root]);
}

- (void) testInsertionOnParentAndLeftChild {
    [tree addObject: [NSNumber numberWithInt:3]];
    [tree addObject: [NSNumber numberWithInt:2]];
    
    XCTAssertEqual([[tree root] color], RB_BLACK);
    XCTAssertEqual([[[tree root] left] color], RB_RED);
    XCTAssertEqual([[[tree root] left] parent], [tree root]);
}

- (void) testInsertionZakZakRotation {
    [tree addObject: [NSNumber numberWithInt:3]];
    [tree addObject: [NSNumber numberWithInt:4]];
    [tree addObject: [NSNumber numberWithInt:5]];
    
    XCTAssertEqual([[tree root] color], RB_BLACK);
    XCTAssertEqual([[[tree root] right] color], RB_RED);
    XCTAssertEqual([[[tree root] left] color], RB_RED);
}

- (void) testInsertionZigZigRotation {
    [tree addObject: [NSNumber numberWithInt:5]];
    [tree addObject: [NSNumber numberWithInt:4]];
    [tree addObject: [NSNumber numberWithInt:3]];
    
    XCTAssertEqual([[tree root] color], RB_BLACK);
    XCTAssertEqual([[[tree root] right] color], RB_RED);
    XCTAssertEqual([[[tree root] left] color], RB_RED);
}

- (void) testInsertionOnValuesAfterZigZigRotation {
    [tree addObject: [NSNumber numberWithInt:5]];
    [tree addObject: [NSNumber numberWithInt:4]];
    [tree addObject: [NSNumber numberWithInt:3]];
    
    XCTAssertEqual(4, [[[tree root] data] intValue]);
    XCTAssertEqual(3, [[[[tree root] left] data] intValue]);
    XCTAssertEqual(5, [[[[tree root] right] data] intValue]);
}

- (void) testInsertionOnValuesAfterZakZigRotation {
    [tree addObject: [NSNumber numberWithInt:3]];
    [tree addObject: [NSNumber numberWithInt:1]];
    [tree addObject: [NSNumber numberWithInt:2]];
    
    XCTAssertEqual([[[tree root] data] intValue], 2);
    XCTAssertEqual([[[[tree root] left] data] intValue], 1);
    XCTAssertEqual([[[[tree root] right] data] intValue], 3);
}

- (void) testInsertionOnValuesAfterZigZakRotation {
    [tree addObject: [NSNumber numberWithInt:1]];
    [tree addObject: [NSNumber numberWithInt:3]];
    [tree addObject: [NSNumber numberWithInt:2]];
    
    XCTAssertEqual([[[tree root] data] intValue], 2);
    XCTAssertEqual([[[[tree root] left] data] intValue], 1);
    XCTAssertEqual([[[[tree root] right] data] intValue], 3);
}

- (void) testInsertionOnColorsAfterZigZakRotation {
    [tree addObject: [NSNumber numberWithInt:1]];
    [tree addObject: [NSNumber numberWithInt:3]];
    [tree addObject: [NSNumber numberWithInt:2]];
    
    XCTAssertEqual([[tree root] color], RB_BLACK);
    XCTAssertEqual([[[tree root] left] color], RB_RED);
    XCTAssertEqual([[[tree root] right] color], RB_RED);
}

- (void) testInsertionOnStructureAfterZigZakRotation {
    [tree addObject: [NSNumber numberWithInt:1]];
    [tree addObject: [NSNumber numberWithInt:3]];
    [tree addObject: [NSNumber numberWithInt:2]];
    
    XCTAssertNil([[[tree root] left] left]);
    XCTAssertNil([[[tree root] left] right]);
    
    XCTAssertNil([[[tree root] right] left]);
    XCTAssertNil([[[tree root] right] right]);
    
    XCTAssertEqual([tree root], [[[tree root] right] parent]);
    XCTAssertEqual([tree root], [[[tree root] left] parent]);
}

- (void) testInsertionValuesOnFourNodesTree {
    [tree addObject: [NSNumber numberWithInt:1]];
    [tree addObject: [NSNumber numberWithInt:2]];
    [tree addObject: [NSNumber numberWithInt:3]];
    [tree addObject: [NSNumber numberWithInt:4]];
    
    XCTAssertEqual(1, [[[[tree root] left] data] intValue]);
    XCTAssertEqual(2, [[[tree root] data] intValue]);
    XCTAssertEqual(3, [[[[tree root] right] data] intValue]);
    XCTAssertEqual(4, [[[[[tree root] right] right] data] intValue]);
}

- (void) testInsertionColorsOnFourNodesTree {
    [tree addObject: [NSNumber numberWithInt:1]];
    [tree addObject: [NSNumber numberWithInt:2]];
    [tree addObject: [NSNumber numberWithInt:3]];
    [tree addObject: [NSNumber numberWithInt:4]];
    
    XCTAssertEqual(RB_BLACK, [[[tree root] left] color]);
    XCTAssertEqual(RB_BLACK, [[[tree root] right] color]);
    XCTAssertEqual(RB_BLACK, [[tree root] color]);
    XCTAssertEqual(RB_RED, [[[[tree root] right] right] color]);
}

@end
