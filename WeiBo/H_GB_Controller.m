//
//  H_GB_Controller.m
//  WeiBo
//
//  Created by hcui on 13-7-17.
//  Copyright (c) 2013年 kada. All rights reserved.
//

#import "H_GB_Controller.h"
#import "ErrorBean.h"
#import "H_GB_Parse.h"
#import "H_GB_Bean.h"
#import "asyncimageview.h"
#import "ToTime.h"
#import "HomeController.h"
#import "User_Friends_Controller.h"

@interface H_GB_Controller ()

@end

@implementation H_GB_Controller
@synthesize weibo_id;
@synthesize h_array,database_array;
@synthesize database,databasehelp;
@synthesize nick_bt,head_view,zb_bt,gd_bt,origfrom,origtext,time,pl_bt,line_view;
@synthesize pic_view;
@synthesize back_title;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title=@"广播";
    }
    return self;
}

-(void)dealloc
{
    [super dealloc];
    [weibo_id release];
    [nick_bt release];
    [head_view release];
    [gd_bt release];
    [origtext release];
    [zb_bt release];
    [origfrom release];
    [time release];
    [pl_bt release];
    [line_view release];
    [pic_view release];
    [back_title release];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self nav_Item];
}
-(void)nav_Item
{
    UIBarButtonItem *u_info=[[UIBarButtonItem alloc] initWithTitle:back_title style:UIBarButtonItemStyleBordered target:self action:@selector(back:)];
    self.navigationItem.leftBarButtonItem =u_info;
}
-(IBAction)friend_bt:(id)sender
{
    User_Friends_Controller *friends=[[User_Friends_Controller alloc] initWithNibName:@"User_Friends_Controller" bundle:nil];
    friends.hidesBottomBarWhenPushed=YES;
    H_GB_Bean *bean=[self.h_array objectAtIndex:0];
    friends.title=bean.nick;
    friends.friend_name=bean.name;
    [self.navigationController pushViewController:friends animated:YES];
}
-(IBAction)back:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)viewWillAppear:(BOOL)animated
{
    self.databasehelp=[[TokenDataBaseHelp alloc] init];
    self.database=[[TokenDataBase alloc] init];
    self.database_array=[[NSMutableArray alloc] init];
    self.h_array =[[NSMutableArray alloc] init];
    
    [self.databasehelp queryTotable:self.database_array];
    self.database=[self.database_array objectAtIndex:0];
    [self url_connection:self.weibo_id];

    
}

-(IBAction)zb_bt_send:(id)sender
{

}
-(void)url_connection:(NSString *)_id
{
    [indicatorview startAnimating];
    if (h_info_data!=nil) {
        [h_info_data release];
    }
    if (h_info_url!=nil) {
        [h_info_url release];
    }
    
    NSString *url=[NSString stringWithFormat:@"https://open.t.qq.com/api/t/show?format=xml&id=%@&type=0x1&contenttype=1&oauth_consumer_key=801357018&access_token=%@&openid=%@&clientip=122.193.29.102&oauth_version=2.a&scope=all",_id,database.access_token,database.openid];
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    h_info_url = [[NSURLConnection alloc] initWithRequest:urlRequest delegate:self];
    h_info_data =[[NSMutableData alloc] init];
    //NSLog(@"url==>%@",url);
}
#pragma make NSURLCONNECTION
-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    if (connection==h_info_url) {
        return [h_info_data appendData:data];
    }
}

-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    if ([error code] == kCFURLErrorNotConnectedToInternet)
	{
        NSDictionary *userInfo = [NSDictionary dictionaryWithObject:@"No Connection Error"
															 forKey:NSLocalizedDescriptionKey];
        NSError *noConnectionError = [NSError errorWithDomain:NSCocoaErrorDomain
														 code:kCFURLErrorNotConnectedToInternet
													 userInfo:userInfo];
        [self handleError:noConnectionError];
    }
	else
	{
        [self handleError:error];
    }
    
    h_info_url = nil;
    
}
-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    ErrorBean *error=[[ErrorBean alloc] init];
    if (connection==h_info_url) {
        
        NSMutableArray *listdata=[[NSMutableArray alloc] init];
        NSString *returnString = [[NSString alloc] initWithData:h_info_data encoding:NSUTF8StringEncoding];
        [H_GB_Parse parseArrXML:returnString commentArr:listdata errorBean:error];
        self.h_array =listdata;
        [self inputdata];
        [listdata release];
    }
        [error release];
    [indicatorview stopAnimating];
    indicatorview.hidden=YES;
}
-(void)inputdata
{
    H_GB_Bean *bean=[self.h_array objectAtIndex:0];
    CGSize size = CGSizeMake(300.0, 1000);
    CGSize labelSizetitle = [bean.nick sizeWithFont:self.nick_bt.titleLabel.font constrainedToSize:size lineBreakMode:UILineBreakModeClip];
    self.nick_bt.frame = CGRectMake(67, 9,labelSizetitle.width, labelSizetitle.height);
    [self.nick_bt setTitle:bean.nick forState:UIControlStateNormal];
    
    CGSize textSize = [bean.origtext sizeWithFont:self.origtext.font constrainedToSize:size lineBreakMode:UILineBreakModeClip];
    self.origtext.frame = CGRectMake(9, 74,textSize.width, textSize.height);
    self.origtext.text=bean.origtext;
    
    if ([bean.head isEqualToString:@""]) {
        UIImageView *head=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"defaultThunmbnail.png" ]];
        [head setFrame:CGRectMake(0,0,50,50)];
        [self.head_view addSubview:head];
        [head release];
    }else{
        AsyncImageView *asyncimageview0= [[AsyncImageView alloc] initWithFrame:CGRectMake(0,0,50.0, 50.0)];
        NSString *a=[NSString stringWithFormat:@"%@/50",bean.head];
        [asyncimageview0 loadImageFromURL:[NSURL URLWithString:a] land:NO];
        [self.head_view addSubview:asyncimageview0];
        self.head_view.layer.cornerRadius=8;
        self.head_view.layer.masksToBounds = YES;
        [asyncimageview0 release];
    }
    if ([bean.pic_url isEqualToString:@""]) {
        self.pic_view.hidden=YES;
        CGSize fromtext = [@"来自 " sizeWithFont:self.origfrom.font constrainedToSize:size lineBreakMode:UILineBreakModeClip];
        CGSize fromSize = [bean.from sizeWithFont:self.origfrom.font constrainedToSize:size lineBreakMode:UILineBreakModeClip];
        self.origfrom.frame = CGRectMake(9, self.origtext.frame.origin.y+textSize.height+9,fromSize.width+fromtext.width, fromSize.height);
        self.origfrom.text=[NSString stringWithFormat:@"来自 %@",bean.from ];
        CGSize timeSize = [bean.timestamp sizeWithFont:self.time.font constrainedToSize:size lineBreakMode:UILineBreakModeClip];
        self.time.frame = CGRectMake(self.origfrom.frame.origin.x+fromSize.width+fromtext.width+3, self.origfrom.frame.origin.y,timeSize.width, timeSize.height);
        self.time.text=[ToTime Todate:bean.timestamp];
        
        self.line_view.frame=CGRectMake(0, self.time.frame.origin.y+timeSize.height+4,320,1);
    }else{
        AsyncImageView *asyncimageview0= [[AsyncImageView alloc] initWithFrame:CGRectMake(0,0,50.0, 50.0)];
        NSString *a=[NSString stringWithFormat:@"%@/60",bean.pic_url];
        [asyncimageview0 loadImageFromURL:[NSURL URLWithString:a] land:NO];
        [self.pic_view addSubview:asyncimageview0];
        [asyncimageview0 release];
         CGSize textSize = [bean.origtext sizeWithFont:self.origtext.font constrainedToSize:size lineBreakMode:UILineBreakModeClip];
        self.pic_view.frame = CGRectMake(18, self.origtext.frame.origin.y+textSize.height+5,50,50);
        
        CGSize fromtext = [@"来自 " sizeWithFont:self.origfrom.font constrainedToSize:size lineBreakMode:UILineBreakModeClip];
        CGSize fromSize = [bean.from sizeWithFont:self.origfrom.font constrainedToSize:size lineBreakMode:UILineBreakModeClip];
        self.origfrom.frame = CGRectMake(9, self.pic_view.frame.origin.y+65,fromSize.width+fromtext.width, fromSize.height);
        self.origfrom.text=[NSString stringWithFormat:@"来自 %@",bean.from ];
        
        CGSize timeSize = [bean.timestamp sizeWithFont:self.time.font constrainedToSize:size lineBreakMode:UILineBreakModeClip];
        self.time.frame = CGRectMake(self.origfrom.frame.origin.x+fromSize.width+fromtext.width+3, self.origfrom.frame.origin.y,timeSize.width, timeSize.height);
        self.time.text=[ToTime Todate:bean.timestamp];
        
        self.line_view.frame=CGRectMake(0, self.time.frame.origin.y+timeSize.height+4,320,1);
        
    }
}
- (void)handleError:(NSError *)error
{
    NSString *errorMessage = [error localizedDescription];
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"网络连接异常"
														message:errorMessage
													   delegate:nil
											  cancelButtonTitle:@"确定"
											  otherButtonTitles:nil];
    [alertView show];
    [alertView release];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
