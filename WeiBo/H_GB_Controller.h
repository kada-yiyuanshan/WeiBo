//
//  H_GB_Controller.h
//  WeiBo
//
//  Created by hcui on 13-7-17.
//  Copyright (c) 2013年 kada. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TokenDataBase.h"
#import "TokenDataBaseHelp.h"
#import <QuartzCore/QuartzCore.h>

@interface H_GB_Controller : UIViewController<NSURLConnectionDelegate>
{
    NSString *weibo_id;
    NSString *back_title;
    UIView *head_view;
    UIButton *nick_bt;
    UIButton *zb_bt;
    UIButton *pl_bt;
    UIButton *gd_bt;
    UILabel *origtext;
    UILabel *origfrom;
    UILabel *time;
    UIImageView *line_view;
    UIView *pic_view;
    
    NSURLConnection *h_info_url;
    NSMutableData *h_info_data;
    NSMutableArray *h_array;
    IBOutlet UIActivityIndicatorView *indicatorview;
    TokenDataBase *database;
    TokenDataBaseHelp *databasehelp;
    NSMutableArray *database_array;
    
}
@property(retain,nonatomic) TokenDataBase *database;
@property(retain,nonatomic) TokenDataBaseHelp *databasehelp;
@property(retain,nonatomic) NSMutableArray *database_array;
@property(retain,nonatomic) NSMutableArray *h_array;

@property(retain,nonatomic) IBOutlet UIView *head_view;
@property(retain,nonatomic) IBOutlet UIButton *nick_bt;
@property(retain,nonatomic) IBOutlet UIButton *zb_bt;
@property(retain,nonatomic) IBOutlet UIButton *pl_bt;
@property(retain,nonatomic) IBOutlet UIButton *gd_bt;
@property(retain,nonatomic) IBOutlet UILabel *origtext;
@property(retain,nonatomic) IBOutlet UILabel *origfrom;
@property(retain,nonatomic) IBOutlet UILabel *time;
@property(retain,nonatomic) IBOutlet UIImageView *line_view;
@property(retain,nonatomic) IBOutlet UIView *pic_view;

@property(retain,nonatomic) NSString *weibo_id;
@property(retain,nonatomic) NSString *back_title;


-(IBAction)zb_bt_send:(id)sender;
-(IBAction)friend_bt:(id)sender;
@end
