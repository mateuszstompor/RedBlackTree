//
//  Created by Mateusz Stompór on 29/03/2017.
//  Copyright © 2017 Mateusz Stompór. All rights reserved.
//

#pragma once

#import <Foundation/Foundation.h>

/**
 * @class RBTree
 * @brief Generic Red-Black Tree implementation for storing unique objects with efficient insertion, removal, and search operations.
 *
 * A self-balancing binary search tree with O(log n) insert, remove, and lookup. Objects must be comparable and implement `isEqual:` and `hash`.
 *
 * Usage Example:
 *   RBTree<NSNumber *> *tree = [[RBTree alloc] init];
 *   [tree addObject:@3];
 *   BOOL contains = [tree containsObject:@3];
 */
@interface RBTree<T> : NSObject
/**
 * @brief The number of objects currently in the tree.
 */
@property (nonatomic, readonly) NSUInteger count;

/**
 * @brief Initializes an empty RBTree.
 * @return A new instance of RBTree.
 */
- (instancetype _Nullable)init;

/**
 * @brief Adds an object to the tree.
 * @param object The object to insert. Must not be nil.
 */
- (void)addObject:(T _Nonnull)object;

/**
 * @brief Checks if the tree contains the specified object.
 * @param object The object to search for.
 * @return YES if the object is present, NO otherwise.
 */
- (BOOL)containsObject:(T _Nonnull)object;

/**
 * @brief Removes the specified object from the tree.
 * @param object The object to remove.
 */
- (void)removeObject:(T _Nonnull)object;

/**
 * @brief Retrieves the stored object that matches the given object (based on equality).
 * @param object The object to match.
 * @return The stored object if found, or nil if not present.
 */
- (T _Nullable)objectForKey:(T _Nonnull)object;

@end

