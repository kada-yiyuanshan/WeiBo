//
//  User_WeiBo_Bean.m
//  WeiBo
//
//  Created by hcui on 13-7-19.
//  Copyright (c) 2013年 kada. All rights reserved.
//

#import "User_WeiBo_Bean.h"

@implementation User_WeiBo_Bean
@synthesize from,nick,head,origtext,timestamp,orig_id;;
@synthesize pic_url,name,weibo_id;
-(void)dealloc
{
    [super dealloc];
    [pic_url release];
    // [from release];
    //[nick release];
    [head release];
    [origtext release];
    [timestamp release];
    [orig_id release];
    [name release];
    [weibo_id release];
}

@end
