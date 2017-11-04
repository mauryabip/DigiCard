//
//  CardView.m
//  Digi Card
//
//  Created by umenit on 11/4/17.
//
//

#import "CardView.h"


static CGFloat radius = 2;

static int shadowOffsetWidth = 0;
static int shadowOffsetHeight = 3;
static float shadowOpacity = 0.5;

@implementation CardView


-(void)layoutSubviews{
    self.layer.cornerRadius = radius;
    UIBezierPath *shadowPath = [UIBezierPath
                                bezierPathWithRoundedRect: self.bounds
                                cornerRadius: radius];
    
    
    self.layer.masksToBounds = false;
    self.layer.shadowColor = [UIColor blackColor].CGColor;
    self.layer.shadowOffset = CGSizeMake(shadowOffsetWidth, shadowOffsetHeight);
    self.layer.shadowOpacity = shadowOpacity;
    self.layer.shadowPath = shadowPath.CGPath;
}

-(id)initWithCoder:(NSCoder *)aDecoder{
    return [super initWithCoder:aDecoder];
}

@end
