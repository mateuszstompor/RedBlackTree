//
//  RedBlackTree.h
//  RED_BLACK_TREES
//
//  Created by Mateusz Stompór on 29/03/2017.
//  Copyright © 2017 Mateusz Stompór. All rights reserved.

#ifndef RedBlackTree_h
#define RedBlackTree_h
@interface RedBlackTree<T> : NSObject

@property (nonatomic, nonnull, copy) int (^comparingFunction)(T _Nonnull, T _Nonnull);

- (instancetype _Nullable)init NS_UNAVAILABLE;
- (instancetype _Nullable)initWithComparingBlock: ( int (^ _Nonnull)(T _Nonnull a, T _Nonnull b)) block;
- (void) insert: (T _Nonnull) value;
- (bool) contains: (T _Nonnull) value;
- (void) inOrderCallingBlock: ( void (^ _Nonnull)(T _Nonnull)) block;
- (bool) isValid;
- (void) deleteValue: (T _Nonnull) value;
- (NSString* _Nonnull) stringFromInOrder;
- (unsigned int) countAllNodes;

@end

#endif /* RedBlackTree_h */
