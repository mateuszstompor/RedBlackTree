//
//  RedBlackNode.m
//  RED_BLACK_TREES
//
//  Created by Mateusz Stompór on 29/03/2017.
//  Copyright © 2017 Mateusz Stompór. All rights reserved.

#import "RedBlackNode.h"


@implementation RedBlackNode : NSObject

//@synthesize containedData=_data;
@synthesize parent=_parent;
@synthesize leftChild=_leftChild;
@synthesize rightChild=_rightChild;

-(instancetype _Nonnull)initWithParent: (RedBlackNode<id>* _Nullable) parent andValue: (id _Nonnull) value {
    self=[self init];
    self->containedData=value;
    self.color=RED;
    self.leftChild=nil;
    self.parent=nil;
    self.rightChild=nil;
    return self;
}

-(NodeColor) getColor{
    return self.color;
}

-(void) changeColor{
    self.color = self.color == RED ? BLACK : RED;
}

-(id _Nonnull) getData{
    return self->containedData;
}

-(void) setData:(id)data{
    self->containedData=data;
}

@end
