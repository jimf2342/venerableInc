//
//  PlayingCard.h
//  Matchismo
//
//  Created by Jim Ford on 1/26/13.
//  Copyright (c) 2013 Venerable, Inc. All rights reserved.
//

#import "Card.h"

@interface PlayingCard : Card

@property (strong, nonatomic) NSString *suit;
@property (nonatomic) NSUInteger rank;

+ (NSArray *)validSuits;
+ (NSUInteger)maxRank;

@end
