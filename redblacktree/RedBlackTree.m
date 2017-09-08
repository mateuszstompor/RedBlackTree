//
//  RedBlackTree.m
//  RED_BLACK_TREES
//
//  Created by Mateusz Stompór on 29/03/2017.
//  Copyright © 2017 Mateusz Stompór. All rights reserved.
//
#import <Foundation/Foundation.h>
#import "RedBlackTree.h"

@implementation RedBlackTree
-(instancetype _Nonnull)init {
    self = [super init];
    self->rootNode = nil;
    return self;
}
-(instancetype _Nonnull)initWithValue: (id _Nonnull) value{
    self = [self init];
    [self insert:value];
    return self;
}
-(void) setRoot: (RedBlackNode<id>* _Nonnull) root{
    if(root!=nil){
        self->rootNode=root;
    }
}
-(RedBlackNode<id>* _Nullable) getRoot{
    return self->rootNode;
}
-(bool) isValid{
    return [self countBlackNodesIn:self->rootNode]!=-1 ? true : false;
}
-(int) countBlackNodesIn: (RedBlackNode<id>* _Nullable) currentPoint {
    if(currentPoint==nil){
        return 1;
    }
    else{
        int leftSubTree = [self countBlackNodesIn:currentPoint.leftChild];
        int rightSubTree = [self countBlackNodesIn:currentPoint.rightChild];
        if(leftSubTree!=rightSubTree){
            NSLog(@"error Occured");
            return -1;
        }
        else{
            return currentPoint.color==BLACK ? rightSubTree+1 : rightSubTree;
        }
    }
}
-(void) rotateLeft: (RedBlackNode<id>* _Nonnull) pivotNode{
    if(pivotNode!=nil && pivotNode.rightChild != nil){
        RedBlackNode<id>* newPivot = pivotNode.rightChild;
        newPivot.parent = pivotNode.parent;
        if(pivotNode.parent!=nil){
            if([self isLeftChild:pivotNode]){
                pivotNode.parent.leftChild=newPivot;
            }
            else{
                pivotNode.parent.rightChild=newPivot;
            }
        }
        if (newPivot.leftChild != nil){
            pivotNode.rightChild=newPivot.leftChild;
            newPivot.leftChild.parent=pivotNode;
        }
        else{
            pivotNode.rightChild=nil;
        }
        newPivot.leftChild = pivotNode;
        pivotNode.parent=newPivot;
    }
}

-(void) rotateRight: (RedBlackNode<id>* _Nonnull) pivotNode{
    if(pivotNode!=nil && pivotNode.leftChild != nil){
        RedBlackNode<id>* newPivot = pivotNode.leftChild;
        newPivot.parent = pivotNode.parent;
        if(pivotNode.parent!=nil){
            if([self isLeftChild:pivotNode]){
                pivotNode.parent.leftChild=newPivot;
            }
            else{
                pivotNode.parent.rightChild=newPivot;
            }
        }
        else{
            self->rootNode=newPivot;
        }
        if (newPivot.rightChild != nil){
            pivotNode.leftChild=newPivot.rightChild;
            newPivot.rightChild.parent=pivotNode;
        }
        else{
            pivotNode.leftChild=nil;
        }
        newPivot.rightChild = pivotNode;
        pivotNode.parent=newPivot;
    }
}
-(RedBlackNode<id>* _Nullable) findAppropriatePlaceForNewValue:(id) value{
    if(self->rootNode==nil){
        return nil;
    }
    else{
        RedBlackNode<id>* currentNode = self->rootNode;
        while(([value isGreaterThan:[currentNode getData]] && currentNode.rightChild!=nil)||
              ([value isLessThan:[currentNode getData]] && currentNode.leftChild!=nil)){
            if([value isGreaterThan:[currentNode getData]]){
                currentNode=currentNode.rightChild;
            }
            else{
                currentNode=currentNode.leftChild;
            }
        }
        return currentNode;
    }
}
-(void) createLinkFrom: (RedBlackNode<id>*) child to: (RedBlackNode<id>*) parent{
    if(parent == nil){
        self->rootNode=child;
    }else{
        if([[child getData] isGreaterThan:[parent getData]]){
            parent.rightChild=child;
        }
        else{
            parent.leftChild=child;
        }
        [child setParent:parent];
    }
}
-(RedBlackNode<id>* _Nullable) getSiblingNode: (RedBlackNode<id>* _Nullable) node{
    if(node!=nil){
        if([self isRightChild:node]){
            return node.parent.leftChild;
        }
        else if([self isLeftChild:node]){
            return node.parent.rightChild;
        }
        else{
            return nil;
        }
    }
    else{
        return nil;
    }
}

-(RedBlackNode<id>* _Nullable)colorUntilRBTPropertiesArePreserved: (RedBlackNode<id>* _Nullable) initialNode{
    if(initialNode != nil){
        RedBlackNode<id>* uncle = [self getSiblingNode:initialNode.parent];
        RedBlackNode<id>* currentNode=initialNode.parent;
        while([self requiresColoring:initialNode]){
            [currentNode changeColor];
            [uncle changeColor];
            [currentNode.parent changeColor];
            initialNode=uncle.parent;
            if(initialNode!=nil){
                currentNode=initialNode.parent;
            }
            else{
                currentNode=nil;
            }
            uncle=[self getSiblingNode:currentNode];
        }
        return initialNode;
    }
    else{
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
    if(currentNode != nil && currentNode.color==RED && currentNode.parent!=nil && currentNode.parent.color==RED){
        RedBlackNode<id>* uncle = [self getSiblingNode:currentNode.parent];
        if(uncle!=nil && uncle.color==RED){
            return true;
        }
        else{
            return false;
        }
    }
    else{
        return false;
    }
}
-(bool)requiresRotation: (RedBlackNode<id>*) currentNode{
    if(currentNode != nil && currentNode.color==RED && currentNode.parent != nil && currentNode.parent.color==RED){
        RedBlackNode<id>* uncle = [self getSiblingNode:currentNode.parent];
        if(uncle == nil || uncle.color==BLACK){
            return true;
        }
        else{
            return false;
        }
    }
    else{
        return false;
    }
}
-(bool) isRightChild:(RedBlackNode<id>*) node{
    if(node!=nil&&node.parent!=nil&&node.parent.rightChild==node){
        return true;
    }
    else{
        return false;
    }
}
-(bool) isLeftChild:(RedBlackNode<id>*) node{
    if(node!=nil && node.parent!=nil && node.parent.leftChild==node){
        return true;
    }
    else{
        return false;
    }
}
-(void) changeColorAfterLeftRotation: (RedBlackNode<id>*) pivot{
    if(pivot!=nil){
        [pivot changeColor];
    }
    if(pivot.leftChild!=nil){
        [pivot.leftChild changeColor];
    }
}
-(void) changeColorAfterRightRotation: (RedBlackNode<id>*) pivot{
    if(pivot!=nil){
        [pivot changeColor];
    }
    if(pivot.rightChild!=nil){
        [pivot.rightChild changeColor];
    }
}
-(RedBlackNode<id>*) getNewRoot: (RedBlackNode<id>*) node{
    if(node!=nil){
        while(node.parent!=nil){
            node=node.parent;
        }
        return node;
    }
    else{
        return nil;
    }
}
-(bool) isRoot: (RedBlackNode<id>*) node{
    if(node!=nil && node.parent==nil){
        return true;
    }
    else{
        return false;
    }
}
-(NSString*) inOrder: (RedBlackNode<id>*) node{
    NSMutableString* stringToReturn = [[NSMutableString alloc] init];
    if(node!=nil){
        [stringToReturn appendString:[self inOrder:node.leftChild]];
        [stringToReturn appendString:[((NSNumber*) [node getData]) stringValue]];
        if(node.color == RED){
            [stringToReturn appendString:@"R "];
        }else{
            [stringToReturn appendString:@"B "];
        }
        [stringToReturn appendString:[self inOrder:node.rightChild]];
    }
    return stringToReturn;
}
-(void)printInOrderFrom: (RedBlackNode<id>*) node{
    if(node!=nil){
        [self printInOrderFrom:node.leftChild];
        if(node.parent==nil){
            NSLog(@"===root===");
        }
        if(node.color==RED){
            NSLog(@"( d:%@ c:RED ) ", [node getData]);
        }
        else{
            NSLog(@"( d:%@ c:BLACK ) ", [node getData]);
        }
        if(node.parent==nil){
            NSLog(@"===end===");
        }
        [self printInOrderFrom:node.rightChild];
    }
}

-(RedBlackNode<id>* _Nullable) getMinNodeFromSubtree: (RedBlackNode<id>* _Nullable) node{
    if(node!=nil){
        RedBlackNode<id>* currentMin = node;
        node=node.leftChild;
        while(node!=nil){
            if([[node getData] isLessThan:[currentMin getData]]){
                currentMin=node;
            }
            node=node.leftChild;
        }
        return currentMin;
    }
    return nil;
}
-(bool)contains: (id _Nonnull) value{
    if([self searchFor:value]!=nil){
        return true;
    }
    else{
        return false;
    }
}
-(RedBlackNode<id>* _Nullable) searchFor: (id _Nonnull) value{
    RedBlackNode<id>* initialNode = self->rootNode;
    while(initialNode!=nil){
        if([value isEqual:[initialNode getData]]){
            return initialNode;
        }
        else if([value isGreaterThan:[initialNode getData]]){
            initialNode=initialNode.rightChild;
        }
        else{
            initialNode=initialNode.leftChild;
        }
    }
    return nil;
}
-(RedBlackNode<id>* _Nullable) searchFor: (id _Nonnull) value from: (RedBlackNode<id>* _Nonnull) initialNode{
    while(initialNode!=nil){
        if([value isEqual:[initialNode getData]]){
            return initialNode;
        }
        else if([value isGreaterThan:[initialNode getData]]){
            initialNode=initialNode.rightChild;
        }
        else{
            initialNode=initialNode.leftChild;
        }
    }
    return nil;
}
-(void) printInOrder{
    [self printInOrderFrom:self->rootNode];
}
-(int) amountOfChildren: (RedBlackNode<id>* _Nonnull) node {
    if(node.leftChild != nil && node.rightChild != nil){
        return 2;
    }else if(node.leftChild != nil || node.rightChild != nil){
        return 1;
    }
    else{
        return 0;
    }
}
-(bool) hasLeftChild: (RedBlackNode<id>* _Nonnull) node{
    if(node.leftChild!=nil){
        return true;
    }else{
        return false;
    }
}
-(bool) hasRightChild: (RedBlackNode<id>* _Nonnull) node{
    if(node.rightChild!=nil){
        return true;
    }else{
        return false;
    }
}
-(RedBlackNode<id>* _Nullable) binaryDelete: (id _Nonnull) value OptionalPointerToNode: (RedBlackNode<id>* _Nullable) node{
    if((node == nil && ((node=[self searchFor:value]) == nil))||([[node getData] isEqual:value]==false)){
        [NSException raise:@"There is no such value" format:@"Value was %@", value];
    }
    int amountOfChildren = [self amountOfChildren:node];
    RedBlackNode <id>* nodeToConnectWithParent=nil;
    if(amountOfChildren==1){
        if([self hasLeftChild:node]){
            nodeToConnectWithParent=node.leftChild;
        }
        else{
            nodeToConnectWithParent=node.rightChild;
        }
    }
    else if(amountOfChildren==2){
        RedBlackNode <id>* minimum = [self getMinNodeFromSubtree:node.rightChild];
        [self binaryDelete:[minimum getData] OptionalPointerToNode:minimum];
        nodeToConnectWithParent=minimum;
        minimum.leftChild=node.leftChild;
        minimum.rightChild=node.rightChild;
        node.leftChild.parent=minimum;
        node.rightChild.parent=minimum;
    }
    if([self isRightChild:node]){
        node.parent.rightChild=nodeToConnectWithParent;

    }
    else if([self isLeftChild:node]){
        node.parent.leftChild=nodeToConnectWithParent;
    }
    if(nodeToConnectWithParent!=nil){
        nodeToConnectWithParent.parent=node.parent;
    }
    if(node==self->rootNode){
        self->rootNode=nodeToConnectWithParent;
    }
    return nodeToConnectWithParent.parent;
}
-(bool) hasRedChild: (RedBlackNode<id>* _Nonnull) node{
    return (node.leftChild != nil && node.leftChild.color==RED)||(node.rightChild != nil && node.rightChild.color==RED) ? true : false;
}
-(void) deleteValue: (id _Nonnull) value{
    [self deleteValue:value searchFrom:self->rootNode];
}
-(void) deleteValue: (id _Nonnull) value searchFrom: (RedBlackNode<id>*) initialNode{
    RedBlackNode<id>* nodeToDelete = [self searchFor:value from:initialNode];
    if(nodeToDelete!=nil && [value isEqual: [nodeToDelete getData]]){
        int amountOfKids = [self amountOfChildren:nodeToDelete];
        if(amountOfKids==2){
            RedBlackNode<id>* minimalNode = [self getMinNodeFromSubtree:nodeToDelete.rightChild];
            [nodeToDelete setData:[minimalNode getData]];
            [self deleteValue:[minimalNode getData] searchFrom:minimalNode];
        }
        else{
            if(amountOfKids<2 && nodeToDelete.color==RED){
                [self binaryDelete:value OptionalPointerToNode:nodeToDelete];
                return;
            }
            else if(nodeToDelete.color==BLACK && amountOfKids==1){
                if(([self hasLeftChild:nodeToDelete] && nodeToDelete.leftChild.color==RED)
                   ||([self hasRightChild:nodeToDelete] && nodeToDelete.rightChild.color==RED)){
                    if([self hasRightChild:nodeToDelete]){
                        [nodeToDelete.rightChild changeColor];
                    }
                    else{
                        [nodeToDelete.leftChild changeColor];
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
        NSLog(@"first case!");
        if(rootNode!=nil){
            NSLog(@"first case!");
            int leftheight = [self countBlackNodesIn:self->rootNode.leftChild];
            int rightheight = [self countBlackNodesIn:self->rootNode.rightChild];
            if(leftheight==rightheight){
                (self->rootNode).color=BLACK;
                return;
            }
        }else{
            return;
        }
    }else{
        [self deleteCaseTwo:parentNode];
        return;
    }
}
-(bool) isBlack: (RedBlackNode<id>* _Nullable) node{
    return (node==nil || node.color==BLACK) ? true : false;
}
-(bool) bothKidsAreBlack: (RedBlackNode<id>*_Nonnull) node{
    return [self isBlack:node.leftChild] && [self isBlack:node.rightChild] ? true : false;
}
-(RedBlackNode<id>*) getRedKid: (RedBlackNode<id>* _Nonnull) node{
    if(node.leftChild!=nil&&node.leftChild.color==RED){
        return node.leftChild;
    }
    else if(node.rightChild!=nil && node.rightChild.color==RED){
        return node.rightChild;
    }
    else{
        return nil;
    }
}
-(void)deleteCaseTwo:(RedBlackNode<id>*) parentNode{
    if([self hasRedChild:parentNode] && [self bothKidsAreBlack:[self getRedKid:parentNode]]){
        int leftheight = [self countBlackNodesIn:parentNode.leftChild];
        int rightheight = [self countBlackNodesIn:parentNode.rightChild];
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
        int leftheight = [self countBlackNodesIn:parentNode.leftChild];
        int rightheight = [self countBlackNodesIn:parentNode.rightChild];
        RedBlackNode<id>* nodeToExaminate = parentNode.leftChild;
        if(rightheight>leftheight){
            nodeToExaminate=parentNode.rightChild;
        }
        if(nodeToExaminate.color==BLACK && [self bothKidsAreBlack:nodeToExaminate]){
            NSLog(@"it is case three!");
            [nodeToExaminate changeColor];
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
        int leftheight = [self countBlackNodesIn:parentNode.leftChild];
        int rightheight = [self countBlackNodesIn:parentNode.rightChild];
        RedBlackNode<id>* nodeToExaminate = parentNode.leftChild;
        if(rightheight>leftheight){
            nodeToExaminate=parentNode.rightChild;
        }
        if([self isBlack:nodeToExaminate]&& nodeToExaminate!=nil && [self bothKidsAreBlack:nodeToExaminate]){
            NSLog(@"it is case four");
            [parentNode changeColor];
            [nodeToExaminate changeColor];
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
    bool left = parentNode.leftChild==nil || parentNode.leftChild.color==BLACK;
    bool right = parentNode.rightChild==nil || parentNode.rightChild.color==BLACK;
    return (parentNode!=nil)&&(left || right);
}
-(void) deleteCaseFive: (RedBlackNode<id>*) parentNode{
    if(parentNode.color==BLACK){
        int leftheight = [self countBlackNodesIn:parentNode.leftChild];
        int rightheight = [self countBlackNodesIn:parentNode.rightChild];
        RedBlackNode<id>* nodeToExaminate = parentNode.leftChild;
        if(rightheight>leftheight){
            nodeToExaminate=parentNode.rightChild;
        }
        if(nodeToExaminate.color==BLACK && [self hasRedChild:nodeToExaminate] && [self hasBlackChild:nodeToExaminate]){
            if(rightheight>leftheight && nodeToExaminate.leftChild!=nil && nodeToExaminate.leftChild.color==RED){
                [self rotateRight:nodeToExaminate];
                [self changeColorAfterRightRotation:nodeToExaminate.parent];
            }
            else if(leftheight>rightheight && nodeToExaminate.rightChild!=nil && nodeToExaminate.rightChild.color==RED){
                [self rotateLeft:nodeToExaminate];
                [self changeColorAfterLeftRotation:nodeToExaminate.parent];
            }
        }
    }
    [self deleteCaseSix:parentNode];
    return;

}
-(void) deleteCaseSix: (RedBlackNode<id>*) parentNode{
    int leftheight = [self countBlackNodesIn:parentNode.leftChild];
    int rightheight = [self countBlackNodesIn:parentNode.rightChild];
    RedBlackNode<id>* nodeToExaminate = parentNode.leftChild;
    if(rightheight>leftheight){
        nodeToExaminate=parentNode.rightChild;
    }
    if(rightheight>leftheight && nodeToExaminate.rightChild.color==RED){
        [self rotateLeft:parentNode];
        [self changeColorAfterLeftRotation:parentNode.parent];
        return;
    }
    else if(leftheight>rightheight && nodeToExaminate.leftChild==RED){
        [self rotateRight:parentNode];
        [self changeColorAfterRightRotation:parentNode.parent];
        return;
    }
    [self deleteCaseOne:parentNode];
    return;
}
-(RedBlackNode<id>* _Nonnull) insert: (id _Nonnull) value{
    RedBlackNode<id>* childToInsert = [[RedBlackNode alloc] initWithParent:nil andValue:value];
    RedBlackNode<id>* parentNode = [self findAppropriatePlaceForNewValue:value];
    [self createLinkFrom:childToInsert to:parentNode];
    RedBlackNode<id>* currentNode = [self colorUntilRBTPropertiesArePreserved:childToInsert];
    if([self requiresRotation:currentNode]){
        if([self isLeftChild:currentNode] && [self isLeftChild:currentNode.parent]){
            //NSLog(@"zig-zig right rotation");
            [self rotateRightAndValidateConnection:currentNode.parent.parent shouldChangeColors:false];
            [self changeColorAfterRightRotation:currentNode.parent];
        }
        else if([self isLeftChild:currentNode] && [self isRightChild:currentNode.parent]){
            //NSLog(@"zig zak right - left");
            [self rotateRightAndValidateConnection:currentNode.parent shouldChangeColors:false];
            [self rotateLeftAndValidateConnection:currentNode.parent shouldChangeColors:false];
            [self changeColorAfterLeftRotation:currentNode];
        }
        else if([self isRightChild:currentNode] && [self isLeftChild:currentNode.parent]){
            //NSLog(@"zig zak left - right");
            [self rotateLeftAndValidateConnection:currentNode.parent shouldChangeColors:false];
            [self rotateRightAndValidateConnection:currentNode.parent shouldChangeColors:false];
            [self changeColorAfterRightRotation:currentNode];
        }
        else{
            //NSLog(@"zak-zak left rotation");
            [self rotateLeftAndValidateConnection:currentNode.parent.parent shouldChangeColors:false];
            [self changeColorAfterLeftRotation:currentNode.parent];
        }
    }
    [self->rootNode setColor:BLACK];
    return childToInsert;
}



//male podsumowanie
/*
 funkcja coloruntil powinna miec w sobie petle while i kolorowac dopoki jest taka potrzeba, zwrocic jakis node "newNodeToConsider" i w zaleznosci od tego
 jaki bedzie wujek ntc nie robie nic, albo rotacje (jedna lub dwie)
    gparent
   /      \
 uncle    parent
            \
            ntc

 */
@end
//six not ok, one ok, two ok, three do poprawy, four ok
