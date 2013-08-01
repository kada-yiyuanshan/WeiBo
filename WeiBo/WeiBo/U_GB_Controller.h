//
//  U_GB_Controller.h
//  WeiBo
//
//  Created by hcui on 13-7-3.
//  Copyright (c) 2013年 kada. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TokenDataBase.h"
#import "TokenDataBaseHelp.h"
#import "U_Orig_Cell.h"

@interface U_GB_Controller : UIViewController<UITableViewDataSource,UITableViewDelegate,NSURLConnectionDelegate,NSURLConnectionDataDelegate>
{
    UITableView *tableview;
    UITableViewCell *tableviewcell;
    float height;
    NSMutableArray *token_arry;
    
    NSMutableArray *orig_info_arry;
    NSMutableData *orig_info_data;
    NSURLConnection *orig_info_url;
    TokenDataBase *database;
    TokenDataBaseHelp *datahelp;
    UIActivityIndicatorView *progressInd;
    U_Orig_Cell *cell;
}

@property(retain,nonatomic) IBOutlet  UIActivityIndicatorView *progressInd;

@property(retain,nonatomic) IBOutlet UITableView *tableview;
@property(retain,nonatomic) IBOutlet UITableViewCell *tableviewcell;
@property(retain,nonatomic) NSMutableArray *orig_info_arry;
@property(retain,nonatomic) NSMutableArray *token_arry;

@property(retain,nonatomic) TokenDataBaseHelp *datahelp;
@property(retain,nonatomic) TokenDataBase *database;

@end
