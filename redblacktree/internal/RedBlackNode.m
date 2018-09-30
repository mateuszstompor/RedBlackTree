//
//  RedBlackNode.m
//  RED_BLACK_TREE
//
//  Created by Mateusz Stompór on 29/03/2017.
//  Copyright © 2017 Mateusz Stompór. All rights reserved.

#import "RedBlackNode.h"

@implementation RedBlackNode : NSObject

@synthesize color       = color;
@synthesize data        = data;
@synthesize left   = left;
@synthesize right  = right;
@synthesize parent      = parent;

-(instancetype _Nonnull)initWithParent: (RedBlackNode<id> * _Nullable) parent andValue: (id _Nonnull) value {
    self = [self init];
    if(self) {
        data       = value;
        color      = RED;
        left  = nil;
        parent     = nil;
        right = nil;
    }
    return self;
}

-(void) swapColor {
    color = color == RED ? BLACK : RED;
}

@end
