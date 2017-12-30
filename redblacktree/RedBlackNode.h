//
//  RedBlackNode.h
//  RED_BLACK_TREES
//
//  Created by Mateusz Stompór on 29/03/2017.
//  Copyright © 2017 Mateusz Stompór. All rights reserved.


#import <Foundation/Foundation.h>
#import "RedBlackColor.h"

#ifndef RedBlackNode_h
#define RedBlackNode_h

@interface RedBlackNode<T> : NSObject

{
    T containedData;
}

@property (nonatomic, nullable,strong) RedBlackNode<T>* parent;
@property (nonatomic, nullable,strong) RedBlackNode<T>* leftChild;
@property (nonatomic, nullable,strong) RedBlackNode<T>* rightChild;
@property (nonatomic) NodeColor color;

- (instancetype _Nonnull)initWithParent: (RedBlackNode<T>* _Nullable) parent andValue: (T _Nonnull) value;
- (NodeColor) getColor;
- (void) changeColor;
- (T _Nonnull) getData;
- (void) setData: (T _Nonnull) data;

@end

#endif /* RedBlackNode_h */
