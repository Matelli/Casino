//
//  CardView.h
//  Blackjack
//
//  Created by Jonathan Schmidt on 10/03/2014.
//  Copyright (c) 2014 Matelli. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CardView : UIImageView

@property (readwrite, strong, nonatomic) UIImage * cardValueImage;
@property (readwrite, strong, nonatomic) UIImage * cardCoverImage;
@property (readonly, assign, nonatomic) BOOL isDisplayingValue;

-(void)flipCardAnimated;
-(void)flipCardAnimatedWithCompletion:(void (^)(BOOL finished))completion;
-(void)displayValue;
-(void)displayCover;

@end
