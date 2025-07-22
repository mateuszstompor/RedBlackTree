//
//  Created by Mateusz Stompór on 29/03/2017.
//  Copyright © 2017 Mateusz Stompór. All rights reserved.
//

#import "RedBlackNode.h"

@implementation RedBlackNode : NSObject

@synthesize color       = color;
@synthesize data        = data;
@synthesize left        = left;
@synthesize right       = right;
@synthesize parent      = parent;

- (instancetype _Nonnull)initWithParent: (RedBlackNode<id> * _Nullable) parent andValue: (id _Nonnull) value {
    self = [self initWithParent: parent andValue: value color: RED];
    return self;
}

- (instancetype _Nonnull)initWithParent: (RedBlackNode<id> * _Nullable) parent andValue: (id _Nonnull) value color: (NodeColor) color {
    self = [self init];
    if(self) {
        self.data    = value;
        self.color   = color;
        self.left    = nil;
        self.parent  = parent;
        self.right   = nil;
    }
    return self;
}

- (void) swapColor {
    color = color == RED ? BLACK : RED;
}

- (BOOL) isRight {
    return parent && parent.right == self;
}

- (BOOL) isLeft {
    return parent && parent.left == self;
}

- (RedBlackNode<id>*) getRedKid {
    if (self.left && self.left.color == RED){
        return self.left;
    } else if (self.right && self.right.color == RED) {
        return self.right;
    } else {
        return nil;
    }
}

- (int) childrenAmount {
    if (self.left && self.right) {
        return 2;
    } else if (self.left || self.right) {
        return 1;
    } else {
        return 0;
    }
}

- (BOOL) bothKidsAreBlack {
    return !self.left || self.left.color == BLACK || !self.right || self.right.color == BLACK;
}

- (RedBlackNode<id>*) getBlackChild {
    if (self.left && self.left.color == BLACK) {
        return self.left;
    } else if (self.right && self.right.color == BLACK) {
        return self.right;
    } else {
        return nil;
    }
}

@end
