//
//  User_Friends_Bean.h
//  WeiBo
//
//  Created by hcui on 13-7-19.
//  Copyright (c) 2013年 kada. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User_Friends_Bean : NSObject
{
    NSString *fansnum;
    NSString *head;
    NSString *idolnum;
    NSString *location;
    NSString *name;
    NSString *tweetnum;
    NSString *regtime;
    NSString *ismyfans;
    NSString *ismyidol;
    NSString *sex;
    NSString *introduction;
    NSString *years;
}
@property(retain,nonatomic) NSString *fansnum;
@property(retain,nonatomic) NSString *head;
@property(retain,nonatomic) NSString *idolnum;
@property(retain,nonatomic) NSString *location;
@property(retain,nonatomic) NSString *name;
@property(retain,nonatomic) NSString *tweetnum;
@property(retain,nonatomic) NSString *regtime;
@property(retain,nonatomic) NSString *ismyfans;
@property(retain,nonatomic) NSString *ismyidol;
@property(retain,nonatomic) NSString *sex;
@property(retain,nonatomic) NSString *introduction;
@property(retain,nonatomic) NSString *years;
@end
