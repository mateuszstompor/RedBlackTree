//
//  Created by Mateusz Stompór on 30/09/2018.
//  Copyright © 2018 Mateusz Stompór. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <redblacktree/redblacktree.h>

@interface RBTree (Tests)

@property (nonatomic) NSUInteger count;

-(RBNode<id> *) root;
-(void) setRoot: (RBNode<id> *) root;

@end

@interface DeleteCaseFourTests : XCTestCase
{
    RBTree<NSNumber*>* tree;
}
@end

@implementation DeleteCaseFourTests

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wundeclared-selector"
- (void) setUp {
    tree = [[RBTree alloc] init];
    id node = [[RBNode alloc] initWithParent:nil andValue: [NSNumber numberWithInt: 10] color: RB_BLACK];
    [node setLeft:[[RBNode alloc] initWithParent:node andValue: [NSNumber numberWithInt: -10] color: RB_BLACK]];
    [node setRight:[[RBNode alloc] initWithParent:node andValue: [NSNumber numberWithInt: 30] color: RB_RED]];
    [[node right] setRight:[[RBNode alloc] initWithParent:[node right] andValue: [NSNumber numberWithInt: 38] color: RB_BLACK]];
    [[node right] setLeft:[[RBNode alloc] initWithParent:[node right] andValue: [NSNumber numberWithInt: 20] color: RB_BLACK]];
    [tree setRoot: node];
    [(NSObject *)tree performSelector:@selector(updateCount:) withObject:@5];

}
#pragma clang diagnostic pop

- (void) testIfAfterDeletionColorseOfNodesAreValid {
    XCTAssertNoThrow([tree removeObject: [NSNumber numberWithInt: 20]]);

    XCTAssertEqual(RB_BLACK, [[tree root] color]);
    XCTAssertEqual(RB_BLACK, [[[tree root] left] color]);
    XCTAssertEqual(RB_BLACK, [[[tree root] right] color]);
    XCTAssertEqual(RB_RED, [[[[tree root] right] right] color]);
}

- (void) testIfAfterDeletionValuesOfNodesAreValid {
    XCTAssertNoThrow([tree removeObject: [NSNumber numberWithInt: 20]]);
    
    XCTAssertEqual(10, [[[tree root] data] intValue]);
    XCTAssertEqual(-10, [[[[tree root] left] data] intValue]);
    XCTAssertEqual(30, [[[[tree root] right] data] intValue]);
    XCTAssertEqual(38, [[[[[tree root] right] right] data] intValue]);
}

- (void) testCountAfterDeletion {
    XCTAssertEqual(5, [tree count]);
    
    XCTAssertNoThrow([tree removeObject: [NSNumber numberWithInt: 20]]);

    XCTAssertEqual(4, [tree count]);
}

- (void) testIfAfterStructureOfNodesIsValid {
    XCTAssertNoThrow([tree removeObject: [NSNumber numberWithInt: 20]]);
    
    XCTAssertNil([[tree root] parent]);
    XCTAssertEqual([tree root], [[[tree root] left] parent]);
    XCTAssertEqual([tree root], [[[tree root] right] parent]);
    XCTAssertNil([[[tree root] left] left]);
    XCTAssertNil([[[tree root] left] right]);
    
    XCTAssertNil([[[tree root] right] left]);
    XCTAssertEqual([[tree root] right], [[[[tree root] right] right] parent]);
    XCTAssertNil([[[[tree root] right] right] right]);
    XCTAssertNil([[[[tree root] right] right] left]);
}

@end
