    //
//  RootController.m
//  push_view_with_animate
//
//  Created by Yuriy Bosov on 18.05.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "RootController.h"
#import "YBStringSeparator.h"

@implementation RootController

#pragma mark -
#pragma mark View Lister

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
		self.navigationItem.title = @"Root";
        self.view.backgroundColor = [UIColor lightGrayColor];
    }
    return self;
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [self testStringSeparator];
    [super viewDidLoad];
}

// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    //return (interfaceOrientation == UIInterfaceOrientationPortrait);
	return YES;
}

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
}

- (void)viewDidUnload {
    [super viewDidUnload];

}

- (void)dealloc {
    [super dealloc];
}

- (void)testStringSeparator
{
    NSString *str = [NSString stringWithUTF8String: "The objects you create using NSString and NSMutableString are referred to as string objects (or, when no confusion will result, merely as strings). The term C string refers to the standard char * type. Because of the nature of class clusters, string objects aren’t actual instances of the NSString or NSMutableString classes but of one of their private subclasses. Although a string object’s class is private, its interface is public, as declared by these abstract superclasses, NSString and NSMutableString. The string classes adopt the NSCopying and NSMutableCopying protocols, making it convenient to convert a string of one type to the other.The objects you create using NSString and NSMutableString are referred to as string objects (or, when no confusion will result, merely as strings). The term C string refers to the standard char * type. Because of the nature of class clusters, string objects aren’t actual instances of the NSString or NSMutableString classes but of one of their private subclasses. Although a string object’s class is private, its interface is public, as declared by these abstract superclasses, NSString and NSMutableString. The string classes adopt the NSCopying and NSMutableCopying protocols, making it convenient to convert a string of one type to the other.instances of the NSString or NSMutableString classes but of one of their private subclasses. Although a string object’s class is private, its interface is public, as declared by these abstract superclasses, NSString and NSMutableString. The string classes adopt the NSCopying and NSMutableCopying protocols, making it convenient to convert a string of one type"];
    
    UIScrollView *contentView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    contentView.contentSize = CGSizeMake(0,0);
    [self.view addSubview:contentView];
    
    // size column
    CGSize size = CGSizeMake(self.view.frame.size.width - 100, 500);
    
    YBStringSeparator *separator = [YBStringSeparator separatorWithText:str
                                                               font:[UIFont systemFontOfSize:40] 
                                                              width:size.width 
                                                             heigth:size.height];
    NSArray *labelarray = [[separator getLabelWithSubString] retain];
    
    float delta_pos = 50.f;
    float x_pos =  delta_pos + size.width/2;
    float y_pos = 0;
    
    for (int i = 0; i < [labelarray count]; i++) {
        UILabel *label = [labelarray objectAtIndex:i];
        [contentView addSubview:label];
        
        y_pos += label.frame.size.height/2 + delta_pos;
        
        label.backgroundColor = [UIColor redColor];
        label.center = CGPointMake(x_pos,y_pos);
        
        y_pos += label.frame.size.height/2;
        
        contentView.contentSize = CGSizeMake(contentView.frame.size.width,y_pos);
    }
    
    contentView.contentSize = CGSizeMake(contentView.frame.size.width,
                                         contentView.contentSize.height + delta_pos);
    
    [labelarray release];
    [contentView release];
}


@end
