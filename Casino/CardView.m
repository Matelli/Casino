//
//  CardView.m
//  Blackjack
//
//  Created by Jonathan Schmidt on 10/03/2014.
//  Copyright (c) 2014 Matelli. All rights reserved.
//

#import "CardView.h"

@implementation CardView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(void)flipCardAnimated
{
    [self flipCardAnimatedWithCompletion:nil];
}

-(void)flipCardAnimatedWithCompletion:(void (^)(BOOL finished))completion
{
    [UIView transitionWithView:self
                      duration:0.5
                       options:UIViewAnimationOptionTransitionFlipFromLeft
                    animations:^{
                        if (self.isDisplayingValue)
                        {
                            [self displayCover];
                        }
                        else
                        {
                            [self displayValue];
                        }
                    } completion:completion];
}

-(void)displayValue
{
    self.image = self.cardValueImage;
    self.contentMode = UIViewContentModeScaleAspectFit;
    _isDisplayingValue = YES;
}

-(void)displayCover
{
    self.image = self.cardCoverImage;
    self.contentMode = UIViewContentModeScaleAspectFit;
    _isDisplayingValue = NO;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
