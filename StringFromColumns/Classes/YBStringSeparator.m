//
//  YBStringSeparator.m
//  push_view_with_animate
//
//  Created by Yuriy Bosov on 6/7/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "YBStringSeparator.h"
#import "YBStringSeparatorHelperClasses.h"
//==========================================================================================
// private
//==========================================================================================
@interface YBStringSeparator (Private)
- (void)calculation;
- (NSMutableArray*)parsingTextContent;
@end

//==========================================================================================
// public
//==========================================================================================
@implementation YBStringSeparator
//==========================================================================================
@synthesize textContent     = _textContent;
@synthesize fontContent     = _fontContent;
@synthesize widthCollums    = _widthCollums;
@synthesize heigthCollums   = _heigthCollums;
//==========================================================================================
+ (id)separatorWithText:(NSString*)textContent 
                   font:(UIFont*)fontContent 
                  width:(float)widthCollums 
                 heigth:(float)heigthCollums
{
    return [[[self alloc] initWithText:textContent font:fontContent width:widthCollums heigth:heigthCollums] autorelease];
}
//==========================================================================================
- (id)initWithText:(NSString*)textContent 
              font:(UIFont*)fontContent 
             width:(float)widthCollums 
            heigth:(float)heigthCollums
{
    self = [super init];
    if(self)
    {
        self.textContent = textContent;
        self.fontContent = fontContent;
        self.widthCollums = widthCollums;
        self.heigthCollums = heigthCollums;
        
        _substrings = [[NSMutableArray alloc] init];
        
        [self calculation];
    }
    return self;
}
//==========================================================================================
- (void)dealloc
{
    [_textContent release];
    [_fontContent release];
    [_substrings release];
    [_wordList release];
    
    [super dealloc];
}
//==========================================================================================
#pragma mark - GetContents
- (NSArray *)getSubStrings
{
    NSLog(@"%@",_substrings);
    return [NSArray arrayWithArray:_substrings];
}
//==========================================================================================
- (NSArray *)getLabelWithSubString
{
    NSMutableArray *labelsArrey = [[[NSMutableArray alloc] init] autorelease];
    if ([_substrings count]) 
    {        
        CGSize sizelabel = CGSizeMake(_widthCollums, _heigthCollums);
        for (int i = 0; i < [_substrings count]; i++)
        {
            if (i == [_substrings count] - 1)
                sizelabel = [[_substrings objectAtIndex:i] sizeWithFont:_fontContent constrainedToSize:CGSizeMake(_widthCollums, _heigthCollums)];
            UILabel *label = [[[UILabel alloc] initWithFrame:CGRectMake(0, 0, _widthCollums, sizelabel.height)] autorelease];
            label.font = _fontContent;
            label.text = [_substrings objectAtIndex:i];
            label.numberOfLines = 0;
            [labelsArrey addObject:label];
        }
    }
    return [NSArray arrayWithArray:labelsArrey];
}
//==========================================================================================
#pragma mark - Private method
- (void)calculation
{
    if (_wordList)
        [_wordList release];
    _wordList = [self parsingTextContent];
    
    if ([_wordList count]) 
    {
        int count = [_wordList count];      // кол-во слов
        float currentWidth = 0.f;           // ширина одной строки
        float currentHeigth = 0.f;          // высота строк, которые будут добавлены в один столбец
        YBWordWithSize *wordWithSize = nil; // текущее слово
        
        BOOL isLastWord = NO;               // флаг последнего слова
        int i = 0, j = 0;
        for (; i < count; i++) 
        {
            wordWithSize = [_wordList objectAtIndex:i];
            
            if (i == count - 1)
                isLastWord = YES;
                
            // если текущая ширина слов в строке + ширина текущего слова меньше, чем ширина столбца, значит это слово добавляем в даную строку
            if (currentWidth + [wordWithSize width] <= _widthCollums) 
            {
                currentWidth += [wordWithSize width];
            }
            // если слово "не влезло" в даную строку, значит
            // формируем новую строку, при условии, что высота всех предыдущих строк + высота новой строки не превышают высоту столбца            
            else if (currentHeigth + [wordWithSize heigth] <= _heigthCollums)
            {   
                currentWidth = [wordWithSize width];
                currentHeigth += [wordWithSize heigth];
            }
            // если высота предыдущих строк больше высоты столбца, 
            // тогда формируем новый столбец. 
            // Слова, которые будут добавлены в текущий столбец объединим в одну строку
            else
            {
                NSMutableString *columsWord = [[NSMutableString alloc] init];
                for (; j < i; j++) 
                    [columsWord appendString:[[_wordList objectAtIndex:j] word] ];
                j = i;
                
                [_substrings addObject:columsWord];
                [columsWord release];
                
                currentHeigth = [wordWithSize heigth];
                if (isLastWord) {
                    isLastWord = NO;
                    [_substrings addObject:wordWithSize.word];
                }
            }
        };
        
        if (isLastWord)
        {
            NSMutableString *columsWord = [[NSMutableString alloc] init];
            for (; j < i; j++) 
                [columsWord appendString:[[_wordList objectAtIndex:j] word] ];
            
            j = i;
            
            [_substrings addObject:columsWord];
            [columsWord release];
        }
    }
}
//==========================================================================================
- (NSMutableArray*)parsingTextContent
{
    NSMutableArray* wordList = [[NSMutableArray alloc] init];
    NSString *delitel = @" ";
    NSRange beginRange = NSMakeRange(0, 0);
    NSRange currentRange = [_textContent rangeOfString:delitel];
    NSRange rangeToFind;
    NSInteger stringLen = [_textContent length];
    while (currentRange.location != NSNotFound) 
    {
        YBWordWithSize *word = [[YBWordWithSize alloc] initWithWord:[_textContent substringWithRange:NSMakeRange(beginRange.location,currentRange.location - beginRange.location + 1)] 
                                                        forFonr: _fontContent];
        [wordList addObject:word];
        [word release];
        
        NSLog(@"%@",[NSString stringWithFormat:@"\"%@\"",word.word]);
        
        beginRange.location = currentRange.location + 1;
        rangeToFind.location = beginRange.location;
        rangeToFind.length = stringLen - beginRange.location - 1;
        currentRange = [_textContent rangeOfString:delitel options:NSCaseInsensitiveSearch range:rangeToFind];
    }
    
    NSString *lastWord = [_textContent substringFromIndex:beginRange.location];
    if([lastWord length])
    {
        YBWordWithSize *word = [[YBWordWithSize alloc] initWithWord:lastWord
                                                        forFonr:_fontContent];
        [wordList addObject:word];
        [word release];
      
        NSLog(@"%@",[NSString stringWithFormat:@"\"%@\"",word.word]);
    }
    return wordList;
}
//==========================================================================================
@end
