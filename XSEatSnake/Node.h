//
//  Node.h
//  XSEatSnake
//
//  Created by lijifeng on 2020/8/16.
//  Copyright © 2020 Musk Ronaldo Ming. All rights reserved.
//

#import <UIKit/UIKit.h>

#define NODEWIDTH 20

NS_ASSUME_NONNULL_BEGIN

@interface Node : NSObject

/** 节点的中心点 */
@property (assign, nonatomic) CGPoint coordinate;

/** 通过位置创建节点 */
+ (instancetype)nodeWithCoodinate:(CGPoint)coordinate;

@end

NS_ASSUME_NONNULL_END
