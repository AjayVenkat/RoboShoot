//
//  GameScene.h
//  RoboShoot
//

//  Copyright (c) 2015 AJTech. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface GameScene : SKScene <SKPhysicsContactDelegate>

-(void)spawnHero;
-(void)spawnEnemyLeft;
-(void)spawnEnemyRight;
-(void)slideToRightWithGestureRecognizer:(UISwipeGestureRecognizer *)gestureRecognizer;

-(void)slideToLeftWithGestureRecognizer:(UISwipeGestureRecognizer *)gestureRecognizer;

@end
