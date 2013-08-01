//
//  User_Friend_Cell.m
//  WeiBo
//
//  Created by hcui on 13-7-19.
//  Copyright (c) 2013年 kada. All rights reserved.
//

#import "User_Friend_Cell.h"

@interface User_Friend_Cell ()

@end

@implementation User_Friend_Cell
@synthesize name,time,origtext,from,pic_view;

-(void)dealloc
{
    [super dealloc];
    [name release];
    [time release];
    [origtext release];
    [from release];
//    [pic_view release];
}

@end
