//
//  Snake.h
//  XSEatSnake
//
//  Created by lijifeng on 2020/8/16.
//  Copyright © 2020 Musk Ronaldo Ming. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Node.h"

typedef NS_ENUM(NSInteger, MoveDirection){
    MoveDirectionUp,
    MoveDirectionLeft,
    MoveDirectionDown,
    MoveDirectionRight
};

NS_ASSUME_NONNULL_BEGIN

@interface Snake : NSObject

/** 身上所有节点 */
@property (strong, nonatomic) NSMutableArray <Node *> *nodes;
/** 移动的方向 */
@property (assign, nonatomic) MoveDirection direction;
/** 每走一步的回调 */
@property (copy, nonatomic) void (^moveFinishBlock)(void);

+ (instancetype)snake;
- (void)start;
- (void)pause;
- (void)growUp;
- (void)reset;
- (void)levelUpWithSpeed:(NSInteger)speed;

@end

NS_ASSUME_NONNULL_END
