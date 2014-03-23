//
//  DSViewController.m
//  Breakout
//
//  Created by Dan Szeezil on 3/20/14.
//  Copyright (c) 2014 Dan Szeezil. All rights reserved.
//

#import "DSViewController.h"
#import "BallView.h"
#import "PaddleView.h"
#import "BlockView.h"


@interface DSViewController () 

{
    __weak IBOutlet BallView *ballView;
    __weak IBOutlet PaddleView *paddleView;
    __weak IBOutlet BlockView *blockView;
    
    
    UIDynamicAnimator *dynamicAnimator;
    
    UIPushBehavior *pushBehavior;
    
    UICollisionBehavior *collisionBehavior;
    
    UIDynamicItemBehavior *ballDynamicBehavior;
    UIDynamicItemBehavior *paddleDynamicBehavior;
    UIDynamicItemBehavior *blockDynamicBehavior;

}

@end

@implementation DSViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
//    set the VC as the delegate for collisionBehavior
    collisionBehavior.collisionDelegate = self;
    
	
    dynamicAnimator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];
    
    pushBehavior = [[UIPushBehavior alloc] initWithItems:@[ballView] mode:UIPushBehaviorModeInstantaneous];
    pushBehavior.pushDirection = CGVectorMake(0.5, 1.0);
    pushBehavior.active =YES;
    pushBehavior.magnitude = 0.5;
    [dynamicAnimator addBehavior:pushBehavior];
    
    collisionBehavior = [[UICollisionBehavior alloc] initWithItems:@[ballView, paddleView, blockView]];
    collisionBehavior.collisionMode = UICollisionBehaviorModeEverything;
    collisionBehavior.translatesReferenceBoundsIntoBoundary = YES;
    collisionBehavior.collisionDelegate = self;
    [dynamicAnimator addBehavior:collisionBehavior];
    
    ballDynamicBehavior = [[UIDynamicItemBehavior alloc] initWithItems:@[ballView]];
    ballDynamicBehavior.allowsRotation = NO;
    ballDynamicBehavior.elasticity = 1.0;
    ballDynamicBehavior.friction = 0.0;
    ballDynamicBehavior.resistance = 0.0;
    [dynamicAnimator addBehavior:ballDynamicBehavior];
    
    paddleDynamicBehavior = [[UIDynamicItemBehavior alloc] initWithItems:@[paddleView]];
    paddleDynamicBehavior.allowsRotation = NO;
    paddleDynamicBehavior.density = 1000;
    [dynamicAnimator addBehavior:paddleDynamicBehavior];
    
    blockDynamicBehavior = [[UIDynamicItemBehavior alloc] initWithItems:@[blockView]];
    blockDynamicBehavior.allowsRotation = YES;
    blockDynamicBehavior.elasticity = 1.0;
    blockDynamicBehavior.friction = 0.0;
    blockDynamicBehavior.resistance = 0.0;
    [dynamicAnimator addBehavior:blockDynamicBehavior];
    
    

    
    UIView *block1 = [[UIView alloc] initWithFrame:CGRectMake(40, 40, 33, 20)];
    block1.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:block1];
    
    UIView *block2 = [[UIView alloc] initWithFrame:CGRectMake(80, 80, 25, 30)];
    block2.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:block2];
    
    UIView *block3 = [[UIView alloc] initWithFrame:CGRectMake(120, 120, 30, 30)];
    block3.backgroundColor = [UIColor blackColor];
    [self.view addSubview:block3];
    
    [collisionBehavior addItem:block1];
    [collisionBehavior addItem:block2];
    [collisionBehavior addItem:block3];


    
    
    
}


- (IBAction)dragPaddle:(UIPanGestureRecognizer *)panGestureRecoginizer {
    
    paddleView.center = CGPointMake([panGestureRecoginizer locationInView:self.view].x, paddleView.center.y);
    
    [dynamicAnimator updateItemUsingCurrentState:paddleView];
}



-(void)resetPushBehavior
{
    pushBehavior = nil;
    pushBehavior = [[UIPushBehavior alloc]initWithItems:@[ballView] mode:UIPushBehaviorModeInstantaneous];
    pushBehavior.active = YES;
    pushBehavior.magnitude =  0.1;
    [dynamicAnimator addBehavior:pushBehavior];
    
}


#pragma mark - Collision delegate methods

//  collision with bottom boundary

-(void)collisionBehavior:(UICollisionBehavior *)behavior beganContactForItem:(id<UIDynamicItem>)item withBoundaryIdentifier:(id<NSCopying>)identifier atPoint:(CGPoint)p {
    
    if (ballView.frame.origin.y >= (self.view.frame.size.height-(ballView.frame.size.height*2))) {
        
        ballView.center = CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height/2);
        
        [dynamicAnimator updateItemUsingCurrentState:ballView];
        
//      create method encapsulating all reset settings
        [self resetPushBehavior];
    }
}


//  collision of ball (item1) with block (item2)

-(void)collisionBehavior:(UICollisionBehavior *)behavior beganContactForItem:(id<UIDynamicItem>)item1 withItem:(id<UIDynamicItem>)item2 atPoint:(CGPoint)p
{
    BlockView *block = (BlockView*)item2;
    
    
    if ([item2 isKindOfClass:[BlockView class]]) {
        [collisionBehavior removeItem:block];
    }
    
    
    
//    if([item2 isKindOfClass:[BlockView class]] && block.hits <= 1)
//    {
//        [UIView animateWithDuration:1.5 animations:^
//         {
//             block.backgroundColor = [UIColor whiteColor];
//         } completion:^(BOOL finished)
//         {
//             [collisionBehavior removeItem:item2];
//             [block removeFromSuperview];
//             numberOfBlocks--;
//         }];
//    }
//    else if ([item2 isKindOfClass:[BlockView class]] && block.hits >1)
//    {
//        
//        [UIView animateWithDuration:1.0 animations:^
//         {
//             block.backgroundColor = [UIColor orangeColor];
//             block.hits--;
//         } completion:^(BOOL finished)
//         {
//             
//         }];
//        
//    }
//    
//    if(numberOfBlocks ==0)
//    {
//        [self resetGame];
//    }

}


@end




























