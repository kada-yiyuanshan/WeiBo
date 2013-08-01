//
//  User_Friend_Cell.h
//  WeiBo
//
//  Created by hcui on 13-7-19.
//  Copyright (c) 2013年 kada. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface User_Friend_Cell : UITableViewCell
{
    UILabel *name;
    UILabel *time;
    UILabel *origtext;
    UILabel *from;
    UIView *pic_view;
}
@property(retain,nonatomic) IBOutlet UILabel *name;
@property(retain,nonatomic) IBOutlet UILabel *time;
@property(retain,nonatomic) IBOutlet UILabel *origtext;
@property(retain,nonatomic) IBOutlet UILabel *from;
@property(retain,nonatomic) IBOutlet UIView *pic_view;
@end
