//
//  Created by Mateusz Stompór on 29/03/2017.
//  Copyright © 2017 Mateusz Stompór. All rights reserved.
//

#import "RBNode.h"

@implementation RBNode : NSObject

@synthesize color       = color;
@synthesize data        = data;
@synthesize left        = left;
@synthesize right       = right;
@synthesize parent      = parent;

- (instancetype _Nonnull)initWithParent: (RBNode<id> * _Nullable) parent andValue: (id _Nonnull) value {
    self = [self initWithParent:parent andValue:value color:RB_RED];
    return self;
}

- (instancetype _Nonnull)initWithParent: (RBNode<id> * _Nullable) parent andValue: (id _Nonnull) value color: (RBColor) color {
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

- (void)swapColor {
    color = color == RB_RED ? RB_BLACK : RB_RED;
}

- (BOOL)isRightChild {
    return parent && parent.right == self;
}

- (BOOL)isLeftChild {
    return parent && parent.left == self;
}

- (RBNode<id> *)getRedChild {
    if (left && left.color == RB_RED){
        return left;
    } else if (right && right.color == RB_RED) {
        return right;
    } else {
        return nil;
    }
}

- (int)childrenCount {
    if (left && right) {
        return 2;
    } else if (left || right) {
        return 1;
    } else {
        return 0;
    }
}

- (BOOL)bothChildrenConsideredAsBlack {
    return !left || left.color == RB_BLACK || !right || right.color == RB_BLACK;
}

- (RBNode<id> *)getBlackChild {
    if (left && left.color == RB_BLACK) {
        return left;
    } else if (right && right.color == RB_BLACK) {
        return right;
    } else {
        return nil;
    }
}

@end
