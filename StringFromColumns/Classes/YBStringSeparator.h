//
//  YBStringSeparator.h
//  push_view_with_animate
//
//  Created by Yuriy Bosov on 6/7/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YBStringSeparator : NSObject {
    NSString *_textContent; // текст, котороый необходимо будет разбить на колонки
    UIFont *_fontContent;   // шрифт, котрорый будет использыватся
    float _widthCollums;    // ширина одной колонки
    float _heigthCollums;   // высота одной колонки
    
    NSMutableArray *_substrings;
    NSMutableArray *_wordList;
}

@property (nonatomic, retain) NSString *textContent;
@property (nonatomic, retain) UIFont *fontContent;
@property (nonatomic, assign) float widthCollums;
@property (nonatomic, assign) float heigthCollums;

+ (id)separatorWithText:(NSString*)textContent 
                   font:(UIFont*)fontContent 
                  width:(float)widthCollums 
                 heigth:(float)heigthCollums;

- (id)initWithText:(NSString*)textContent 
              font:(UIFont*)fontContent 
             width:(float)widthCollums 
            heigth:(float)heigthCollums;

- (NSArray *)getSubStrings;
- (NSArray *)getLabelWithSubString;

@end
