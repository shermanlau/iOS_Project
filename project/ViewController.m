//
//  ViewController.m
//  project
//
//  Created by abc on 7/3/2014.
//  Copyright (c) 2014 ___FULLUSERNAME___. All rights reserved.
//

#import "ViewController.h"

//@interface ViewController ()

//@end

@implementation ViewController
@synthesize scrollImages;
@synthesize intro;
@synthesize pagecontrol;
@synthesize imagesBack;

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

- (void)viewDidLoad
{
    
    [super viewDidLoad];
    
    index = 0;
    data = [[NSArray alloc] initWithObjects:@"1.jpg",@"2.jpg",@"3.jpg",@"4.jpg",@"5.jpg",@"6.jpg", nil];
    imageviews = [[NSMutableArray alloc] initWithCapacity:6];
    self.scrollImages.delegate = self;
    self.scrollImages.pagingEnabled = YES;
    self.scrollImages.showsHorizontalScrollIndicator = NO;
    CGSize size = scrollImages.frame.size;
    for (int i=0; i < [data count]; i++) {
        UIImageView *iv = [[UIImageView alloc] initWithFrame:CGRectMake(size.width * i, 0, size.width, size.height)];
        [iv setImage:[UIImage imageNamed:[data objectAtIndex:i]]];
        [self.scrollImages addSubview:iv];
        iv = nil;
    }
    [self.scrollImages setContentSize:CGSizeMake(size.width * 6, size.height)];
	for (int i=0; i<6; i++) {
        int row = i/3;
        UIImageView *iv = [[UIImageView alloc] initWithFrame:CGRectMake(100*(i%3)+5*(i%3+1), (70+5) * row, 100, 70)];
        [iv setImage:[UIImage imageNamed:[data objectAtIndex:i]]];
        [self.imagesBack addSubview:iv];
        [imageviews addObject:iv];
        iv = nil;
    }
    pf = [[PicFrame alloc] initWithFrame:((UIImageView*)[imageviews objectAtIndex:index]).frame];
    NSLog(@"frame:%f,%f,%f,%f",pf.frame.size.width,pf.frame.size.height,pf.frame.origin.x,pf.frame.origin.y);
    [self.imagesBack addSubview:pf];
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap:)];
    [singleTap setNumberOfTapsRequired:1];
    
    [self.scrollImages addGestureRecognizer:singleTap];
    
    UITapGestureRecognizer *smallImageTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleImageTap:)];
    [smallImageTap setNumberOfTapsRequired:1];
    [self.imagesBack addGestureRecognizer:smallImageTap];
    
    
}

- (void)viewDidUnload
{
    [self setScrollImages:nil];
    [self setIntro:nil];
    [self setPagecontrol:nil];
    [self setImagesBack:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

#pragma mark-- UIScrollViewDelegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (pageControlUsed) {
        return;
    }
    CGFloat pageWidth = scrollView.frame.size.width;
    int page = floor((scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    pagecontrol.currentPage = page;
    index = page;
    
}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    pageControlUsed = NO;
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    pageControlUsed = NO;
    pf.frame = ((UIImageView*)[imageviews objectAtIndex:index]).frame;
    [pf setAlpha:0];
    [UIView animateWithDuration:0.2f animations:^(void){
        [pf setAlpha:.85f];
    }];
}
- (IBAction)chagepage:(id)sender {
    int page = pagecontrol.currentPage;
    index = page;
	
    CGRect frame = scrollImages.frame;
    frame.origin.x = frame.size.width * page;
    frame.origin.y = 0;
    [scrollImages scrollRectToVisible:frame animated:YES];
    
    pageControlUsed = YES;
    pf.frame = ((UIImageView*)[imageviews objectAtIndex:index]).frame;
    [pf setAlpha:0];
    [UIView animateWithDuration:0.2f animations:^(void){
        [pf setAlpha:.85f];
    }];
    
}
- (void) handleSingleTap:(UITapGestureRecognizer *) gestureRecognizer{
    CGFloat pageWith = 320;
    
    CGPoint loc = [gestureRecognizer locationInView:scrollImages];
    NSInteger touchIndex = floor(loc.x / pageWith) ;
    if (touchIndex > 5) {
        return;
    }
    NSLog(@"touch index %d",touchIndex);
}
- (void) handleImageTap:(UITapGestureRecognizer *) gestureRecognizer{
    CGFloat rowHeight = 75;
    CGFloat columeWith = 100;
    CGFloat gap = 5;
    
    CGPoint loc = [gestureRecognizer locationInView:imagesBack];
    NSInteger touchIndex = floor(loc.x / (columeWith + gap)) + 3 * floor(loc.y / (rowHeight + gap)) ;
    if (touchIndex > 5) {
        return;
    }
    index = touchIndex;
    pagecontrol.currentPage = index;
    CGRect frame = scrollImages.frame;
    frame.origin.x = frame.size.width * touchIndex;
    frame.origin.y = 0;
    [scrollImages scrollRectToVisible:frame animated:NO];
    
    pageControlUsed = YES;
    pf.frame = ((UIImageView*)[imageviews objectAtIndex:index]).frame;
    [pf setAlpha:0];
    [UIView animateWithDuration:0.2f animations:^(void){
        [pf setAlpha:.85f];
    }];
    NSLog(@"small image touch index %d",touchIndex);
}

@end
