//
//  Created by Mateusz Stompór on 29/03/2017.
//  Copyright © 2017 Mateusz Stompór. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "RBColor.h"

#pragma once

@interface RBNode<T> : NSObject

@property (nonatomic, nullable,strong)  RBNode <T> *      parent;
@property (nonatomic, nullable,strong)  RBNode <T> *      left;
@property (nonatomic, nullable,strong)  RBNode <T> *      right;
@property (nonatomic)                   RBColor           color;
@property (nonatomic, nonnull, strong)  T                 data;

- (instancetype _Nonnull)       initWithParent: (RBNode<T> * _Nullable) parent
                                      andValue: (T _Nonnull) value
                                         color: (RBColor) color;
- (instancetype _Nonnull)       initWithParent: (RBNode <T> * _Nullable) parent
                                      andValue: (T _Nonnull) value;
- (RBNode<T>* _Nullable)  getRedKid;
- (RBNode<T>* _Nullable)  getBlackChild;
- (void)                        swapColor;
- (BOOL)                        isRight;
- (BOOL)                        isLeft;
- (BOOL)                        bothKidsAreBlack;
- (int)                         childrenAmount;

@end
