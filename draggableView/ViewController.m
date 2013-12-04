//
//  ViewController.m
//  draggableView
//
//  Created by coolbeet on 7/18/13.
//  Copyright (c) 2013 suyu zhang. All rights reserved.

//  Modified by Mimee Xu (@NorthStar) on 12/02/13.


#import "ViewController.h"
#import "DraggableView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    /*\FIXME:Make this a truly mutable array
     *       by loading from data 
     * \TODO: do not hard code this
     */
    self.photos = [NSMutableArray arrayWithObjects: @"fay.jpg", @"coolbeet.jpg", @"suyu.jpg", nil];
    
    /*  Perhaps we could put in four at a time?
     * \TODO: init the photos either in cells
     *       or in scattered positions.
     */
    
    /* \TODO: factor this out for general use*/
    self.tempArray = [[NSMutableArray alloc] init];
    
    NSInteger i = 0;
    for (NSString* currentString in self.photos)
    {
        DraggableView *tempView = [[DraggableView alloc] initWithFrame:CGRectMake(160-100 - 5*i, 120+10*i, 200, 200) image:[UIImage  imageNamed:currentString]];
        [self.tempArray addObject:tempView];
        i = i +1;
    }
    //reverse the tempArray
    self.tempArray = [[self.tempArray reverseObjectEnumerator] allObjects];
    //add to view "backwards"
    for (DraggableView* imageView in self.tempArray)
    {
        [self.view addSubview: imageView];
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
