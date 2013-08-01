//
//  HomeController.h
//  WeiBo
//
//  Created by hcui on 13-7-1.
//  Copyright (c) 2013年 kada. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TokenDataBase.h"
#import "TokenDataBaseHelp.h"
#import <QuartzCore/QuartzCore.h>
#import "H_View_Cell.h"

@interface HomeController : UIViewController<NSURLConnectionDelegate,UITableViewDataSource,UITableViewDelegate>
{
    NSURLConnection *h_info_url;
    NSMutableData *h_info_data;
    NSMutableArray *h_array;
    
    TokenDataBase *database;
    TokenDataBaseHelp *databasehelp;
    NSMutableArray *database_array;
    
    UITableView *tableview;
    H_View_Cell *cell;

    //转发
    NSURLConnection *zf_info_url;
    NSMutableData *zf_info_data;
    
    NSString *return_string;
   IBOutlet UIActivityIndicatorView *indicatorview;
    
    float height;
    
}

@property(retain,nonatomic) IBOutlet UITableView *tableview;
@property(retain,nonatomic) NSMutableArray *h_array;

@property(retain,nonatomic) TokenDataBase *database;
@property(retain,nonatomic) TokenDataBaseHelp *databasehelp;
@property(retain,nonatomic) NSMutableArray *database_array;

@property(retain,nonatomic) NSString *return_string;
-(IBAction)refresh:(id)sender;
-(IBAction)repeat:(id)sender;
-(IBAction)publish:(id)sender;
-(void)repest_String:(NSString *)content id_:(NSString *)orig_id;

@end
