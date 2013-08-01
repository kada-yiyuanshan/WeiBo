//
//  User_WeiBo_Bean.h
//  WeiBo
//
//  Created by hcui on 13-7-19.
//  Copyright (c) 2013年 kada. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User_WeiBo_Bean : NSObject
{
    NSString *from;
    NSString *nick;
    NSString *head;
    NSString *origtext;
    NSString *timestamp;
    NSString *orig_id;
    NSString *pic_url;
    NSString *name;
    NSString *weibo_id;
}
@property(retain,nonatomic) NSString *weibo_id;
@property(retain,nonatomic) NSString *from;
@property(retain,nonatomic) NSString *nick;
@property(retain,nonatomic) NSString *head;
@property(retain,nonatomic) NSString *origtext;
@property(retain,nonatomic) NSString *timestamp;
@property(retain,nonatomic) NSString *orig_id;
@property(retain,nonatomic) NSString *pic_url;
@property(retain,nonatomic) NSString *name;

@end
