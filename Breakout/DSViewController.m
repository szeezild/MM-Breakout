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

    NSMutableArray *arrayOfBlocks;
    
    UIDynamicAnimator *dynamicAnimator;
    
    UIPushBehavior *pushBehavior;
    
    UICollisionBehavior *collisionBehavior;
    
    UIDynamicItemBehavior *ballDynamicBehavior;
    UIDynamicItemBehavior *paddleDynamicBehavior;
    UIDynamicItemBehavior *blockDynamicBehavior;

    BlockView *block1;
    BlockView *block2;
    BlockView *block3;
    BlockView *block4;
    BlockView *block5;
    BlockView *block6;
    BlockView *block7;
    BlockView *block8;
    BlockView *block9;
    BlockView *block10;
    BlockView *block11;
    BlockView *block12;
    BlockView *block13;
    BlockView *block14;
    
}

@end

@implementation DSViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    block1 = [[BlockView alloc] initWithFrame:CGRectMake(40, 80, 30, 20)];
    block1.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:block1];
    
    block2 = [[BlockView alloc] initWithFrame:CGRectMake(75, 80, 30, 20)];
    block2.backgroundColor = [UIColor greenColor];
    [self.view addSubview:block2];
    
    block3 = [[BlockView alloc] initWithFrame:CGRectMake(110, 80, 30, 20)];
    block3.backgroundColor = [UIColor blackColor];
    [self.view addSubview:block3];
    
    block4 = [[BlockView alloc] initWithFrame:CGRectMake(145, 80, 30, 20)];
    block4.backgroundColor = [UIColor purpleColor];
    [self.view addSubview:block4];
    
    block5 = [[BlockView alloc] initWithFrame:CGRectMake(180, 80, 30, 20)];
    block5.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:block5];
    
    block6 = [[BlockView alloc] initWithFrame:CGRectMake(215, 80, 30, 20)];
    block6.backgroundColor = [UIColor grayColor];
    [self.view addSubview:block6];
    
    block7 = [[BlockView alloc] initWithFrame:CGRectMake(250, 80, 30, 20)];
    block7.backgroundColor = [UIColor redColor];
    [self.view addSubview:block7];
    
    block8 = [[BlockView alloc] initWithFrame:CGRectMake(40, 105, 30, 20)];
    block8.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:block8];
    
    block9 = [[BlockView alloc] initWithFrame:CGRectMake(75, 105, 30, 20)];
    block9.backgroundColor = [UIColor greenColor];
    [self.view addSubview:block9];
    
    block10 = [[BlockView alloc] initWithFrame:CGRectMake(110, 105, 30, 20)];
    block10.backgroundColor = [UIColor blackColor];
    [self.view addSubview:block10];
    
    block11 = [[BlockView alloc] initWithFrame:CGRectMake(145, 105, 30, 20)];
    block11.backgroundColor = [UIColor purpleColor];
    [self.view addSubview:block11];
    
    block12 = [[BlockView alloc] initWithFrame:CGRectMake(180, 105, 30, 20)];
    block12.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:block12];
    
    block13 = [[BlockView alloc] initWithFrame:CGRectMake(215, 105, 30, 20)];
    block13.backgroundColor = [UIColor grayColor];
    [self.view addSubview:block13];
    
    block14 = [[BlockView alloc] initWithFrame:CGRectMake(250, 105, 30, 20)];
    block14.backgroundColor = [UIColor redColor];
    [self.view addSubview:block14];
    
    
    arrayOfBlocks = [NSMutableArray arrayWithObjects:block1, block2, block3, block4, block5, block6, block7, block8, block9, block10, block11, block12, block13, block14, nil];
    
    dynamicAnimator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];

    collisionBehavior = [[UICollisionBehavior alloc] initWithItems:@[ballView, paddleView, block1, block2, block3, block4, block5, block6, block7, block8, block9, block10, block11, block12, block13, block14]];
    
    
//    set the VC as the delegate for collisionBehavior
    collisionBehavior.collisionDelegate = self;
    
    
    pushBehavior = [[UIPushBehavior alloc] initWithItems:@[ballView] mode:UIPushBehaviorModeInstantaneous];
    pushBehavior.pushDirection = CGVectorMake(0.5, 1.0);
    pushBehavior.active =YES;
    pushBehavior.magnitude = 0.5;
    [dynamicAnimator addBehavior:pushBehavior];
    
    collisionBehavior.collisionMode = UICollisionBehaviorModeEverything;
    collisionBehavior.translatesReferenceBoundsIntoBoundary = YES;
    collisionBehavior.collisionDelegate = self;
    [dynamicAnimator addBehavior:collisionBehavior];
    
    ballDynamicBehavior = [[UIDynamicItemBehavior alloc] initWithItems:@[ballView]];
    ballDynamicBehavior.allowsRotation = NO;
    ballDynamicBehavior.elasticity = 0.9;
    ballDynamicBehavior.friction = 0.0;
    ballDynamicBehavior.resistance = 0.0;
    [dynamicAnimator addBehavior:ballDynamicBehavior];
    
    paddleDynamicBehavior = [[UIDynamicItemBehavior alloc] initWithItems:@[paddleView]];
    paddleDynamicBehavior.allowsRotation = NO;
    paddleDynamicBehavior.density = 4000;
    [dynamicAnimator addBehavior:paddleDynamicBehavior];
    
    blockDynamicBehavior = [[UIDynamicItemBehavior alloc] initWithItems:arrayOfBlocks];
    blockDynamicBehavior.allowsRotation = YES;
    blockDynamicBehavior.elasticity = 1.2;
    blockDynamicBehavior.friction = 0.0;
    blockDynamicBehavior.resistance = 0.0;
    blockDynamicBehavior.density = 4000;
    [dynamicAnimator addBehavior:blockDynamicBehavior];
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
    
    if ([item2 isKindOfClass:[BlockView class]]) {
        [collisionBehavior removeItem:item2];
        [arrayOfBlocks removeObject:item2];
        [(BlockView *)item2 removeFromSuperview];
        [dynamicAnimator updateItemUsingCurrentState:item2];
    }
    if (arrayOfBlocks.count == 0) {
        [dynamicAnimator removeAllBehaviors];
        ballView.center = self.view.center;
        [self shouldStartAgain];
    }
}

-(BOOL)shouldStartAgain {
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"You Win!" message:@"Play Again?" delegate:self cancelButtonTitle:@"New Game" otherButtonTitles:nil];
    [alertView show];
    return TRUE;
}


//  restart game after Alert confirm

-(void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
    
    if (buttonIndex == 0) {
        ballView.center = CGPointMake(self.view.center.x, self.view.center.y);
        
        [self viewDidLoad];
    }
}


@end




























