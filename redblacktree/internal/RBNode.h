//
//  Created by Mateusz Stompór on 29/03/2017.
//  Copyright © 2017 Mateusz Stompór. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "RBColor.h"

#pragma once

/**
 Represents a node in a Red-Black tree.
 
 This generic class holds the data of type T, the color of the node,
 and references to its parent and child nodes within the tree structure.
 */
@interface RBNode<T> : NSObject

/**
 Parent node in the tree (nullable).
 */
@property (nonatomic, nullable, strong)  RBNode <T> *      parent;

/**
 Left child node (nullable).
 */
@property (nonatomic, nullable, strong)  RBNode <T> *      left;

/**
 Right child node (nullable).
 */
@property (nonatomic, nullable, strong)  RBNode <T> *      right;

/**
 The color (red or black) of the node.
 */
@property (nonatomic)                    RBColor           color;

/**
 The value/data stored in the node (non-null).
 */
@property (nonatomic, nonnull, strong)   T                 data;

/**
 Initializes a node with a parent, value, and color.
 */
- (instancetype _Nonnull)       initWithParent: (RBNode<T> * _Nullable) parent
                                      andValue: (T _Nonnull) value
                                         color: (RBColor) color;

/**
 Initializes a node with a parent and value, defaulting color to red.
 */
- (instancetype _Nonnull)       initWithParent: (RBNode <T> * _Nullable) parent
                                      andValue: (T _Nonnull) value;

/**
 Returns the red-colored child node, if present.
 */
- (RBNode<T>* _Nullable)  getRedChild;

/**
 Returns the black-colored child node, if present.
 */
- (RBNode<T>* _Nullable)  getBlackChild;

/**
 Toggles the node color between red and black.
 */
- (void)                        swapColor;

/**
 Returns YES if the node is the right child of its parent.
 */
- (BOOL)                        isRightChild;

/**
 Returns YES if the node is the left child of its parent.
 */
- (BOOL)                        isLeftChild;

/**
 Returns YES if both children are nil or black.
 */
- (BOOL)                        bothChildrenConsideredAsBlack;

/**
 Returns the number of non-nil children (0, 1, or 2).
 */
- (int)                         childrenCount;

@end

