//
//  RedBlackTree.h
//  RED_BLACK_TREES
//
//  Created by Mateusz Stompór on 29/03/2017.
//  Copyright © 2017 Mateusz Stompór. All rights reserved.

#import "RedBlackNode.h"


#ifndef RedBlackTree_h
#define RedBlackTree_h
@interface RedBlackTree<T> : NSObject
{
    RedBlackNode<T>* rootNode;
}
-(instancetype _Nonnull)init;
-(instancetype _Nonnull)initWithValue: (T _Nonnull) value;
-(RedBlackNode<T>* _Nonnull) insert: (T _Nonnull) value;
-(bool)contains: (T _Nonnull) value;
-(void) printInOrder;
-(NSString* _Nonnull) inOrder: (RedBlackNode<T>* _Nullable) node;
-(bool) isValid;
-(void) deleteValue: (T _Nonnull) value;
-(RedBlackNode<T>* _Nullable) binaryDelete: (T _Nonnull) value OptionalPointerToNode: (RedBlackNode<T>* _Nullable) node;
-(RedBlackNode<T>* _Nullable) getRoot;
@end

#endif /* RedBlackTree_h */
