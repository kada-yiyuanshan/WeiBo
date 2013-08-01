//
//  ToTime.m
//  WeiBo
//
//  Created by hcui on 13-7-17.
//  Copyright (c) 2013年 kada. All rights reserved.
//

#import "ToTime.h"

@implementation ToTime
//将时间转换成 刚刚、几小时前、昨天、前天
+(NSString *)Todate:(NSString *)data
{
    NSString *someday;
    
    //获取之前的时间
    NSTimeInterval time=[data doubleValue];
    NSDate *detaildate=[NSDate dateWithTimeIntervalSince1970:time];
    NSDateFormatter *outputFormatter = [[[NSDateFormatter alloc] init] autorelease];
    [outputFormatter setLocale:[NSLocale currentLocale]];
    [outputFormatter setDateFormat:@"yyyy年MM月dd日 HH:mm:ss +0800"];
    NSString *before_time = [outputFormatter stringFromDate:detaildate];
    //取出是哪一天的
    NSString *before = [before_time substringToIndex:12];
    someday=before_time;
    //获取当前的时间
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy年MM月dd日 HH:mm:ss  +0800"];
    NSString *datetime = [formatter stringFromDate:[NSDate date]];
    NSString *now_time = [[NSString stringWithFormat:@"%@",datetime] retain];
    //获取当前是哪一天
    NSString *now=[now_time substringToIndex:12];
    //判断是不是今天
    if ([before isEqualToString:now]) {
        [outputFormatter setDateFormat:@"HH"];
        NSString *b_h = [outputFormatter stringFromDate:detaildate];
        [outputFormatter setDateFormat:@"mm"];
        NSString *b_m = [outputFormatter stringFromDate:detaildate];
        NSInteger b_all_m=[b_h integerValue]*60+[b_m integerValue];
        
        [formatter setDateFormat:@"HH"];
        NSString *n_h = [formatter stringFromDate:[NSDate date]];
        [formatter setDateFormat:@"mm"];
        NSString *n_m = [formatter stringFromDate:[NSDate date]];
        NSInteger n_all_m=[n_h integerValue]*60+[n_m integerValue];
        NSInteger time=n_all_m-b_all_m;
        //判断是不是刚刚
        if (time/60==0) {
            if (time%60==0) {
                someday=@"刚刚";
            }else
            {
                someday=[NSString stringWithFormat:@"%d分钟前",time%60];
            }
        }else
        {
            someday=[NSString stringWithFormat:@"%d小时前",time/60];
        }
    }else
    {
        NSRange beforerang = NSMakeRange(8, 10);
        NSString * beforeRang = [before_time substringWithRange:beforerang];
        NSString * nowRang = [now_time substringWithRange:beforerang];
        [outputFormatter setDateFormat:@"HH:mm"];
        NSString *ang=[outputFormatter stringFromDate:detaildate];
        if ([nowRang integerValue]-[beforeRang integerValue]==1) {
            someday=[NSString stringWithFormat:@"昨天 %@",ang];
        }else if ([nowRang integerValue]-[beforeRang integerValue]==2) {
            someday=[NSString stringWithFormat:@"前天 %@",ang];
        }else
        {
            [outputFormatter setDateFormat:@"MM月dd日"];
            NSString *ang=[outputFormatter stringFromDate:detaildate];
            someday=ang;
        }
    }
    [formatter release];
    return someday;
}

@end
