//
//  RedBlackTree.m
//  RED_BLACK_TREE
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
@end

@implementation RedBlackTree

@synthesize count;
@synthesize root;

-(instancetype _Nullable) init {
    self = [super init];
    return self;
}

-(int) countBlackNodesIn: (RedBlackNode<id>* _Nullable) currentPoint {
    if(!currentPoint) {
        return 1;
    }
    else {
        int leftSubTree = [self countBlackNodesIn: currentPoint.left];
        int rightSubTree = [self countBlackNodesIn: currentPoint.right];
        assert(leftSubTree!=rightSubTree);
        return currentPoint.color == BLACK ? rightSubTree + 1 : rightSubTree;
    }
}

-(void) rotateLeft: (RedBlackNode<id>* _Nonnull) pivotNode{
    if(pivotNode!=nil && pivotNode.right != nil){
        RedBlackNode<id>* newPivot = pivotNode.right;
        newPivot.parent = pivotNode.parent;
        if(pivotNode.parent!=nil){
            if([pivotNode isRight]){
                pivotNode.parent.right=newPivot;
            }
            else{
                pivotNode.parent.left=newPivot;
            }
        }
        else{
            self->root=newPivot;
        }
        if (newPivot.left != nil){
            pivotNode.right=newPivot.left;
            newPivot.left.parent=pivotNode;
        }
        else{
            pivotNode.right=nil;
        }
        newPivot.left = pivotNode;
        pivotNode.parent=newPivot;
    }
}

-(void) rotateRight: (RedBlackNode<id>* _Nonnull) pivotNode{
    if(pivotNode!=nil && pivotNode.left != nil){
        RedBlackNode<id>* newPivot = pivotNode.left;
        newPivot.parent = pivotNode.parent;
        if(pivotNode.parent!=nil){
            if([pivotNode isLeft]){
                pivotNode.parent.left=newPivot;
            }
            else{
                pivotNode.parent.right=newPivot;
            }
        } else {
            self->root=newPivot;
        }
        if (newPivot.right != nil){
            pivotNode.left=newPivot.right;
            newPivot.right.parent=pivotNode;
        } else{
            pivotNode.left=nil;
        }
        newPivot.right = pivotNode;
        pivotNode.parent=newPivot;
    }
}

-(RedBlackNode<id>* _Nullable) findAppropriatePlaceForNewValue:(id) value{
    if(root == nil){
        return nil;
    }
    else{
        RedBlackNode<id>* currentNode = self->root;
        while(([value isGreaterThan: currentNode.data] && currentNode.right!=nil)||
              ([currentNode.data isGreaterThan: value] && currentNode.left!=nil)){
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

-(void) createLinkFrom: (RedBlackNode<id>*) child to: (RedBlackNode<id>*) parent{
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

-(RedBlackNode<id>* _Nullable) getSiblingNode: (RedBlackNode<id>* _Nullable) node{
    if(node) {
        if ([node isRight]) {
            return node.parent.left;
        } else if ([node isLeft]) {
            return node.parent.right;
        }
    }
    return nil;
}

-(RedBlackNode<id>* _Nullable)colorUntilRBTPropertiesArePreserved: (RedBlackNode<id>* _Nullable) initialNode{
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
-(void) rotateLeftAndValidateConnection: (RedBlackNode<id>*) pivot shouldChangeColors: (bool) changeColors{
    if(pivot!=nil){
        [self rotateLeft:pivot];
        if(changeColors){
            [self changeColorAfterRightRotation:pivot.parent];
        }
    }
}
-(void) rotateRightAndValidateConnection: (RedBlackNode<id>*) pivot shouldChangeColors: (bool) changeColors{
    if(pivot!=nil){
        [self rotateRight:pivot];
        if(changeColors){
            [self changeColorAfterRightRotation:pivot.parent];
        }
    }
}
-(bool)requiresColoring: (RedBlackNode<id>*) currentNode{
    if(currentNode && currentNode.color == RED && currentNode.parent && currentNode.parent.color == RED){
        RedBlackNode<id>* uncle = [self getSiblingNode:currentNode.parent];
        return uncle != nil && uncle.color == RED;
    } else {
        return false;
    }
}
-(bool)requiresRotation: (RedBlackNode<id>*) currentNode{
    if(currentNode != nil && currentNode.color==RED && currentNode.parent != nil && currentNode.parent.color==RED){
        RedBlackNode<id>* uncle = [self getSiblingNode:currentNode.parent];
        return !uncle || uncle.color == BLACK;
    }
    return false;
}

-(void) changeColorAfterLeftRotation: (RedBlackNode<id>*) pivot{
    if(pivot!=nil){
        [pivot swapColor];
    }
    if(pivot.left!=nil){
        [pivot.left swapColor];
    }
}
-(void) changeColorAfterRightRotation: (RedBlackNode<id>*) pivot{
    if(pivot!=nil){
        [pivot swapColor];
    }
    if(pivot.right!=nil){
        [pivot.right swapColor];
    }
}

-(RedBlackNode<id>* _Nullable) getMinNodeFromSubtree: (RedBlackNode<id>* _Nullable) node{
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

-(RedBlackNode<id>* _Nullable) searchFor: (id _Nonnull) value{
    return [self searchFor:value from:self->root];
}
-(RedBlackNode<id>* _Nullable) searchFor: (id _Nonnull) value from: (RedBlackNode<id>* _Nonnull) initialNode{
    while(initialNode!=nil){
        if([value isEqual:[initialNode data]]){
            return initialNode;
        }
        else if([value isGreaterThan: initialNode.data]){
            initialNode=initialNode.right;
        }
        else{
            initialNode=initialNode.left;
        }
    }
    return nil;
}
-(int) amountOfChildren: (RedBlackNode<id>* _Nonnull) node {
    if (node.left && node.right) {
        return 2;
    } else if (node.left || node.right) {
        return 1;
    } else {
        return 0;
    }
}

-(RedBlackNode<id>* _Nullable) binaryDelete: (id _Nonnull) value OptionalPointerToNode: (RedBlackNode<id>* _Nullable) node{
    if((node == nil && ((node=[self searchFor:value]) == nil))||([[node data] isEqual:value]==false)){
        [NSException raise:@"There is no such value" format:@"Value was %@", value];
    }
    int amountOfChildren = [self amountOfChildren:node];
    RedBlackNode <id>* nodeToConnectWithParent=nil;
    if(amountOfChildren==1){
        if([node left]){
            nodeToConnectWithParent=node.left;
        }
        else{
            nodeToConnectWithParent=node.right;
        }
    }
    else if(amountOfChildren==2){
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
        
    }
    else if([node isLeft]){
        node.parent.left=nodeToConnectWithParent;
    }
    if(nodeToConnectWithParent!=nil){
        nodeToConnectWithParent.parent=node.parent;
    }
    if(node==self->root){
        self->root=nodeToConnectWithParent;
    }
    return nodeToConnectWithParent.parent;
}
-(bool) hasRedChild: (RedBlackNode<id>* _Nonnull) node{
    return (node.left != nil && node.left.color==RED)||(node.right != nil && node.right.color==RED) ? true : false;
}

- (void) removeObject: (id) anObject {
    [self deleteValue: anObject searchFrom: root];
}

-(void) deleteValue: (id _Nonnull) value searchFrom: (RedBlackNode<id>*) initialNode{
    RedBlackNode<id>* nodeToDelete = [self searchFor:value from:initialNode];
    if(nodeToDelete!=nil && [value isEqual: [nodeToDelete data]]){
        int amountOfKids = [self amountOfChildren:nodeToDelete];
        if(amountOfKids==2){
            RedBlackNode<id>* minimalNode = [self getMinNodeFromSubtree:nodeToDelete.right];
            [nodeToDelete setData:[minimalNode data]];
            [self deleteValue:[minimalNode data] searchFrom:minimalNode];
        }
        else{
            if(amountOfKids < 2 && nodeToDelete.color == RED){
                [self binaryDelete:value OptionalPointerToNode:nodeToDelete];
                return;
            }
            else if(nodeToDelete.color==BLACK && amountOfKids==1){
                if(([nodeToDelete left] && nodeToDelete.left.color==RED)
                   ||([nodeToDelete right] && nodeToDelete.right.color==RED)){
                    if([nodeToDelete right]) {
                        [nodeToDelete.right swapColor];
                    }
                    else{
                        [nodeToDelete.left swapColor];
                    }
                    [self binaryDelete:value OptionalPointerToNode:nodeToDelete];
                    return;
                }
            }
            else {
                RedBlackNode<id>* parent = nodeToDelete.parent;
                [self binaryDelete:value OptionalPointerToNode:nodeToDelete];
                [self deleteCaseOne: parent];
            }
        }
    }
}

-(void)deleteCaseOne: (RedBlackNode<id>*) parentNode{
    if(parentNode==nil){
        if(root!=nil){
            int leftheight = [self countBlackNodesIn: root.left];
            int rightheight = [self countBlackNodesIn: root.right];
            if (leftheight == rightheight) {
                root.color=BLACK;
                return;
            }
        } else {
            return;
        }
    } else {
        [self deleteCaseTwo:parentNode];
        return;
    }
}
-(bool) isBlack: (RedBlackNode<id>* _Nullable) node{
    return !node || node.color == BLACK;
}
-(bool) bothKidsAreBlack: (RedBlackNode<id>*_Nonnull) node{
    return [self isBlack:node.left] && [self isBlack:node.right] ? true : false;
}
-(RedBlackNode<id>*) getRedKid: (RedBlackNode<id>* _Nonnull) node{
    if (node.left && node.left.color == RED){
        return node.left;
    } else if (node.right && node.right.color == RED) {
        return node.right;
    } else {
        return nil;
    }
}
-(void)deleteCaseTwo:(RedBlackNode<id>*) parentNode{
    if([self hasRedChild:parentNode] && [self bothKidsAreBlack:[self getRedKid:parentNode]]){
        int leftheight = [self countBlackNodesIn:parentNode.left];
        int rightheight = [self countBlackNodesIn:parentNode.right];
        if(rightheight>leftheight){
            [self rotateLeft:parentNode];
            [self changeColorAfterLeftRotation:parentNode.parent];
        }
        else{
            [self rotateRight:parentNode];
            [self changeColorAfterRightRotation:parentNode.parent];
        }
    }
    [self deleteCaseThree:parentNode];
    return;
}
-(void)deleteCaseThree: (RedBlackNode<id>*) parentNode{
    if(parentNode.color==BLACK){
        int leftheight = [self countBlackNodesIn:parentNode.left];
        int rightheight = [self countBlackNodesIn:parentNode.right];
        RedBlackNode<id>* nodeToExaminate = parentNode.left;
        if(rightheight>leftheight){
            nodeToExaminate=parentNode.right;
        }
        if(nodeToExaminate.color==BLACK && [self bothKidsAreBlack:nodeToExaminate]){
            [nodeToExaminate swapColor];
            parentNode=parentNode.parent;
            [self deleteCaseOne:parentNode];
            return;
        }
    }
    [self deleteCaseFour:parentNode];
    return;
}

-(void) deleteCaseFour: (RedBlackNode<id>*) parentNode{
    if(parentNode.color==RED){
        int leftheight = [self countBlackNodesIn:parentNode.left];
        int rightheight = [self countBlackNodesIn:parentNode.right];
        RedBlackNode<id>* nodeToExaminate = parentNode.left;
        if(rightheight>leftheight){
            nodeToExaminate=parentNode.right;
        }
        if([self isBlack:nodeToExaminate]&& nodeToExaminate!=nil && [self bothKidsAreBlack:nodeToExaminate]){
            [parentNode swapColor];
            [nodeToExaminate swapColor];
            if([self amountOfChildren:parentNode]==2){
                RedBlackNode<id>* sibling = [self getSiblingNode:nodeToExaminate];
                [sibling setColor:BLACK];
            }
            return;
        }
    }
    [self deleteCaseFive:parentNode];
    return;
}
-(bool) hasBlackChild: (RedBlackNode<id>*) parentNode{
    bool left = parentNode.left==nil || parentNode.left.color==BLACK;
    bool right = parentNode.right==nil || parentNode.right.color==BLACK;
    return (parentNode!=nil)&&(left || right);
}
-(void) deleteCaseFive: (RedBlackNode<id>*) parentNode{
    if(parentNode.color==BLACK){
        int leftheight = [self countBlackNodesIn:parentNode.left];
        int rightheight = [self countBlackNodesIn:parentNode.right];
        RedBlackNode<id>* nodeToExaminate = parentNode.left;
        if(rightheight>leftheight){
            nodeToExaminate=parentNode.right;
        }
        if(nodeToExaminate.color==BLACK && [self hasRedChild:nodeToExaminate] && [self hasBlackChild:nodeToExaminate]){
            if(rightheight>leftheight && nodeToExaminate.left!=nil && nodeToExaminate.left.color==RED){
                [self rotateRight:nodeToExaminate];
                [self changeColorAfterRightRotation:nodeToExaminate.parent];
            }
            else if(leftheight>rightheight && nodeToExaminate.right!=nil && nodeToExaminate.right.color==RED){
                [self rotateLeft:nodeToExaminate];
                [self changeColorAfterLeftRotation:nodeToExaminate.parent];
            }
        }
    }
    [self deleteCaseSix:parentNode];
    return;
    
}
-(void) deleteCaseSix: (RedBlackNode<id>*) parentNode{
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
    }
    else if(leftheight>rightheight && nodeToExaminate.left==RED){
        [self rotateRight:parentNode];
        [self changeColorAfterRightRotation:parentNode.parent];
        return;
    }
    [self deleteCaseOne:parentNode];
    return;
}
-(void) addObject: (id _Nonnull) value {
    RedBlackNode<id>* childToInsert = [[RedBlackNode alloc] initWithParent:nil andValue:value];
    RedBlackNode<id>* parentNode = [self findAppropriatePlaceForNewValue:value];
    [self createLinkFrom:childToInsert to:parentNode];
    RedBlackNode<id>* currentNode = [self colorUntilRBTPropertiesArePreserved:childToInsert];
    if([self requiresRotation:currentNode]){
        if([currentNode isLeft] && [currentNode.parent isLeft]){
            [self rotateRightAndValidateConnection:currentNode.parent.parent shouldChangeColors:false];
            [self changeColorAfterRightRotation:currentNode.parent];
        }
        else if([currentNode isLeft] && [currentNode.parent isRight]){
            [self rotateRightAndValidateConnection:currentNode.parent shouldChangeColors:false];
            [self rotateLeftAndValidateConnection:currentNode.parent shouldChangeColors:false];
            [self changeColorAfterLeftRotation:currentNode];
        }
        else if([currentNode isRight] && [currentNode.parent isLeft]){
            [self rotateLeftAndValidateConnection:currentNode.parent shouldChangeColors:false];
            [self rotateRightAndValidateConnection:currentNode.parent shouldChangeColors:false];
            [self changeColorAfterRightRotation:currentNode];
        }
        else{
            [self rotateLeftAndValidateConnection:currentNode.parent.parent shouldChangeColors:false];
            [self changeColorAfterLeftRotation:currentNode.parent];
        }
    }
    ++count;
    [self->root setColor:BLACK];
}
-(void) inOrderCallingBlock: ( void (^ _Nonnull)(id _Nonnull)) block {
    [self inOrderCallingBlock:block from: root];
}
-(void) inOrderCallingBlock: ( void (^ _Nonnull)(id _Nonnull)) block from: (RedBlackNode<id>*) node {
    if(node!=nil){
        [self inOrderCallingBlock:block from:node.left];
        block([node data]);
        [self inOrderCallingBlock:block from:node.right];
    }
}

@end
