## Red Black Tree &middot; [![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT) 

<p align="center">
  <img src="https://image.ibb.co/n0LNG5/rbt.png">
</p>

### Features
<ul>
    <li>Objective-C 2.0 (with ARC)</li>
    <li>Unit-Tests</li>
    <li>Coverage 80+</li>
</ul>

### About
This is a macOS framework that implements a generic red-black tree, modeled after Foundation containers. Designed for flexibility and extensibility, it serves as a foundational, key-only data structure. You can subclass the main tree to create higher-level containers such as dictionaries, by defining specialized types that associate keys with values. The interface is familiar to developers who have used Foundation containers, and the framework is thoroughly tested for reliability.

### Usage Example
```objective-c
// Create a RedBlackTree instance
RedBlackTree<NSNumber *> *tree = [[RedBlackTree alloc] init];

// Add objects
[tree addObject:@42];
[tree addObject:@17];
[tree addObject:@99];

// Check if an object exists
BOOL contains42 = [tree containsObject:@42]; // YES

// Retrieve an object (if it exists)
NSNumber *value = [tree objectForKey:@17];

// Remove an object
[tree removeObject:@99];

// Check current count
NSUInteger count = tree.count;
