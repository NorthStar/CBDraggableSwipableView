//
//  DraggableView.m
//  draggableView
//
//  Created by coolbeet on 7/18/13.
//  Copyright (c) 2013 suyu zhang. All rights reserved.
//

#import "DraggableView.h"

@implementation DraggableView

@synthesize imageView, yesLabel, noLabel;

//- (id)initWithFrame:(CGRect)frame
//{
//    self = [super initWithFrame:frame];
//    if (self) {
//        // Initialization code
//    }
//    return self;
//}

- (id)initWithFrame:(CGRect)frame image:(UIImage*)aImage
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code

        self.imageView = [[UIImageView alloc] initWithImage:aImage];        
        imageView.frame = CGRectMake(0, 0, frame.size.width, frame.size.height);
        [self addSubview:imageView];
        
        self.noLabel = [[UILabel alloc] initWithFrame:CGRectMake(frame.size.width-180, 0, 180, 150)];
        noLabel.text = @"X";
        noLabel.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:188];
        noLabel.textAlignment = NSTextAlignmentCenter;
        noLabel.backgroundColor = [UIColor clearColor];
        noLabel.textColor = [UIColor redColor];
        noLabel.alpha = 0.0f;
        [self addSubview:noLabel];
        
        self.yesLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 180, 150)];
        yesLabel.text = @"OK!";
        yesLabel.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:76];
        yesLabel.textAlignment = NSTextAlignmentCenter;
        yesLabel.backgroundColor = [UIColor clearColor];
        yesLabel.textColor = [UIColor orangeColor];
        yesLabel.alpha = 0.0f;
        [self addSubview:yesLabel];
        
        //add gestureRecogniser
        UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageTaped:)];
        singleTap.numberOfTapsRequired = 1;
        singleTap.numberOfTouchesRequired = 1;
        [self addGestureRecognizer:singleTap];
        [self setUserInteractionEnabled:YES];
    }
    return self;
}

//The clicked photo shows on top layer
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *aTouch = [touches anyObject];
    offset = [aTouch locationInView: self];
    
    //bring me to top 
    [self.superview bringSubviewToFront:self];
}


- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    
    UITouch *aTouch = [touches anyObject];
    CGPoint location = [aTouch locationInView:self.superview];
    
    CGPoint temp = CGPointMake(location.x - offset.x + 100, location.y - offset.y + 100);
    
    [UIView beginAnimations:@"Dragging A DraggableView" context:nil];
    self.center = temp;
    [UIView commitAnimations];
    
    //swipe right
    if (self.center.x >= 160) {
        //rotation
        [self setTransform:CGAffineTransformMakeRotation(((self.center.x - 160.0f)/160.0f) * (M_PI/5))];
        
        //labels
        //change opacity as centre changes
        yesLabel.alpha = (self.center.x - 160.0f)/160.0f;
        noLabel.alpha = 0.0f;
        
        //I want this to be the saved one
        //TODO: I dunno, just make it do more stuff

    }
    //swipe left
    else {
        //rotation
        [self setTransform:CGAffineTransformMakeRotation((self.center.x - 160.0f)/160.0f * (M_PI/5))];
        
        //labels
        noLabel.alpha = (160.0f - self.center.x)/160.0f;
        yesLabel.alpha = 0.0f;
        
        //i want the "X"-ed images to disappear
        //rotation that marked abandonment
        //TODO: Make sure this feels alright
        // would minimizing the image feel better?
        [self setTransform:CGAffineTransformMakeRotation(((self.center.x - 160.0f)/160.0f) * (2* M_PI/5))];
        // disappear by fading
        self.alpha = ((self.center.x-10)/160.0f);
        
    }
    
}

//When tapped, show info
- (void)imageTaped:(UIGestureRecognizer *)gestureRecognizer {
    //image will only respond if it does not have a "X" label
    if (self.noLabel.alpha < 0.1f) {
        [UIView animateWithDuration:0.5 animations:^(void){
            imageView.alpha = 0.4f;
            //TODO: find a better font.
            yesLabel.font = [UIFont fontWithName:@"ArialRoundedMT" size:22];
            yesLabel.textColor = [UIColor whiteColor];
            
            //TODO: Fetch restaurant info
            self.yesLabel.text = @"restaurant info";
            self.yesLabel.alpha = 1.0f;
        }];
    }
}

@end
