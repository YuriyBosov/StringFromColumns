//
//  YBStringSeparatorHelperClasses.m
//  push_view_with_animate
//
//  Created by Yuriy Bosov on 6/7/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "YBStringSeparatorHelperClasses.h"

//==========================================================================================
// класс содержит отдельное слово и его размер для конкретного шрифта
//==========================================================================================
@implementation YBWordWithSize

@synthesize word        = _word;
@synthesize sizeWord    = _sizeWord;

//==========================================================================================
- (id)initWithWord:(NSString *)word forFonr:(UIFont*)font{
    self = [super init];
    if (self) {
        self.word = word;
        [self calculateSizeForFont:font];
    }
    return self;
}
//==========================================================================================
- (void)calculateSizeForFont:(UIFont*)font{
    _sizeWord = [_word sizeWithFont:font];
}
//==========================================================================================
- (float)heigth{ return _sizeWord.height; }
//==========================================================================================
- (float)width{ return  _sizeWord.width; }
//==========================================================================================
- (void)dealloc
{
    [_word release];
    [super dealloc];
}
@end
//==========================================================================================