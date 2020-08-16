//
//  GameView.h
//  XSEatSnake
//
//  Created by lijifeng on 2020/8/16.
//  Copyright © 2020 Musk Ronaldo Ming. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Snake;

NS_ASSUME_NONNULL_BEGIN

@interface GameView : UIView

/** 蛇🐍 */
@property (strong, nonatomic) Snake *snake;

@end

NS_ASSUME_NONNULL_END
