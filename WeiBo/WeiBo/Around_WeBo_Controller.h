//
//  Around_WeBo_Controller.h
//  WeiBo
//
//  Created by hcui on 13-7-11.
//  Copyright (c) 2013年 kada. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TokenDataBase.h"
#import "TokenDataBaseHelp.h"
#import <QuartzCore/QuartzCore.h>
#import "Around_WeiBo_Cell.h"

@interface Around_WeBo_Controller : UIViewController<UITableViewDataSource,UITableViewDelegate,NSURLConnectionDelegate>
{
    IBOutlet UIActivityIndicatorView *indicatorview;
    
    UITableView *tableview;
    NSString *latitude;//经度
    NSString *longitude;//纬度
    
    NSURLConnection *around_url;
    NSMutableArray *around_array;
    NSMutableData *around_data;
    
    TokenDataBase *database;
    TokenDataBaseHelp *databasehelp;
    NSMutableArray *token_array;
    
    float height;
    Around_WeiBo_Cell *cell;
    
}
@property(retain,nonatomic) NSMutableArray *around_array;

@property(retain,nonatomic) TokenDataBase *database;
@property(retain,nonatomic) TokenDataBaseHelp *databasehelp;
@property(retain,nonatomic) NSMutableArray *token_array;

@property(retain,nonatomic) IBOutlet UITableView *tableview;
@property(retain,nonatomic) NSString *latitude;
@property(retain,nonatomic) NSString *longitude;

@end
