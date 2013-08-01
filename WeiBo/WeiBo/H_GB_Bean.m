//
//  H_GB_Bean.m
//  WeiBo
//
//  Created by hcui on 13-7-17.
//  Copyright (c) 2013年 kada. All rights reserved.
//

#import "H_GB_Bean.h"

@implementation H_GB_Bean
@synthesize from,nick,head,origtext,timestamp,orig_id;;
@synthesize pic_url,name;
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
}

@end
