//
//  RedBlackNode.h
//  RED_BLACK_TREE
//
//  Created by Mateusz Stompór on 29/03/2017.
//  Copyright © 2017 Mateusz Stompór. All rights reserved.


#import <Foundation/Foundation.h>
#import "NodeColor.h"

#pragma once

@interface RedBlackNode<T> : NSObject

@property (nonatomic, nullable,strong)  RedBlackNode <T> *      parent;
@property (nonatomic, nullable,strong)  RedBlackNode <T> *      left;
@property (nonatomic, nullable,strong)  RedBlackNode <T> *      right;
@property (nonatomic)                   NodeColor               color;
@property (nonatomic, nonnull, strong)  T                       data;

- (instancetype _Nonnull)   initWithParent: (RedBlackNode <T> * _Nullable) parent andValue: (T _Nonnull) value;
- (void)                    swapColor;
- (BOOL)                    isRight;
- (BOOL)                    isLeft;

@end
