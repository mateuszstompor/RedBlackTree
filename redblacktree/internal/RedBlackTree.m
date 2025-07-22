//
//  Created by Mateusz Stompór on 29/03/2017.
//  Copyright © 2017 Mateusz Stompór. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <assert.h>

#import "RedBlackTree.h"
#import "RedBlackNode.h"

@interface RedBlackTree ()

@property (nonatomic) RedBlackNode<id> * root;
@property (nonatomic) NSUInteger count;

@end

@implementation RedBlackTree

@synthesize count;
@synthesize root;

-(instancetype _Nullable) init {
    self = [super init];
    return self;
}

-(int) countBlackNodesIn: (RedBlackNode<id>* _Nullable) currentPoint {
    if (!currentPoint) {
        return 1;
    } else {
        int leftSubTree = [self countBlackNodesIn: currentPoint.left];
        int rightSubTree = [self countBlackNodesIn: currentPoint.right];
        int total = leftSubTree + rightSubTree;
        return currentPoint.color == BLACK ? total + 1 : total;
    }
}

-(void) rotateLeft: (RedBlackNode<id>* _Nonnull) pivotNode {
    if(pivotNode && pivotNode.right){
        RedBlackNode<id>* newPivot = pivotNode.right;
        newPivot.parent = pivotNode.parent;
        if(pivotNode.parent){
            if([pivotNode isRight]){
                pivotNode.parent.right = newPivot;
            } else {
                pivotNode.parent.left = newPivot;
            }
        } else{
            root = newPivot;
        }
        if (newPivot.left){
            pivotNode.right = newPivot.left;
            newPivot.left.parent = pivotNode;
        } else {
            pivotNode.right = nil;
        }
        newPivot.left = pivotNode;
        pivotNode.parent = newPivot;
    }
}

-(void) rotateRight: (RedBlackNode<id>* _Nonnull) pivotNode {
    if(pivotNode && pivotNode.left){
        RedBlackNode<id>* newPivot = pivotNode.left;
        newPivot.parent = pivotNode.parent;
        if(pivotNode.parent) {
            if ([pivotNode isLeft]) {
                pivotNode.parent.left = newPivot;
            } else {
                pivotNode.parent.right = newPivot;
            }
        } else {
            root = newPivot;
        }
        if (newPivot.right){
            pivotNode.left = newPivot.right;
            newPivot.right.parent = pivotNode;
        } else {
            pivotNode.left = nil;
        }
        newPivot.right = pivotNode;
        pivotNode.parent=newPivot;
    }
}

-(RedBlackNode<id>* _Nullable) findAppropriatePlaceForNewValue:(id) value {
    if(root == nil){
        return nil;
    }
    else{
        RedBlackNode<id>* currentNode = self->root;
        while(([value isGreaterThan: currentNode.data] && currentNode.right!=nil)||
              ([currentNode.data isGreaterThan: value] && currentNode.left!=nil)) {
            if([value isGreaterThan: currentNode.data]){
                currentNode=currentNode.right;
            }
            else{
                currentNode=currentNode.left;
            }
        }
        return currentNode;
    }
}

-(void) createLinkFrom: (RedBlackNode<id>*) child to: (RedBlackNode<id>*) parent {
    if (!parent) {
        self->root=child;
    }else{
        if ([child.data isGreaterThan:parent.data]){
            parent.right=child;
        } else {
            parent.left=child;
        }
        [child setParent:parent];
    }
}

-(RedBlackNode<id>* _Nullable) getSiblingNode: (RedBlackNode<id>* _Nullable) node {
    if(node) {
        if ([node isRight]) {
            return node.parent.left;
        } else if ([node isLeft]) {
            return node.parent.right;
        }
    }
    return nil;
}

-(RedBlackNode<id>* _Nullable)colorUntilRBTPropertiesArePreserved: (RedBlackNode<id>* _Nullable) initialNode {
    if (initialNode) {
        RedBlackNode<id>* uncle = [self getSiblingNode:initialNode.parent];
        RedBlackNode<id>* currentNode=initialNode.parent;
        while([self requiresColoring: initialNode]) {
            [currentNode swapColor];
            [uncle swapColor];
            [currentNode.parent swapColor];
            initialNode = uncle.parent;
            if (initialNode) {
                currentNode = initialNode.parent;
            } else {
                currentNode = nil;
            }
            uncle = [self getSiblingNode:currentNode];
        }
        return initialNode;
    } else {
        return nil;
    }
}

-(bool)requiresColoring: (RedBlackNode<id>*) currentNode {
    if(currentNode && currentNode.color == RED && currentNode.parent && currentNode.parent.color == RED){
        RedBlackNode<id>* uncle = [self getSiblingNode:currentNode.parent];
        return uncle != nil && uncle.color == RED;
    } else {
        return false;
    }
}

-(bool)requiresRotation: (RedBlackNode<id>*) currentNode {
    if(currentNode != nil && currentNode.color==RED && currentNode.parent != nil && currentNode.parent.color == RED) {
        RedBlackNode<id>* uncle = [self getSiblingNode:currentNode.parent];
        return !uncle || uncle.color == BLACK;
    }
    return false;
}

-(void) changeColorAfterLeftRotation: (RedBlackNode<id>*) pivot {
    if(pivot!=nil){
        [pivot swapColor];
    }
    if(pivot.left!=nil){
        [pivot.left swapColor];
    }
}

-(void) changeColorAfterRightRotation: (RedBlackNode<id>*) pivot {
    if(pivot!=nil){
        [pivot swapColor];
    }
    if(pivot.right!=nil){
        [pivot.right swapColor];
    }
}

- (id) objectForKey: (id) anObject {
    RedBlackNode<id>* node = [self searchFor:anObject from: root];
    if (node) {
        return [node data];
    }
    return nil;
}

-(RedBlackNode<id>* _Nullable) getMinNodeFromSubtree: (RedBlackNode<id>* _Nullable) node {
    if(node!=nil){
        RedBlackNode<id>* currentMin = node;
        node=node.left;
        while(node!=nil){
            if([currentMin.data isGreaterThan: node.data]){
                currentMin=node;
            }
            node=node.left;
        }
        return currentMin;
    }
    return nil;
}

- (BOOL) containsObject: (id _Nonnull) anObject {
    return [self searchFor: anObject] != nil;
}

-(RedBlackNode<id>* _Nullable) searchFor: (id _Nonnull) value {
    return [self searchFor:value from:self->root];
}

-(RedBlackNode<id>* _Nullable) searchFor: (id _Nonnull) value from: (RedBlackNode<id>* _Nonnull) initialNode {
    while(initialNode) {
        if([value isEqual:[initialNode data]]){
            return initialNode;
        } else if([value isGreaterThan: initialNode.data]){
            initialNode=initialNode.right;
        } else {
            initialNode=initialNode.left;
        }
    }
    return nil;
}

-(RedBlackNode<id>* _Nullable) binaryDelete: (id _Nonnull) value OptionalPointerToNode: (RedBlackNode<id>* _Nullable) node {
    if((node == nil && ((node=[self searchFor:value]) == nil))||([[node data] isEqual:value]==false)){
        [NSException raise:@"There is no such value" format:@"Value was %@", value];
    }
    int amountOfChildren = [node childrenAmount];
    RedBlackNode <id>* nodeToConnectWithParent = nil;
    if (amountOfChildren == 1) {
        if([node left]){
            nodeToConnectWithParent=node.left;
        } else {
            nodeToConnectWithParent=node.right;
        }
    }
    else if (amountOfChildren == 2) {
        RedBlackNode <id>* minimum = [self getMinNodeFromSubtree:node.right];
        [self binaryDelete:[minimum data] OptionalPointerToNode:minimum];
        nodeToConnectWithParent=minimum;
        minimum.left=node.left;
        minimum.right=node.right;
        node.left.parent=minimum;
        node.right.parent=minimum;
    }
    if([node isRight]){
        node.parent.right=nodeToConnectWithParent;
        
    } else if([node isLeft]){
        node.parent.left = nodeToConnectWithParent;
    }
    if(nodeToConnectWithParent!=nil){
        nodeToConnectWithParent.parent = node.parent;
    }
    if(node == root){
        root = nodeToConnectWithParent;
    }
    return nodeToConnectWithParent.parent;
}

- (void) removeObject: (id) anObject {
    if([self deleteValue: anObject searchFrom: root]) {
        --count;
    }
}

-(BOOL) deleteValue: (id _Nonnull) value searchFrom: (RedBlackNode<id>*) initialNode {
    RedBlackNode<id>* nodeToDelete = [self searchFor:value from:initialNode];
    if (nodeToDelete && [value isEqual: [nodeToDelete data]]){
        int amountOfKids = [nodeToDelete childrenAmount];
        if(amountOfKids == 2) {
            RedBlackNode<id>* minimalNode = [self getMinNodeFromSubtree:nodeToDelete.right];
            [nodeToDelete setData:[minimalNode data]];
            [self deleteValue:[minimalNode data] searchFrom:minimalNode];
        } else {
            if(amountOfKids < 2 && nodeToDelete.color == RED) {
                [self binaryDelete:value OptionalPointerToNode:nodeToDelete];
            } else if(nodeToDelete.color == BLACK && amountOfKids == 1){
                if(([nodeToDelete left] && nodeToDelete.left.color == RED)
                   ||([nodeToDelete right] && nodeToDelete.right.color == RED)) {
                    if([nodeToDelete right]) {
                        [nodeToDelete.right swapColor];
                    } else{
                        [nodeToDelete.left swapColor];
                    }
                    [self binaryDelete:value OptionalPointerToNode:nodeToDelete];
                }
            } else {
                RedBlackNode<id>* parent = nodeToDelete.parent;
                [self binaryDelete:value OptionalPointerToNode:nodeToDelete];
                [self deleteCaseOne: parent];
            }
        }
    }
    return nodeToDelete != nil;
}

-(void) deleteCaseOne: (RedBlackNode<id>*) parentNode {
    if(parentNode==nil){
        if(root!=nil){
            int leftheight = [self countBlackNodesIn: root.left];
            int rightheight = [self countBlackNodesIn: root.right];
            if (leftheight == rightheight) {
                root.color=BLACK;
            }
        }
    } else {
        [self deleteCaseTwo:parentNode];
    }
}

-(bool) isBlack: (RedBlackNode<id>* _Nullable) node {
    return !node || node.color == BLACK;
}

-(void)deleteCaseTwo:(RedBlackNode<id>*) parentNode {
    RedBlackNode<id>* redChild = [parentNode getRedKid];
    if(redChild && [redChild bothKidsAreBlack]) {
        int leftheight = [self countBlackNodesIn:parentNode.left];
        int rightheight = [self countBlackNodesIn:parentNode.right];
        if(rightheight>leftheight) {
            [self rotateLeft:parentNode];
            [self changeColorAfterLeftRotation:parentNode.parent];
        } else {
            [self rotateRight:parentNode];
            [self changeColorAfterRightRotation:parentNode.parent];
        }
    }
    [self deleteCaseThree:parentNode];
}

-(void)deleteCaseThree: (RedBlackNode<id>*) parentNode {
    if(parentNode.color==BLACK){
        int leftheight = [self countBlackNodesIn:parentNode.left];
        int rightheight = [self countBlackNodesIn:parentNode.right];
        RedBlackNode<id>* nodeToExaminate = parentNode.left;
        if(rightheight>leftheight){
            nodeToExaminate=parentNode.right;
        }
        if(nodeToExaminate.color==BLACK && [nodeToExaminate bothKidsAreBlack]){
            [nodeToExaminate swapColor];
            parentNode=parentNode.parent;
            [self deleteCaseOne:parentNode];
            return;
        }
    }
    [self deleteCaseFour:parentNode];
}

-(void) deleteCaseFour: (RedBlackNode<id>*) parentNode {
    if(parentNode.color==RED){
        int leftheight = [self countBlackNodesIn:parentNode.left];
        int rightheight = [self countBlackNodesIn:parentNode.right];
        RedBlackNode<id>* nodeToExaminate = parentNode.left;
        if(rightheight>leftheight){
            nodeToExaminate=parentNode.right;
        }
        if([self isBlack:nodeToExaminate]&& nodeToExaminate!=nil && [nodeToExaminate bothKidsAreBlack]){
            [parentNode swapColor];
            [nodeToExaminate swapColor];
            if([parentNode childrenAmount] == 2){
                RedBlackNode<id>* sibling = [self getSiblingNode:nodeToExaminate];
                [sibling setColor:BLACK];
            }
            return;
        }
    }
    [self deleteCaseFive:parentNode];
}

-(void) deleteCaseFive: (RedBlackNode<id>*) parentNode {
    if(parentNode.color==BLACK){
        int leftheight = [self countBlackNodesIn:parentNode.left];
        int rightheight = [self countBlackNodesIn:parentNode.right];
        RedBlackNode<id>* nodeToExaminate = parentNode.left;
        if(rightheight>leftheight){
            nodeToExaminate=parentNode.right;
        }
        if(nodeToExaminate.color==BLACK && [nodeToExaminate getRedKid] != nil && ([nodeToExaminate getBlackChild] != nil)) {
            if(rightheight>leftheight && nodeToExaminate.left!=nil && nodeToExaminate.left.color==RED){
                [self rotateRight:nodeToExaminate];
                [self changeColorAfterRightRotation:nodeToExaminate.parent];
            }
            else if(leftheight>rightheight && nodeToExaminate.right && nodeToExaminate.right.color==RED){
                [self rotateLeft:nodeToExaminate];
                [self changeColorAfterLeftRotation:nodeToExaminate.parent];
            }
        }
    }
    [self deleteCaseSix:parentNode];
}

-(void) deleteCaseSix: (RedBlackNode<id>*) parentNode {
    int leftheight = [self countBlackNodesIn:parentNode.left];
    int rightheight = [self countBlackNodesIn:parentNode.right];
    RedBlackNode<id>* nodeToExaminate = parentNode.left;
    if(rightheight>leftheight){
        nodeToExaminate=parentNode.right;
    }
    if(rightheight>leftheight && nodeToExaminate.right.color==RED){
        [self rotateLeft:parentNode];
        [self changeColorAfterLeftRotation:parentNode.parent];
        return;
    } else if(leftheight>rightheight && nodeToExaminate.left==RED){
        [self rotateRight:parentNode];
        [self changeColorAfterRightRotation:parentNode.parent];
        return;
    }
    [self deleteCaseOne:parentNode];
}

-(void) addObject: (id _Nonnull) value {
    RedBlackNode<id>* childToInsert = [[RedBlackNode alloc] initWithParent:nil andValue:value];
    RedBlackNode<id>* parentNode = [self findAppropriatePlaceForNewValue:value];
    [self createLinkFrom:childToInsert to:parentNode];
    RedBlackNode<id>* currentNode = [self colorUntilRBTPropertiesArePreserved:childToInsert];
    if([self requiresRotation:currentNode]){
        if([currentNode isLeft] && [currentNode.parent isLeft]){
            [self rotateRight:currentNode.parent.parent];
            [self changeColorAfterRightRotation:currentNode.parent];
        }
        else if([currentNode isLeft] && [currentNode.parent isRight]){
            [self rotateRight:currentNode.parent];
            [self rotateLeft:currentNode.parent];
            [self changeColorAfterLeftRotation:currentNode];
        }
        else if([currentNode isRight] && [currentNode.parent isLeft]){
            [self rotateLeft:currentNode.parent];
            [self rotateRight:currentNode.parent];
            [self changeColorAfterRightRotation:currentNode];
        }
        else{
            [self rotateLeft:currentNode.parent.parent];
            [self changeColorAfterLeftRotation:currentNode.parent];
        }
    }
    ++count;
    [self->root setColor:BLACK];
}

@end
