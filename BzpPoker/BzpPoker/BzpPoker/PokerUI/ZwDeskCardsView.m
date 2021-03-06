//
//  ZwDeskCardsView.m
//  BzpPoker
//
//  Created by DengZw on 16/9/8.
//  Copyright © 2016年 ALonelyEgg.com. All rights reserved.
//

#import "ZwDeskCardsView.h"
#import "ZwCardView.h"

@interface ZwDeskCardsView ()

@property (nonatomic, assign) ZwDeskCardsViewAlignment alignment; /**< 对齐方式 */

@end

@implementation ZwDeskCardsView

- (instancetype)initWithFrame:(CGRect)frame alignment:(ZwDeskCardsViewAlignment)alignment
{
    if (self = [super initWithFrame:frame])
    {
        // 发牌
        self.alignment = alignment;
        [self createUIView];
        self.cardsArray = [[NSMutableArray alloc] init];
    }
    
    return self;
}

- (void)createUIView
{
    [UIView animateWithDuration:0.1 animations:^{
        [self createUIViewByHideLastArrayCards:NO];
    }];
}

- (void)createUIViewByHideLastArrayCards:(BOOL)hidden
{
    // 创建时，先移除旧的视图
    if (self.subviews)
    {
        for (UIView *view in self.subviews)
        {
            [view removeFromSuperview];
        }
    }
    
    CGFloat totoalWidth = kDeskCardViewSizeWidth;
    
    for(int x = 0; x < self.cardsArray.count; x ++)
    {
        NSArray *array = self.cardsArray[x];
        
        // 每手牌的宽度
        CGFloat oneCardsWidth = kDeskCardViewSpaceWidth * (array.count - 1);
        totoalWidth += oneCardsWidth;
        
        if (x != self.cardsArray.count - 1)
        {
            // 添加每手牌之间的距离
            totoalWidth += kDeskCardsViewSpaceWidth;
        }
    }
    
    CGFloat orignX = 0.0f;
    switch (self.alignment)
    {
        case ZwDeskCardsViewAlignmentCenter:
            orignX = (self.bounds.size.width - totoalWidth)/2;
            break;
        case ZwDeskCardsViewAlignmentLeft:
            orignX = 0;
            break;
        case ZwDeskCardsViewAlignmentRight:
            orignX = self.bounds.size.width - totoalWidth;
            break;
            
        default:
            break;
    }
    for (int x = 0; x < self.cardsArray.count; x ++)
    {
        NSArray *array = self.cardsArray[x];
        
        for (int y = 0; y < array.count; y ++)
        {
            CardModel *model = array[y];
            ZwCardView *card = [[ZwCardView alloc] initWithFrame:CGRectMake(orignX, 0, kDeskCardViewSizeWidth, kDeskCardViewSizeHeight) cardModel:model];
            [self addSubview:card];
            
            if (x == self.cardsArray.count - 1 && hidden)
            {
                card.hidden = YES;
            }
            
            if (y != array.count - 1)
            {
                // 每张牌之间的距离
                orignX += kDeskCardViewSpaceWidth;
            }
        }
        
        // 添加每手牌之间的距离
        orignX += kDeskCardsViewSpaceWidth;
    }
}

- (void)addCards:(NSArray *)cards
{
    [self.cardsArray addObject:cards];
    [self createUIViewByHideLastArrayCards:YES];
}

- (void)discardFinished
{
    [self createUIView];
}

- (void)finishedOneRound
{
    [self.cardsArray removeAllObjects];
    [self createUIView];
}

@end
