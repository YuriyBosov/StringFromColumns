//
//  YBStringSeparatorHelperClasses.h
//  push_view_with_animate
//
//  Created by Yuriy Bosov on 6/7/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

//==========================================================================================
// класс содержит отдельное слово и его размер для конкретного шрифта
//==========================================================================================
@interface YBWordWithSize : NSObject {
    NSString *_word;
    CGSize _sizeWord;
}

@property (nonatomic,retain) NSString *word;
@property (nonatomic, readonly) CGSize sizeWord;

- (id)initWithWord:(NSString *)word forFonr:(UIFont*)font;
- (void)calculateSizeForFont:(UIFont*)font;
- (float)heigth;
- (float)width;

@end
//==========================================================================================