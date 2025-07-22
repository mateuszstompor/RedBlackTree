//
//  Created by Mateusz Stompór on 30/09/2018.
//  Copyright © 2018 Mateusz Stompór. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <redblacktree/redblacktree.h>

@interface ContainsTests : XCTestCase
{
    RBTree<NSNumber*>* tree;
}
@end

@implementation ContainsTests

- (void)setUp {
    tree = [[RBTree alloc] init];
}

- (void)testContainsOnEmptyTree {
    XCTAssertTrue(![tree containsObject:[NSNumber numberWithInt:2]]);
}

- (void)testContainsOnOneElementTree {
    [tree addObject:[NSNumber numberWithInt:2]];
    XCTAssertTrue([tree containsObject:[NSNumber numberWithInt:2]]);
}

@end

