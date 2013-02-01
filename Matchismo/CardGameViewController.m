//
//  CardGameViewController.m
//  Matchismo
//
//  Created by Jim Ford on 1/26/13.
//  Copyright (c) 2013 Venerable, Inc. All rights reserved.
//

#import "CardGameViewController.h"
#import "PlayingCardDeck.h"

@interface CardGameViewController ()
@property (weak, nonatomic) IBOutlet UILabel *flipsLabel;
@property (nonatomic) int flipCount;
@property (strong, nonatomic) PlayingCardDeck *deck;
@end

@implementation CardGameViewController

- (PlayingCardDeck *)deck
{
    if (!_deck) _deck = [[PlayingCardDeck alloc]init];
    return _deck;
}

- (void)setFlipCount:(int)flipCount
{
    _flipCount = flipCount;
    self.flipsLabel.text = [NSString stringWithFormat:@"Flips: %d", self.flipCount];
}

- (IBAction)flipCard:(UIButton *)sender
{
    
    sender.selected = !sender.isSelected;
    if (sender.isSelected) {
        Card *currentCard = self.deck.drawRandomCard;        NSString *currentContents;
        
        if (currentCard) {
            currentContents = currentCard.contents;
        } else {
            currentContents = @"🇺🇸";
        }
        
        [sender setTitle:currentContents forState:UIControlStateSelected];
    }
    
    self.flipCount++;
}

@end
