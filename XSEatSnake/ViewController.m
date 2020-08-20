//
//  ViewController.m
//  XSEatSnake
//
//  Created by lijifeng on 2020/8/13.
//  Copyright © 2020 Musk Ronaldo Ming. All rights reserved.
//

#import "ViewController.h"
#import "GameView.h"
#import "Snake.h"

#define KSCREENWIDTH [UIScreen mainScreen].bounds.size.width  //屏宽
#define KSCREENHEIGHT [UIScreen mainScreen].bounds.size.height  //屏高
#define LEVELCOUNT 3  //满多少分升1级
#define MAXLEVEL 9   //最高多多少级

@interface ViewController ()
@property (weak, nonatomic) IBOutlet GameView *gameView;
@property (strong, nonatomic) Snake *snake;
@property (strong, nonatomic) UILabel *food;
@property (weak, nonatomic) IBOutlet UIButton *startBtn;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *levelLabel;
@property (assign, nonatomic) BOOL isGameOver;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.snake = [Snake snake];
    __weak typeof(self) weakSelf = self;
    _snake.moveFinishBlock = ^{
        [weakSelf isEatdFood];
        [weakSelf isDestory];
        [weakSelf.gameView setNeedsDisplay];
    };
    _gameView.snake = _snake;
    [self createFood];
}

- (void)createFood{
    
    int horizontalCount = (KSCREENWIDTH - 120) / NODEWIDTH;
    int verticalCount = 480 / NODEWIDTH;
    int centerX = (arc4random() % horizontalCount) * NODEWIDTH + NODEWIDTH * 0.5;
    int centerY = (arc4random() % verticalCount) * NODEWIDTH + NODEWIDTH * 0.5;
    CGPoint center = CGPointMake(centerX, centerY);
    for (Node *node in _snake.nodes) {
        if (CGPointEqualToPoint(node.coordinate, center)) {
            [self createFood];
            return;
        }
    }
    self.food.center = center;
}

- (void)isEatdFood{
    if (CGPointEqualToPoint(_food.center, _snake.nodes.firstObject.coordinate)) {
        NSInteger score = _scoreLabel.text.integerValue + 1;
        _scoreLabel.text = [NSString stringWithFormat:@"%ld",score];
        if (score <= LEVELCOUNT * MAXLEVEL && (score % LEVELCOUNT == 0)) {
            NSInteger level = score / LEVELCOUNT;
            _levelLabel.text = [NSString stringWithFormat:@"%ld",level];
            [_snake levelUpWithSpeed:level];
        }
        [self createFood];
        [_snake growUp];
    }
}

- (void)isDestory{
    Node *headNode = _snake.nodes.firstObject;
    for (int i = 1; i < _snake.nodes.count; i ++) {
        Node *node = _snake.nodes[i];
        if (CGPointEqualToPoint(node.coordinate, headNode.coordinate)) {
            [self gameOver];
        }
    }
    if (headNode.coordinate.x < NODEWIDTH / 2 || headNode.coordinate.x > KSCREENWIDTH - 60 * 2 - NODEWIDTH / 2) {
        [self gameOver];
    }
    if (headNode.coordinate.y < NODEWIDTH / 2 || headNode.coordinate.y > 480 - NODEWIDTH / 2) {
        [self gameOver];
    }
}

- (void)gameOver{
    [_snake pause];
    NSString *message = [NSString stringWithFormat:@"总得分为：%@",_scoreLabel.text];
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"干得漂亮" message:message preferredStyle:UIAlertControllerStyleAlert];
    __weak typeof(self) weakSelf = self;
    UIAlertAction *sureAction = [UIAlertAction actionWithTitle:@"重来一局" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        weakSelf.scoreLabel.text = @"0";
        weakSelf.levelLabel.text = @"0";
        [weakSelf createFood];
        [weakSelf.snake reset];
    }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        weakSelf.startBtn.selected = NO;
        weakSelf.isGameOver = YES;
    }];
    [alertVC addAction:sureAction];
    [alertVC addAction:cancelAction];
    [self presentViewController:alertVC animated:YES completion:nil];
}

- (IBAction)buttonClick:(UIButton *)sender {
    if (_startBtn.selected) {
        self.snake.direction = (MoveDirection)sender.tag - 100;
    }
}

- (IBAction)startAndPause:(UIButton *)sender {
    if (sender.selected) {
        [_snake pause];
    } else {
        if(_isGameOver){
            _scoreLabel.text = @"0";
            _levelLabel.text = @"0";
            [_snake reset];
            _isGameOver = NO;
        }else{
            [_snake start];
        }
    }
    sender.selected = !sender.selected;
}

- (UILabel *)food{
    if (!_food) {
        _food = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, NODEWIDTH, NODEWIDTH)];
        _food.font = [UIFont systemFontOfSize:14];
        _food.text = @"🍎";
        [_gameView addSubview:_food];
    }
    return _food;
}


- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

@end
