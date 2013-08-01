//
//  User_Friends_Controller.h
//  WeiBo
//
//  Created by hcui on 13-7-18.
//  Copyright (c) 2013年 kada. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TokenDataBase.h"
#import "TokenDataBaseHelp.h"
#import "User_Friend_Cell.h"
#import <QuartzCore/QuartzCore.h>

@interface User_Friends_Controller : UIViewController<UIScrollViewDelegate,UITableViewDataSource,UITableViewDelegate,NSURLConnectionDelegate>
{
    UIScrollView *scrollView;
    NSString *friend_name;
    
    UIView *head_view;
    UIButton *photo_bt;
    UIButton *other_info_bt;
    UIButton *more_bt;
    UIButton *zt_bt;
    UIButton *st_bt;
    UIButton *gb_bt;
    UIButton *yc_bt;
    UIImageView *other_image;
    UIView *view01;
    UITableView *tableview;
    UILabel *name_lb;
    UILabel *gender_lb;
    UILabel *where_lb;
    UILabel *f_info_lb;
    UILabel *some_text_lb;
    UILabel *tz_number_lb;
    UILabel *st_number_lb;
    UILabel *gb_number_lb;
    UILabel *yc_number_lb;
    UILabel *years_lb;
    UIImageView *phone_image;
    UILabel *each_other_lb;
    UIView *people_info_view;
    UIView *tz_and_st_view;
    UIView *gb_and_yc_view;
    IBOutlet UIImageView *people_image;
    IBOutlet UIActivityIndicatorView *indicatorview;
    IBOutlet UIActivityIndicatorView *indicatorview1;
    User_Friend_Cell *cell;
    float height;
    float tableview_height;
    float view_height;
    
    NSURLConnection *friends_info_url;
    NSMutableData *friends_info_data;
    NSMutableArray *friends_info_array;
    
    NSURLConnection *user_gb_url;
    NSMutableData *user_gb_data;
    NSMutableArray *user_gb_array;
    
    TokenDataBase *database;
    TokenDataBaseHelp *databasehelp;
    NSMutableArray *database_array;
}
@property(retain,nonatomic) NSMutableArray *friends_info_array;
@property(retain,nonatomic) NSMutableArray *user_gb_array;

@property(retain,nonatomic) TokenDataBase *database;
@property(retain,nonatomic) TokenDataBaseHelp *databasehelp;
@property(retain,nonatomic) NSMutableArray *database_array;

@property(retain,nonatomic) IBOutlet UIView *view01;
@property(retain,nonatomic) IBOutlet UIScrollView *scrollView;
@property(retain,nonatomic) IBOutlet UIView *head_view;
@property(retain,nonatomic) IBOutlet UIButton *photo_bt;
@property(retain,nonatomic) IBOutlet UIButton *other_info_bt;
@property(retain,nonatomic) IBOutlet UIButton *more_bt;
@property(retain,nonatomic) IBOutlet UIButton *zt_bt;
@property(retain,nonatomic) IBOutlet UIButton *st_bt;
@property(retain,nonatomic) IBOutlet UIButton *gb_bt;
@property(retain,nonatomic) IBOutlet UIButton *yc_bt;
@property(retain,nonatomic) IBOutlet UIImageView *other_image;
@property(retain,nonatomic) IBOutlet UITableView *tableview;
@property(retain,nonatomic) IBOutlet UILabel *name_lb;
@property(retain,nonatomic) IBOutlet UILabel *gender_lb;
@property(retain,nonatomic) IBOutlet UILabel *where_lb;
@property(retain,nonatomic) IBOutlet UILabel *f_info_lb;
@property(retain,nonatomic) IBOutlet UILabel *some_text_lb;
@property(retain,nonatomic) IBOutlet UILabel *tz_number_lb;
@property(retain,nonatomic) IBOutlet UILabel *st_number_lb;
@property(retain,nonatomic) IBOutlet UILabel *gb_number_lb;
@property(retain,nonatomic) IBOutlet UILabel *yc_number_lb;
@property(retain,nonatomic) IBOutlet UILabel *years_lb;
@property(retain,nonatomic) IBOutlet UIImageView *phone_image;
@property(retain,nonatomic) IBOutlet UILabel *each_other_lb;
@property(retain,nonatomic) IBOutlet UIView *people_info_view;
@property(retain,nonatomic) IBOutlet UIView *tz_and_st_view;
@property(retain,nonatomic) IBOutlet UIView *gb_and_yc_view;

@property(retain,nonatomic) NSString *friend_name;

@end
