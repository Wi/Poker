//
//  ZwHandCardsView.h
//  BzpPoker
//
//  Created by DengZw on 16/9/8.
//  Copyright © 2016年 ALonelyEgg.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZwCardView.h"

#define kHandCardsViewDiscardAnimationTime 0.35f

#define kCardViewSizeHeight 59.0f
#define kCardViewSpaceWidth 20.0f
#define kCardViewSizeWidth 44.0f

// 出牌中的Block
typedef void(^HandCardsViewDiscardBlock)(NSMutableArray *cardsViewArray, NSMutableArray *cardsModelArray);

// 判断是否正确牌型的block
typedef void(^HandCardsViewCheckRightCardTypeBlock)(BOOL isRight);

@interface ZwHandCardsView : UIView

@property (nonatomic, strong) NSMutableArray *cardsArray; /**< 手牌数组 */

- (instancetype)initWithFrame:(CGRect)frame cards:(NSArray *)cards;

// 设置牌型判断Block
- (void)setCheckCardTypeBlock:(HandCardsViewCheckRightCardTypeBlock)checkCardTypeBlock;

// 设置手牌
- (void)setCards:(NSArray *)cards;

// 出牌
- (void)discardByBlock:(HandCardsViewDiscardBlock)block;

// 过牌
- (void)pass;

@end