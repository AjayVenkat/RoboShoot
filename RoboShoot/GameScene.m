//
//  GameScene.m
//  RoboShoot
//
//  Created by Ajay Venkat on 17/01/2015.
//  Copyright (c) 2015 AJTech. All rights reserved.
//

#import "GameScene.h"
SKSpriteNode *hero;
SKSpriteNode *landingSpot;
SKSpriteNode *enemyR;
SKSpriteNode *enemyL;
NSMutableArray *enemyArray;
BOOL isTouching;
CGFloat speed;
static const int heroHitCategory = 1;
static const int enemyHitCategory = 2;


@implementation GameScene

-(void)didMoveToView:(SKView *)view {
    speed = 10.0;
    
    [self spawnHero];
    [self spawnEnemyRight];
    [self spawnEnemyLeft];
    
    UISwipeGestureRecognizer *swipeLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(slideToLeftWithGestureRecognizer:)];
    swipeLeft.direction = UISwipeGestureRecognizerDirectionLeft;
    
    UISwipeGestureRecognizer *swipeRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(slideToRightWithGestureRecognizer:)];
    swipeRight.direction = UISwipeGestureRecognizerDirectionRight;
    
    [[self view] addGestureRecognizer:swipeLeft];
    [[self view] addGestureRecognizer:swipeRight];
    
    self.physicsWorld.contactDelegate = self;
    
    hero.physicsBody.categoryBitMask = heroHitCategory;
    hero.physicsBody.contactTestBitMask = enemyHitCategory;
    hero.physicsBody.collisionBitMask =  enemyHitCategory;
    enemyR.physicsBody.categoryBitMask = enemyHitCategory;
    enemyR.physicsBody.contactTestBitMask = heroHitCategory;
    enemyR.physicsBody.collisionBitMask =  heroHitCategory;
    enemyL.physicsBody.categoryBitMask = enemyHitCategory;
    enemyL.physicsBody.contactTestBitMask = enemyHitCategory;
    enemyL.physicsBody.collisionBitMask =  enemyHitCategory;

   }

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
   
    


    
    if (isTouching == YES) {
       
  
    
        
    CGPoint jumpPoint = CGPointMake(hero.position.x+0, hero.position.y + 250);
    
    SKAction *jump = [SKAction moveTo:jumpPoint duration:0.5];
    
    [hero runAction:jump];

            
        
    }
    
    else if (isTouching == NO) {
        
        // Do Nothing!
    }
    

}

-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
    

    
    
    if (CGRectIntersectsRect(hero.frame, landingSpot.frame)) {
        
        isTouching = YES;
        
    }
    
    else if (!CGRectIntersectsRect(hero.frame, landingSpot.frame)) {
        
        isTouching = NO;
        
    }
    
    
}

-(void)spawnHero {
    self.backgroundColor = [SKColor grayColor];
    
    hero = [SKSpriteNode spriteNodeWithImageNamed:@"Hero2"];
    hero.position = CGPointMake(self.frame.size.width/2, self.frame.size.height/2);
    hero.size = CGSizeMake(92, 128);
    hero.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:0.1];
    hero.physicsBody.affectedByGravity = YES;
    hero.physicsBody.mass = 0;
    

    
    [self addChild:hero];
    
    
    landingSpot = [SKSpriteNode node];
    landingSpot.position = CGPointMake(self.frame.size.width/2, self.frame.size.height/2 - 200);
    landingSpot.size = CGSizeMake(self.frame.size.width, 70);
    CGSize size = CGSizeMake(self.frame.size.width, 70);
    
    landingSpot.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:size];
    landingSpot.physicsBody.affectedByGravity = NO;
    landingSpot.physicsBody.mass = 100000000;
    
    landingSpot.physicsBody.resting = YES;
    
    landingSpot.color = [SKColor blueColor];
    
    [self addChild:landingSpot];
    

    
    
}

-(void)spawnEnemyRight {
    
    enemyR = [SKSpriteNode spriteNodeWithImageNamed:@"Monster3"];
    enemyR.position = CGPointMake(0 + 50, self.frame.size.height/2 - 170);
    enemyR.size = CGSizeMake(92, 128);
    enemyR.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:0.1];
    enemyR.physicsBody.affectedByGravity = YES;
    enemyR.physicsBody.mass = 0;
    enemyR.name = @"enemyR";
    
    
    
    [self addChild:enemyR];
    enemyR.alpha = 0.0;

    SKAction *R = [SKAction fadeAlphaTo:1.0 duration:0.7];
    [enemyR runAction:R];
    
    
 
    CGPoint movePointR = CGPointMake(hero.position.x, enemyR.position.y);
    
    SKAction *jumpR = [SKAction moveTo:movePointR duration:speed];
    
    [enemyR runAction:jumpR];

    
   

 
}

-(void)spawnEnemyLeft {
 
    enemyL = [SKSpriteNode spriteNodeWithImageNamed:@"Monster2"];
    enemyL.position = CGPointMake(self.frame.size.width - 50, self.frame.size.height/2 - 170);
    enemyL.size = CGSizeMake(92, 128);
    enemyL.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:0.1];
enemyL.physicsBody.affectedByGravity = YES;
enemyL.physicsBody.mass = 0;
        enemyR.name = @"enemyL";
    
    [self addChild:enemyL];

    CGPoint movePointL = CGPointMake(hero.position.x, enemyL.position.y);
    
    SKAction *jumpL = [SKAction moveTo:movePointL duration:speed];
    
    [enemyL runAction:jumpL];
    
    enemyL.alpha = 0.0;
    
    SKAction *R = [SKAction fadeAlphaTo:1.0 duration:0.7];
    [enemyL runAction:R];

        


}


-(void)slideToLeftWithGestureRecognizer:(UISwipeGestureRecognizer *)gestureRecognizer{
    

        
        [enemyL removeFromParent];
        speed = speed - 0.2;
        

    
    NSLog(@"GotCalled");
    

    
    
    
    
    [self spawnEnemyLeft];
    
}

-(void)slideToRightWithGestureRecognizer:(UISwipeGestureRecognizer *)gestureRecognizer{

    
        [enemyR removeFromParent];
        speed = speed - 0.2;


  
        NSLog(@"GotCalled");
        
    
   
    
   
    
    [self spawnEnemyRight];
    
}



-(void)didBeginContact:(SKPhysicsContact *)contact
{
    SKPhysicsBody *firstBody, *secondBody;
    
    firstBody = contact.bodyA;
    secondBody = contact.bodyB;
    
    if(firstBody.categoryBitMask == enemyHitCategory || secondBody.categoryBitMask == enemyHitCategory)
    {
        

        NSLog(@"You died");
       
        //setup your methods and other things here
        
    }
}


@end

