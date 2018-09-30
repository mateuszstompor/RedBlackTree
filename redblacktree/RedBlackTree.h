//
//  RedBlackTree.h
//  RED_BLACK_TREES
//
//  Created by Mateusz Stompór on 29/03/2017.
//  Copyright © 2017 Mateusz Stompór. All rights reserved.

#pragma once

@interface RedBlackTree<T> : NSObject

@property (readonly) NSUInteger count;

- (instancetype _Nullable)          init;
- (void)                            add: (T _Nonnull) object;

@end
