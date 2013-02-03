//
//  CardMatchingGame.h
//  Matchismo
//
//  Created by Jim Ford on 2/2/13.
//  Copyright (c) 2013 Venerable, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Deck.h"

@interface CardMatchingGame : NSObject

- (id)initWithCardCount:(NSUInteger)cardCount usingDeck:(Deck *)deck;
- (void)flipCardAtIndex:(NSUInteger)index;
- (Card *)cardAtIndex:(NSUInteger)index;

@property (nonatomic, readonly) int score;
@property (nonatomic, readonly) NSString *matchMessage;


@end
