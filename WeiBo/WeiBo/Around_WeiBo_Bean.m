//
//  Around_WeiBo_Bean.m
//  WeiBo
//
//  Created by hcui on 13-7-11.
//  Copyright (c) 2013年 kada. All rights reserved.
//

#import "Around_WeiBo_Bean.h"

@implementation Around_WeiBo_Bean
@synthesize head,origtext,nick,pic_url,from,timestamp,count;
@synthesize name,weibo_id;
-(void)dealloc
{
    [super dealloc];
    [head release];
    [origtext release];
    [name release];
    [nick release];
    [pic_url release];
   // [from release];
    [weibo_id release];
    [timestamp release];
   // [count release];
}
@end
