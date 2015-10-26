//
//  HomeCellFrame.m
//  Hello
//
//  Created by 111 on 15-8-27.
//  Copyright (c) 2015年 mit. All rights reserved.
//

#import "HomeCellFrame.h"
#import "HomeCellModel.h"



@implementation HomeCellFrame

-(void)setHomeCell:(HomeCellModel *)homeCell
{
    _HomeCell = homeCell;
    
    //头像frame
    CGFloat iconViewX = Padding;
    CGFloat iconViewY = Padding;
    CGFloat iconViewW = ICON_WIDTH;
    CGFloat iconViewH = ICON_HEIGH;
    _iconFrame = CGRectMake(iconViewX, iconViewY, iconViewW, iconViewH);
    
    
    
    //名称frame
    CGFloat namelableX = CGRectGetMaxX(_iconFrame) + Padding;
    CGFloat namelableY = iconViewY + Padding/2;
    
    CGSize  namelabelSize = [self sizeWithString:_HomeCell.Name fontSize:NameFont MaxSize:CGSizeMake(MAX_WIDTH - Padding, 0)];
    
    CGFloat namelableW = namelabelSize.width;
    CGFloat namelableH = namelabelSize.height;
    
    
    _nameFrame = CGRectMake(namelableX, namelableY, namelableW, namelableH);
    
    
    //vip frame
    CGFloat vipViewX = CGRectGetMaxX(_nameFrame) + Padding/5;
    CGFloat vipViewY = CGRectGetMinY(_nameFrame);
    CGFloat vipViewW = 15;
    CGFloat vipViewH = 15;
    
    _vipFrame = CGRectMake(vipViewX, vipViewY, vipViewW, vipViewH);
    
    
    
    //来源 frame
    CGFloat sourcelabelX = namelableX;
    CGFloat sourcelabelY = CGRectGetMaxY(_iconFrame) - 2*Padding;
    CGSize sourcelabelSize = [self sizeWithString:_HomeCell.timesource fontSize:SourceFont MaxSize:CGSizeMake(MAX_WIDTH - Padding, 0)];
    
    _timesourceFrame = CGRectMake(sourcelabelX, sourcelabelY, sourcelabelSize.width, sourcelabelSize.height);
    
    
    
    //正文 frame
    CGFloat DetaillabelX = iconViewX;
    CGFloat DetaillabelY = CGRectGetMaxY(_iconFrame) + Padding;
    CGSize detaillabelSize = [self sizeWithString:_HomeCell.detail fontSize:DetailFont MaxSize:CGSizeMake(MAX_WIDTH - Padding, 0)];
    
    CGFloat DetaillabelW = detaillabelSize.width;
    CGFloat DetaillabelH = detaillabelSize.height;
    
    //NSLog(@"Width = %f, height =%f", DetaillabelW, DetaillabelH);
    
    _detailFrame = CGRectMake(DetaillabelX, DetaillabelY, DetaillabelW, DetaillabelH);
    
    
    
    //配图 frame
    if([_HomeCell.pictureArray count] > 0) //有配图
    {
        CGFloat picViewX = DetaillabelX;
        CGFloat picViewY = CGRectGetMaxY(_detailFrame) + Padding;
        
        CGFloat picViewW = MAX_WIDTH - 2*Padding;
        CGFloat picViewH = MAX_HEIGHT;
        
        
        
        CGRect rect = CGRectZero;
        
        _pictFrameArray = [[NSMutableArray alloc] initWithCapacity:[_HomeCell.pictureArray count]];
        
        [_pictFrameArray removeAllObjects];
        
        CGFloat picX = 0;
        CGFloat picY = 0;
        CGFloat picW = IMAGE_WIDTH;
        CGFloat picH = IMAGE_HEIGHT;
        int row = 1;

        rect = CGRectMake(picX, picY, picW, picH);
        
        [_pictFrameArray addObject:[NSValue valueWithCGRect:rect]];
        
        for (int i = 1; i < [_HomeCell.pictureArray count]; i++) {
        
            
            if(picX + picW + Padding/5 + picW > MAX_WIDTH) //一行完成
            {
                row++;
                picX = 0;
                picY = picY + picH + Padding/5;
            }
            else  //一行图片
            {
                picX = picX + picW + Padding/5;
                
            }
            
            
            
            rect = CGRectMake(picX, picY, picW, picH);
            
            [_pictFrameArray addObject:[NSValue valueWithCGRect:rect]];
        }
        
        
        picViewH = picY + picH + Padding/5;
        
        _pictureFrame = CGRectMake(picViewX, picViewY, picViewW, picViewH); // 总界面
        
        
        //Cell 高度
        _cellHeight = CGRectGetMaxY(_pictureFrame) + Padding;
    }
    else //无配图
    {
        
        //Cell 高度
        _cellHeight = CGRectGetMaxY(_detailFrame) + Padding;
        
    }
    
    
    if(_HomeCell.retweetDetail != nil) //有转发weibo
    {
        CGFloat retweetViewX = DetaillabelX;
        CGFloat retweetViewY = _cellHeight;
        
        
        CGFloat retweetLabelX = Padding;
        CGFloat retweetLabely = Padding;
        CGSize retweetLabelSize = [self sizeWithString:_HomeCell.retweetDetail fontSize:DetailFont MaxSize:CGSizeMake(MAX_WIDTH - 2*Padding, 0)];
        
        CGFloat retweetLabelW = retweetLabelSize.width;
        CGFloat retweetlabelH = retweetLabelSize.height;
        
        _retweetDetailFrame = CGRectMake(retweetLabelX, retweetLabely, retweetLabelW, retweetlabelH);
        
        
        _retweetViewFrame = CGRectMake(retweetViewX, retweetViewY, MAX_WIDTH - Padding - Padding/5, retweetlabelH+Padding);
        
        
        
        _cellHeight = CGRectGetMaxY(_retweetViewFrame)+Padding;
        
        
        
        if([_HomeCell.retweetPictureArray count] > 0) //有转发weibo配图
        {
            CGFloat retweetPicViewX = 0;
            CGFloat retweetPicViewY = CGRectGetMaxY(_retweetDetailFrame) +Padding;
            
            CGFloat retweetpicViewW = retweetLabelW;
            CGFloat retweetpicViewH = MAX_HEIGHT;
            
            _retweetPictureFrameArray = [[NSMutableArray alloc] initWithCapacity:[_HomeCell.retweetPictureArray count]];
            
            [_retweetPictureFrameArray removeAllObjects];

            CGFloat retweetpicX = 0;
            CGFloat retweetpicY = 0;
            CGFloat retweetpicW = IMAGE_WIDTH;
            CGFloat retweetpicH = IMAGE_HEIGHT;
            
            CGRect rect = CGRectMake(retweetpicX, retweetpicY, retweetpicW, retweetpicH);
            
            [_retweetPictureFrameArray addObject:[NSValue valueWithCGRect:rect]];

            for (int i = 1; i < [_HomeCell.retweetPictureArray count]; i++) {
                
                
                if(retweetpicX + retweetpicW + Padding/5 + retweetpicW > (MAX_WIDTH - Padding)) //一行完成
                {
                    retweetpicX = 0;
                    retweetpicY = retweetpicY + retweetpicH + Padding/5;
                }
                else  //一行图片
                {
                    retweetpicX = retweetpicX + retweetpicW + Padding/5;
                    
                }
                
                
                
                rect = CGRectMake(retweetpicX, retweetpicY, retweetpicW, retweetpicH);
                
                [_retweetPictureFrameArray addObject:[NSValue valueWithCGRect:rect]];
            }
            
            
            retweetpicViewH = retweetpicY + retweetpicH + Padding/5;
            
            _retweetPictureFrame = CGRectMake(retweetPicViewX, retweetPicViewY,MAX_WIDTH - Padding - Padding/5, retweetpicViewH); // 总界面
            
            
            _retweetViewFrame = CGRectMake(retweetViewX, retweetViewY, MAX_WIDTH - Padding- Padding/5, retweetlabelH +2*Padding + retweetpicViewH);
            
            _cellHeight = CGRectGetMaxY(_retweetViewFrame) + Padding;

        }
        
    }
    
    
    

}

//根据正文内容多少,动态确定正文的frame
-(CGSize) sizeWithString:(NSString *)str fontSize:(UIFont *)font MaxSize:(CGSize)Max
{
    
    //strSize = [str sizeWithAttributes:[NSDictionary dictionaryWithObject:font forKey:NSFontAttributeName]];
    // iOS7中用以下方法替代过时的iOS6中的sizeWithFont:constrainedToSize:lineBreakMode:方法
    
    CGRect rect = [str boundingRectWithSize:Max options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingTruncatesLastVisibleLine|NSStringDrawingUsesFontLeading attributes:[NSDictionary dictionaryWithObject:font forKey:NSFontAttributeName] context:nil];
    
    
    
    return rect.size;
}

@end
