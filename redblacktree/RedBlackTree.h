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
@property (nonatomic, copy) int (^ _Nonnull comparingFunction)(T _Nonnull, T _Nonnull);

-(instancetype _Nullable)init NS_UNAVAILABLE;
-(instancetype _Nullable)initWithComparingBlock: ( int (^ _Nonnull)(T _Nonnull a, T _Nonnull b)) block;
-(void) insert: (T _Nonnull) value;
-(bool) contains: (T _Nonnull) value;
-(void) inOrderCallingBlock: ( void (^ _Nonnull)(T _Nonnull)) block;
-(bool) isValid;
-(void) deleteValue: (T _Nonnull) value;
-(RedBlackNode<T>* _Nullable) binaryDelete: (T _Nonnull) value OptionalPointerToNode: (RedBlackNode<T>* _Nullable) node;
-(RedBlackNode<T>* _Nullable) getRoot;
-(NSString* _Nonnull) stringFromInOrder;
-(unsigned int) countAllNodes;
@end

#endif /* RedBlackTree_h */
