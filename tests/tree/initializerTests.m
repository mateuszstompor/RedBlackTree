//
//  Created by Mateusz Stompór on 30/09/2018.
//  Copyright © 2018 Mateusz Stompór. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <redblacktree/redblacktree.h>

@interface InitializerTests : XCTestCase
{
    RBTree<NSNumber*>* tree;
}
@end

@implementation InitializerTests

- (void)testDefaultInitializer {
    tree = [[RBTree alloc] init];
    XCTAssertNotNil(tree);
}

@end
