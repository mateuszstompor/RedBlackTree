# Red Black Tree
###### Tests status
[![Build Status](https://www.travis-ci.org/mateuszstompor/RedBlackTree.svg?branch=master)](https://www.travis-ci.org/mateuszstompor/RedBlackTree)
<p align="center">
  <img src="https://image.ibb.co/n0LNG5/rbt.png">
</p>

## Features
<ul>
    <li>Objective-C 2.0 (with ARC)</li>
    <li>Unit-Tests</li>
</ul>

## About
macOS framework made in a way similar to all foundation containers. It is generic data structure, has interface similar to all other foundation containers and is tested.

## Interface
```objective-c
@interface RedBlackTree<T> : NSObject

@property (nonatomic, readonly) NSUInteger count;

- (instancetype)          init;
- (void)                  addObject: (id) object;

@end
```


## Example usage

```objective-c

#import <RedBlackTree/RedBlackTree.h>

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // initialize
        RedBlackTree<NSNumber*>* tree;
        tree = [[RedBlackTree alloc] init];

        // add an element
        [tree addObject: [NSNumber numberWithInt:3]];

        // count elements
        [tree count];

        // check if it contains an object
        [tree containsObject: [NSNumber numberWithInt:3]];
    }
    return 0;
}

```
