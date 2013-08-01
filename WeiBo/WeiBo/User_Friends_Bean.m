//
//  User_Friends_Bean.m
//  WeiBo
//
//  Created by hcui on 13-7-19.
//  Copyright (c) 2013年 kada. All rights reserved.
//

#import "User_Friends_Bean.h"

@implementation User_Friends_Bean
@synthesize fansnum,head,idolnum,location,name,tweetnum,regtime,ismyfans,ismyidol,sex,introduction,years;

-(void)dealloc
{
    [super dealloc];
    [fansnum release];
   // [head release];
    [idolnum release];
    [location release];
    [name release];
    [tweetnum release];
    [regtime release];
    [ismyidol release];
    [ismyfans release];
    [sex release];
    [introduction release];
    [years release];
}
@end
