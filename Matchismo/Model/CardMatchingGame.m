//
//  CardMatchingGame.m
//  Matchismo
//
//  Created by Jim Ford on 2/2/13.
//  Copyright (c) 2013 Venerable, Inc. All rights reserved.
//

#import "CardMatchingGame.h"

@interface CardMatchingGame()
@property (strong, nonatomic) NSMutableArray *cards;
@property (nonatomic) int score;
@property (strong, nonatomic) NSString *matchMessage;
@end

@implementation CardMatchingGame

- (NSMutableArray *)cards {
    if (!_cards) _cards = [[NSMutableArray alloc] init];
    return _cards;
}

- (id)initWithCardCount:(NSUInteger)cardCount usingDeck:(Deck *)deck {
    self = [super init];
    
    if (self) {
        for (int i=0;i<cardCount;i++) {
            Card *card = deck.drawRandomCard;
            if (!card) {
                self = nil;
            } else {
                self.cards[i] = card;
            }
        }
    }
    
    return self;
}

- (Card *)cardAtIndex:(NSUInteger)index {
    return (index < self.cards.count) ? self.cards[index] : nil;
}

#define FLIP_COST 1
#define MESSAGE_FLIPPED @"Flipped up %@"
#define MISMATCH_PENALTY 2
#define MESSAGE_MISMATCHED @"%@ & %@ don't match! %d point penalty!"
#define MATCH_BONUS 4
#define MESSAGE_MATCHED @"Matched %@ & %@ for %d points!"

- (void)flipCardAtIndex:(NSUInteger)index {
    Card *card = [self cardAtIndex:index];
    self.matchMessage = nil;
    
    if (!card.isUnplayable) {
        if (!card.isFaceUp) {
            for (Card *otherCard in self.cards) {
                if (otherCard.isFaceUp && !otherCard.isUnplayable) {
                    int matchScore = [card match:@[otherCard]];
                    if (matchScore) {
                        otherCard.unplayable = YES;
                        card.unplayable = YES;
                        self.score += matchScore * MATCH_BONUS;
                        self.matchMessage = [NSString stringWithFormat:MESSAGE_MATCHED, card.contents, otherCard.contents, matchScore * MATCH_BONUS];
                    } else {
                        otherCard.faceUp = NO;
                        self.score -= MISMATCH_PENALTY;
                        self.matchMessage = [NSString stringWithFormat:MESSAGE_MISMATCHED, card.contents, otherCard.contents, MISMATCH_PENALTY];
                    }
                    break;
                }
            }
            self.score -= FLIP_COST;
            if (self.matchMessage == nil) {
                self.matchMessage = [NSString stringWithFormat:MESSAGE_FLIPPED, card.contents];
            }
        }
    }

    card.faceUp = !card.isFaceUp;
}

@end
