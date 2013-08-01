//
//  HomeController.m
//  WeiBo
//
//  Created by hcui on 13-7-1.
//  Copyright (c) 2013年 kada. All rights reserved.
//

#import "HomeController.h"
#import "Oauth_String.h"
#import "H_info_Bean.h"
#import "H_info_Parse.h"
#import "ErrorBean.h"
#import "H_View_Cell.h"
#import "asyncimageview.h"
#import "Return_Bean.h"
#import "Return_Pares.h"
#import "H_Publish.h"
#import "ToTime.h"
#import "H_GB_Controller.h"
#import "User_Friends_Controller.h"

@interface HomeController ()

@end

@implementation HomeController
@synthesize database,database_array,databasehelp;
@synthesize tableview,h_array;
@synthesize return_string;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"主页", @"主页");
    }
    return self;
}
-(void)dealloc
{
    [super dealloc];
    [database release];
    [database_array release];
    [databasehelp release];
    [tableview release];
    [h_array release];
    [return_string release];
    
}
- (void)viewDidLoad
{
    [super viewDidLoad];
   
    [self set_item];
    self.tableview.opaque=NO;

}
-(void)viewWillAppear:(BOOL)animated
{
    self.databasehelp=[[TokenDataBaseHelp alloc] init];
    self.database=[[TokenDataBase alloc] init];
    self.database_array=[[NSMutableArray alloc] init];
    self.h_array =[[NSMutableArray alloc] init];
    
    [self.databasehelp queryTotable:self.database_array];
    self.database=[self.database_array objectAtIndex:0];
    [self url_connection:30];
   
}
-(void)url_connection:(NSInteger )num
{
    [indicatorview startAnimating];
    if (h_info_data!=nil) {
        [h_info_data release];
    }
    if (h_info_url!=nil) {
        [h_info_url release];
    }

    NSString *url=[NSString stringWithFormat:@"https://open.t.qq.com/api/statuses/home_timeline?format=xml&pageflag=0&pagetime=0&reqnum=%d&type=0x1&contenttype=1&oauth_consumer_key=801357018&access_token=%@&openid=%@&clientip=122.193.29.102&oauth_version=2.a&scope=all",num,database.access_token,database.openid];
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    h_info_url = [[NSURLConnection alloc] initWithRequest:urlRequest delegate:self];
    h_info_data =[[NSMutableData alloc] init];
   // NSLog(@"url==>%@",url);
}
-(void)set_item
{
    UIBarButtonItem *u_info=[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(publish:)];
    self.navigationItem.rightBarButtonItem=u_info;
    UIBarButtonItem *refresh=[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(refresh:)];
    self.navigationItem.leftBarButtonItem=refresh;
    [u_info release];
    [refresh release];
}
-(IBAction)publish:(id)sender
{
    H_Publish *publish=[[H_Publish alloc] initWithNibName:@"H_Publish" bundle:nil];
    [self presentModalViewController:publish animated:YES];
    [publish release];
}
-(IBAction)refresh:(id)sender
{
    [self url_connection:20];
}
-(IBAction)repeat:(id)sender
{
    UITableViewCell * cell_ = (UITableViewCell *)[[sender superview] superview];
    NSIndexPath * indexPath = [self.tableview indexPathForCell:cell_];
    H_info_Bean *bean_=[self.h_array objectAtIndex:[indexPath row]];
    [self repest_String:@"测试" id_:bean_.orig_id];
}
-(void)repest_String:(NSString *)content id_:(NSString *)orig_id
{
    [indicatorview startAnimating];
    if (zf_info_data!=nil) {
        [zf_info_data release];
    }
    if (zf_info_url!=nil) {
        [zf_info_url release];
    }
    NSString *u_info_url=[NSString stringWithFormat:@"https://open.t.qq.com/api/t/re_add"];
    NSString *info_url=[NSString stringWithFormat:@"format=xml&content=%@&reid=%@&oauth_consumer_key=801357018&access_token=%@&openid=%@&clientip=122.193.29.102&oauth_version=2.a&scope=all",content,orig_id,database.access_token,database.openid];
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:u_info_url]];
    [urlRequest setHTTPMethod:@"post"];
    [urlRequest setValue:@"PHP-SDK OAuth2.0" forHTTPHeaderField:@"User-Agent"];
    [urlRequest setHTTPBody:[info_url dataUsingEncoding:NSUTF8StringEncoding ]];
    zf_info_url = [[NSURLConnection alloc] initWithRequest:urlRequest delegate:self];
    zf_info_data =[[NSMutableData alloc] init];
}

#pragma make TABLEVIEW
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    int counts=[self.h_array count];
 
    return counts;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    H_info_Bean *info_bean=[self.h_array  objectAtIndex:[indexPath row]];
    [self tableView:self.tableview cellForRowAtIndexPath:indexPath];
    float h=[self layoutforheight:info_bean.nick origtext:info_bean.origtext origfrom:info_bean.from];
    if (h<60) {
        return 65;
    }
    return h+3;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString  *TableSampleIdentifier=@"TableSampleIdentifier";
    
    cell=(H_View_Cell *)[tableView
                                  dequeueReusableCellWithIdentifier: TableSampleIdentifier];
    
    if(cell==nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"H_View_Cell"
                                                     owner:self options:nil];
        for (id oneObject in nib)
            if ([oneObject isKindOfClass:[H_View_Cell class]])
                cell = (H_View_Cell *)oneObject;
        cell.selectionStyle = UITableViewCellSelectionStyleBlue;
    }
    [self.h_array addObject:@"asd"];
    H_info_Bean *info_bean=[self.h_array  objectAtIndex:[indexPath row]];
    
    [cell.nick setTitle:info_bean.nick forState:UIControlStateNormal];

    
    cell.origtext.text=info_bean.origtext;
    cell.time.text=[ToTime Todate:info_bean.timestamp];
    cell.origtextfrom.text=[NSString stringWithFormat:@"来自 %@",info_bean.from];
    
    if ([info_bean.head isEqualToString:@""]) {
        UIImageView *head=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"defaultThunmbnail.png" ]];
        [head setFrame:CGRectMake(0,0,50,50)];
        [cell.head addSubview:head];
        [head release];
    }else{
        AsyncImageView *asyncimageview0= [[AsyncImageView alloc] initWithFrame:CGRectMake(0,0,50.0, 50.0)];
        NSString *a=[NSString stringWithFormat:@"%@/50",info_bean.head];
        [asyncimageview0 loadImageFromURL:[NSURL URLWithString:a] land:NO];
        [cell.head addSubview:asyncimageview0];
        cell.head.layer.cornerRadius=8;
        cell.head.layer.masksToBounds = YES;
        [asyncimageview0 release];
    }
    [self layoutforheight:info_bean.nick origtext:info_bean.origtext origfrom:info_bean.from];
    cell.repeat.frame=CGRectMake(267,cell.origtextfrom.frame.origin.y,46,17);
    [cell.repeat addTarget:self action:@selector(repeat:) forControlEvents:UIControlEventTouchUpInside];
    [cell.nick addTarget:self action:@selector(friend_bt:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
}
-(IBAction)friend_bt:(id)sender
{
    User_Friends_Controller *friends=[[User_Friends_Controller alloc] initWithNibName:@"User_Friends_Controller" bundle:nil];
    friends.hidesBottomBarWhenPushed=YES;
    UITableViewCell * cell_ = (UITableViewCell *)[[sender superview] superview];
    NSIndexPath * indexPath = [self.tableview indexPathForCell:cell_];
    H_info_Bean *bean=[self.h_array objectAtIndex:[indexPath row]];
    friends.title=bean.nick;
   //s NSLog(@"name======>%@",bean.name);
    friends.friend_name=bean.name;
    [self.navigationController pushViewController:friends animated:YES];
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    H_GB_Controller *guangbo=[[H_GB_Controller alloc] initWithNibName:@"H_GB_Controller" bundle:nil];
     H_info_Bean *info_bean=[self.h_array  objectAtIndex:[indexPath row]];
    guangbo.hidesBottomBarWhenPushed=YES;
    guangbo.weibo_id=info_bean.weibo_id;
    guangbo.back_title=@"主页";
    [self.navigationController pushViewController:guangbo animated:YES];
}
-(float)layoutforheight:(NSString *)nick origtext:(NSString *)orig origfrom:(NSString *)from
{
    CGSize size = CGSizeMake(300.0, 1000);
    CGSize labelSizetitle = [nick sizeWithFont:cell.nick.titleLabel.font constrainedToSize:size lineBreakMode:UILineBreakModeClip];
    cell.nick.frame = CGRectMake(72, 9,labelSizetitle.width, labelSizetitle.height);

    CGSize origSize = [orig sizeWithFont:cell.origtext.font constrainedToSize:size lineBreakMode:UILineBreakModeClip];
    cell.origtext.frame = CGRectMake(66, 32,240, origSize.height);
    CGSize fromtext = [@"来自 " sizeWithFont:cell.origtextfrom.font constrainedToSize:size lineBreakMode:UILineBreakModeClip];
    CGSize fromSize = [from sizeWithFont:cell.origtextfrom.font constrainedToSize:size lineBreakMode:UILineBreakModeClip];
    cell.origtextfrom.frame= CGRectMake(66, cell.origtext.frame.origin.y+origSize.height+3,fromSize.width+fromtext.width, fromSize.height);
    height=cell.origtextfrom.frame.origin.y+fromSize.height;
    return height;
}
#pragma make NSURLCONNECTION
-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    if (connection==h_info_url) {
    return [h_info_data appendData:data];
    }
    if (connection==zf_info_url) {
        return [zf_info_data appendData:data];
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
    Return_Bean *return_bean=[[Return_Bean alloc] init];
     if (connection==h_info_url) {
    
    NSMutableArray *listdata=[[NSMutableArray alloc] init];
    NSString *returnString = [[NSString alloc] initWithData:h_info_data encoding:NSUTF8StringEncoding];
    [H_info_Parse parseArrXML:returnString commentArr:listdata errorBean:error];
    //NSLog(@"return_string==>%@",returnString);
    self.h_array =listdata;
    [self.tableview reloadData];
    [listdata release];
    }
    if (connection==zf_info_url) {
        NSMutableArray *return_data=[[NSMutableArray alloc] init];
        NSString *return_str= [[NSString alloc] initWithData:h_info_data encoding:NSUTF8StringEncoding];
        [Return_Pares parseArrXML:return_str commentArr:return_data return_bean:return_bean];
        self.return_string=return_bean.state;
        if ([self.return_string isEqualToString:@"ok"]) {
            [self handlereturn:@"转发成功"];
        }else
        {
            [self handlereturn:@"转发失败"];
        }
        [return_data release];
    }
    [error release];
    [indicatorview stopAnimating];
    indicatorview.hidden=YES;
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
- (void)handlereturn:(NSString *)Message
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil
														message:Message
													   delegate:nil
											  cancelButtonTitle:@"确定"
											  otherButtonTitles:nil];
    [alertView show];
    [alertView release];
}

@end
