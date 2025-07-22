//
//  Created by Mateusz Stompór on 29/03/2017.
//  Copyright © 2017 Mateusz Stompór. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <assert.h>

#import "RedBlackTree.h"
#import "RBNode.h"

@interface RBTree ()

@property (nonatomic) RBNode<id> * root;
@property (nonatomic) NSUInteger count;

@end

@implementation RBTree

@synthesize count;
@synthesize root;

-(instancetype _Nullable) init {
    self = [super init];
    return self;
}

-(int) countBlackNodesIn: (RBNode<id>* _Nullable) currentPoint {
    if (!currentPoint) {
        return 1;
    } else {
        int leftSubTree = [self countBlackNodesIn: currentPoint.left];
        int rightSubTree = [self countBlackNodesIn: currentPoint.right];
        int total = leftSubTree + rightSubTree;
        return currentPoint.color == BLACK ? total + 1 : total;
    }
}

-(void) rotateLeft: (RBNode<id>* _Nonnull) pivotNode {
    if(pivotNode && pivotNode.right){
        RBNode<id>* newPivot = pivotNode.right;
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

-(void) rotateRight: (RBNode<id>* _Nonnull) pivotNode {
    if(pivotNode && pivotNode.left){
        RBNode<id>* newPivot = pivotNode.left;
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

-(RBNode<id>* _Nullable) findAppropriatePlaceForNewValue:(id) value {
    if(root == nil){
        return nil;
    }
    else{
        RBNode<id>* currentNode = self->root;
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

-(void) createLinkFrom: (RBNode<id>*) child to: (RBNode<id>*) parent {
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

-(RBNode<id>* _Nullable) getSiblingNode: (RBNode<id>* _Nullable) node {
    if(node) {
        if ([node isRight]) {
            return node.parent.left;
        } else if ([node isLeft]) {
            return node.parent.right;
        }
    }
    return nil;
}

-(RBNode<id>* _Nullable)colorUntilRBTPropertiesArePreserved: (RBNode<id>* _Nullable) initialNode {
    if (initialNode) {
        RBNode<id>* uncle = [self getSiblingNode:initialNode.parent];
        RBNode<id>* currentNode=initialNode.parent;
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

-(bool)requiresColoring: (RBNode<id>*) currentNode {
    if(currentNode && currentNode.color == RED && currentNode.parent && currentNode.parent.color == RED){
        RBNode<id>* uncle = [self getSiblingNode:currentNode.parent];
        return uncle != nil && uncle.color == RED;
    } else {
        return false;
    }
}

-(bool)requiresRotation: (RBNode<id>*) currentNode {
    if(currentNode != nil && currentNode.color==RED && currentNode.parent != nil && currentNode.parent.color == RED) {
        RBNode<id>* uncle = [self getSiblingNode:currentNode.parent];
        return !uncle || uncle.color == BLACK;
    }
    return false;
}

-(void) changeColorAfterLeftRotation: (RBNode<id>*) pivot {
    if(pivot!=nil){
        [pivot swapColor];
    }
    if(pivot.left!=nil){
        [pivot.left swapColor];
    }
}

-(void) changeColorAfterRightRotation: (RBNode<id>*) pivot {
    if(pivot!=nil){
        [pivot swapColor];
    }
    if(pivot.right!=nil){
        [pivot.right swapColor];
    }
}

- (id) objectForKey: (id) anObject {
    RBNode<id>* node = [self searchFor:anObject from: root];
    if (node) {
        return [node data];
    }
    return nil;
}

-(RBNode<id>* _Nullable) getMinNodeFromSubtree: (RBNode<id>* _Nullable) node {
    if(node!=nil){
        RBNode<id>* currentMin = node;
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

-(RBNode<id>* _Nullable) searchFor: (id _Nonnull) value {
    return [self searchFor:value from:self->root];
}

-(RBNode<id>* _Nullable) searchFor: (id _Nonnull) value from: (RBNode<id>* _Nonnull) initialNode {
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

-(RBNode<id>* _Nullable) binaryDelete: (id _Nonnull) value OptionalPointerToNode: (RBNode<id>* _Nullable) node {
    if((node == nil && ((node=[self searchFor:value]) == nil))||([[node data] isEqual:value]==false)){
        [NSException raise:@"There is no such value" format:@"Value was %@", value];
    }
    int amountOfChildren = [node childrenAmount];
    RBNode <id>* nodeToConnectWithParent = nil;
    if (amountOfChildren == 1) {
        if([node left]){
            nodeToConnectWithParent=node.left;
        } else {
            nodeToConnectWithParent=node.right;
        }
    }
    else if (amountOfChildren == 2) {
        RBNode <id>* minimum = [self getMinNodeFromSubtree:node.right];
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

-(BOOL) deleteValue: (id _Nonnull) value searchFrom: (RBNode<id>*) initialNode {
    RBNode<id>* nodeToDelete = [self searchFor:value from:initialNode];
    if (nodeToDelete && [value isEqual: [nodeToDelete data]]){
        int amountOfKids = [nodeToDelete childrenAmount];
        if(amountOfKids == 2) {
            RBNode<id>* minimalNode = [self getMinNodeFromSubtree:nodeToDelete.right];
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
                RBNode<id>* parent = nodeToDelete.parent;
                [self binaryDelete:value OptionalPointerToNode:nodeToDelete];
                [self deleteCaseOne: parent];
            }
        }
    }
    return nodeToDelete != nil;
}

-(void) deleteCaseOne: (RBNode<id>*) parentNode {
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

-(bool) isBlack: (RBNode<id>* _Nullable) node {
    return !node || node.color == BLACK;
}

-(void)deleteCaseTwo:(RBNode<id>*) parentNode {
    RBNode<id>* redChild = [parentNode getRedKid];
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

-(void)deleteCaseThree: (RBNode<id>*) parentNode {
    if(parentNode.color==BLACK){
        int leftheight = [self countBlackNodesIn:parentNode.left];
        int rightheight = [self countBlackNodesIn:parentNode.right];
        RBNode<id>* nodeToExaminate = parentNode.left;
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

-(void) deleteCaseFour: (RBNode<id>*) parentNode {
    if(parentNode.color==RED){
        int leftheight = [self countBlackNodesIn:parentNode.left];
        int rightheight = [self countBlackNodesIn:parentNode.right];
        RBNode<id>* nodeToExaminate = parentNode.left;
        if(rightheight>leftheight){
            nodeToExaminate=parentNode.right;
        }
        if([self isBlack:nodeToExaminate]&& nodeToExaminate!=nil && [nodeToExaminate bothKidsAreBlack]){
            [parentNode swapColor];
            [nodeToExaminate swapColor];
            if([parentNode childrenAmount] == 2){
                RBNode<id>* sibling = [self getSiblingNode:nodeToExaminate];
                [sibling setColor:BLACK];
            }
            return;
        }
    }
    [self deleteCaseFive:parentNode];
}

-(void) deleteCaseFive: (RBNode<id>*) parentNode {
    if(parentNode.color==BLACK){
        int leftheight = [self countBlackNodesIn:parentNode.left];
        int rightheight = [self countBlackNodesIn:parentNode.right];
        RBNode<id>* nodeToExaminate = parentNode.left;
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

-(void) deleteCaseSix: (RBNode<id>*) parentNode {
    int leftheight = [self countBlackNodesIn:parentNode.left];
    int rightheight = [self countBlackNodesIn:parentNode.right];
    RBNode<id>* nodeToExaminate = parentNode.left;
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
    RBNode<id>* childToInsert = [[RBNode alloc] initWithParent:nil andValue:value];
    RBNode<id>* parentNode = [self findAppropriatePlaceForNewValue:value];
    [self createLinkFrom:childToInsert to:parentNode];
    RBNode<id>* currentNode = [self colorUntilRBTPropertiesArePreserved:childToInsert];
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
