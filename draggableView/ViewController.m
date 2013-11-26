//
//  ViewController.m
//  draggableView
//
//  Created by coolbeet on 7/18/13.
//  Copyright (c) 2013 suyu zhang. All rights reserved.
//

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
    
    
    /* Requires photos to be put in backwards,
     * sort of. Perhaps we could put in four at a time?
     * \TODO: init the photos either in cells
     *       or in scattered positions.
     */
    for (NSString* currentString in self.photos)
    {
        DraggableView *tempView = [[DraggableView alloc] initWithFrame:CGRectMake(160-100, 120, 200, 200) image:[UIImage  imageNamed:currentString]];
        [self.view addSubview:tempView];
        
    }
/*
    DraggableView *dView1 = [[DraggableView alloc] initWithFrame:CGRectMake(160-100, 120, 200, 200) image:[UIImage  imageNamed:@"fay.jpg"]];
    DraggableView *dView2 = [[DraggableView alloc] initWithFrame:CGRectMake(160-100, 120, 200, 200) image:[UIImage  imageNamed:@"suyu.jpg"]];
    DraggableView *dView3 = [[DraggableView alloc] initWithFrame:CGRectMake(160-100, 120, 200, 200) image:[UIImage  imageNamed:@"coolbeet.jpg"]];

    [self.view addSubview:dView3];
    [self.view addSubview:dView2];
    [self.view addSubview:dView1];
*/
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
