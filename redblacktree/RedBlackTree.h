//
//  Created by Mateusz Stompór on 29/03/2017.
//  Copyright © 2017 Mateusz Stompór. All rights reserved.
//

#pragma once

@interface RedBlackTree<T> : NSObject
{
    NSUInteger count;
}

@property (nonatomic, readonly) NSUInteger count;

- (instancetype _Nullable)          init;
- (void)                            addObject: (T _Nonnull) anObject;
- (BOOL)                            containsObject: (T _Nonnull) anObject;
- (void)                            removeObject: (T _Nonnull) anObject;
- (T _Nullable)                     objectForKey: (T _Nonnull) anObject;

@end
