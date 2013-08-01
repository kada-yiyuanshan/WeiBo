//
//  Around_WeBo_Controller.m
//  WeiBo
//
//  Created by hcui on 13-7-11.
//  Copyright (c) 2013年 kada. All rights reserved.
//

#import "Around_WeBo_Controller.h"
#import "Around_WeiBo_Cell.h"
#import "ErrorBean.h"
#import "Around_WeiBo_Bean.h"
#import "Around_WeiBo_Parse.h"
#import "asyncimageview.h"
#import "ToTime.h"
#import "User_Friends_Controller.h"
#import "H_GB_Controller.h"

@interface Around_WeBo_Controller ()

@end

@implementation Around_WeBo_Controller

@synthesize tableview;
@synthesize latitude,longitude;
@synthesize around_array;
@synthesize database,databasehelp;
@synthesize token_array;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title=@"身边的微博";
    }
    return self;
}
-(void)dealloc
{
    [super dealloc];
    [tableview release];
    [latitude release];
    [longitude release];
    [database release];
    [databasehelp release];
    [token_array release];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self nav_Item];
    
    
    self.around_array=[[NSMutableArray alloc] init];
    self.databasehelp =[[TokenDataBaseHelp alloc] init];
    self.database =[[TokenDataBase alloc] init];
    self.token_array =[[NSMutableArray alloc] init];
    [self.databasehelp queryTotable:self.token_array];
    self.database=[self.token_array objectAtIndex:0];
}
-(void)viewWillAppear:(BOOL)animated
{
    [self around_people_connection:self.longitude latitude:self.latitude gender:0 req_num:25];
}
-(IBAction)refresh:(id)sender
{
    [self around_people_connection:self.longitude latitude:self.latitude gender:0 req_num:25];
}
-(void)around_people_connection:(NSString *)longit latitude:(NSString *)lat gender:(NSInteger )sex req_num:(NSInteger )num
{
    [indicatorview startAnimating];
    if (around_data!=nil) {
        [around_data release];
    }
    if (around_url!=nil) {
        [around_url release];
    }
    NSString *u_info_url=[NSString stringWithFormat:@"https://open.t.qq.com/api/lbs/get_around_new"];
    NSString *info_url=[NSString stringWithFormat:@"format=xml&longitude=%@&latitude=%@&pageinfo=&pagesize=%d&gender=%d&oauth_consumer_key=801357018&access_token=%@&openid=%@&clientip=122.193.29.102&oauth_version=2.a&scope=all",longit,lat,num,sex,database.access_token,database.openid];
//     NSLog(@"url===>%@",info_url);
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:u_info_url]];
    [urlRequest setHTTPMethod:@"post"];
    [urlRequest setValue:@"PHP-SDK OAuth2.0" forHTTPHeaderField:@"User-Agent"];
    [urlRequest setHTTPBody:[info_url dataUsingEncoding:NSUTF8StringEncoding ]];
    around_url = [[NSURLConnection alloc] initWithRequest:urlRequest delegate:self];
    around_data =[[NSMutableData alloc] init];
}
-(IBAction)back:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma make TABLEVIEW
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    int counts=[self.around_array count];
    // NSLog(@"count====>%d",counts);
    return counts;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    float h;
    Around_WeiBo_Bean *bean=[self.around_array objectAtIndex:[indexPath row]];
    [self tableView:self.tableview cellForRowAtIndexPath:indexPath];
    if ([bean.pic_url isEqualToString:@""]) {
        h=  [self tableviewheight:bean.nick textfrom:bean.from origtext:bean.origtext pic:NO sharenum:bean.count ];
    }else{
        h=  [self tableviewheight:bean.nick textfrom:bean.from origtext:bean.origtext pic:YES sharenum:bean.count ];
    }
    if (h<60) {
        return 65;
    }
    
    return height;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString  *TableSampleIdentifier=@"TableSampleIdentifier";
    
    cell=(Around_WeiBo_Cell *)[tableView
                                      dequeueReusableCellWithIdentifier: TableSampleIdentifier];
    
    if(cell==nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"Around_WeiBo_Cell"
                                                     owner:self options:nil];
        for (id oneObject in nib)
            if ([oneObject isKindOfClass:[Around_WeiBo_Cell class]])
                cell = (Around_WeiBo_Cell *)oneObject;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    Around_WeiBo_Bean *bean=[self.around_array objectAtIndex:[indexPath row]];
    
    CGSize size = CGSizeMake(300.0, 1000);
    CGSize labelSizetitle = [bean.nick sizeWithFont:cell.nick.titleLabel.font constrainedToSize:size lineBreakMode:UILineBreakModeClip];
    cell.nick.frame = CGRectMake(72, 6,labelSizetitle.width, labelSizetitle.height);
    [cell.nick setTitle:bean.nick forState:UIControlStateNormal];
    if ([bean.head isEqualToString:@""]) {
         [self tableviewheight:bean.nick textfrom:bean.from origtext:bean.origtext pic:NO sharenum:bean.count ];
        UIImageView *head=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"defaultThunmbnail.png" ]];
        [head setFrame:CGRectMake(0,0,50,50)];
        [cell.head_view addSubview:head];
        [head release];
    }else{
         [self tableviewheight:bean.nick textfrom:bean.from origtext:bean.origtext pic:YES sharenum:bean.count ];
        AsyncImageView *asyncimageview0= [[AsyncImageView alloc] initWithFrame:CGRectMake(0,0,50.0, 50.0)];
        NSString *a=[NSString stringWithFormat:@"%@/50",bean.head];
        [asyncimageview0 loadImageFromURL:[NSURL URLWithString:a] land:NO];
        [cell.head_view addSubview:asyncimageview0];
        cell.head_view.layer.cornerRadius=8;
        cell.head_view.layer.masksToBounds = YES;
        [asyncimageview0 release];
    }
    cell.from.text=[NSString stringWithFormat:@"来自 %@",bean.from];
//    bean.timestamp;
 
    cell.time.text=[ToTime Todate:bean.timestamp];
    cell.number.text=bean.count;
    cell.origtext.text=bean.origtext;
    if ([bean.pic_url isEqualToString:@""]) {
        UIImageView *head=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"defaultThunmbnail.png" ]];
        [head setFrame:CGRectMake(0,0,50,50)];
        [cell.orig_pic addSubview:head];
        [head release];
    }else{
        AsyncImageView *asyncimageview0= [[AsyncImageView alloc] initWithFrame:CGRectMake(0,0,50.0, 50.0)];
        NSString *a=[NSString stringWithFormat:@"%@/60",bean.pic_url];
        [asyncimageview0 loadImageFromURL:[NSURL URLWithString:a] land:NO];
        [cell.orig_pic addSubview:asyncimageview0];
        //cell.head_view.layer.cornerRadius=8;
        //        cell.head_view.layer.masksToBounds = YES;
        [asyncimageview0 release];
    }

    [cell.nick addTarget:self action:@selector(friend_bt:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
}
-(IBAction)friend_bt:(id)sender
{
    User_Friends_Controller *friends=[[User_Friends_Controller alloc] initWithNibName:@"User_Friends_Controller" bundle:nil];
    friends.hidesBottomBarWhenPushed=YES;
    UITableViewCell * cell_ = (UITableViewCell *)[[sender superview] superview];
    NSIndexPath * indexPath = [self.tableview indexPathForCell:cell_];
    Around_WeiBo_Bean *bean=[self.around_array objectAtIndex:[indexPath row]];
    friends.title=bean.nick;
    //    NSLog(@"name======>%@",bean.name);
    friends.friend_name=bean.name;
    [self.navigationController pushViewController:friends animated:YES];
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    H_GB_Controller *guangbo=[[H_GB_Controller alloc] initWithNibName:@"H_GB_Controller" bundle:nil];
   Around_WeiBo_Bean *bean=[self.around_array objectAtIndex:[indexPath row]];
    guangbo.hidesBottomBarWhenPushed=YES;
    
    guangbo.weibo_id=bean.weibo_id;
    
    guangbo.back_title=@"广播";
    [self.navigationController pushViewController:guangbo animated:YES];
}
-(float )tableviewheight:(NSString *)nick textfrom:(NSString *)from origtext:(NSString *)text pic:(BOOL )_pic sharenum:(NSString *)num
{
    CGSize size = CGSizeMake(300.0, 1000);
    CGSize labelSizetitle = [nick sizeWithFont:cell.nick.titleLabel.font constrainedToSize:size lineBreakMode:UILineBreakModeClip];
    cell.nick.frame = CGRectMake(72, 9,labelSizetitle.width, labelSizetitle.height);
    
    CGSize fromSize = [from sizeWithFont:cell.from.font constrainedToSize:size lineBreakMode:UILineBreakModeClip];
    CGSize otherSize = [@"来自 " sizeWithFont:cell.from.font constrainedToSize:size lineBreakMode:UILineBreakModeClip];
    cell.from.frame = CGRectMake(72, 41,fromSize.width+otherSize.width, fromSize.height);
    
    CGSize origSize = [text sizeWithFont:cell.origtext.font constrainedToSize:size lineBreakMode:UILineBreakModeClip];
    cell.origtext.frame = CGRectMake(8, 75,origSize.width, origSize.height);
    CGSize numSize = [num sizeWithFont:cell.number.font constrainedToSize:size lineBreakMode:UILineBreakModeClip];
    cell.number.frame=CGRectMake(280,37,numSize.width, numSize.height);
    cell.lcon.frame=CGRectMake(cell.number.frame.origin.x-14,cell.number.frame.origin.y,14,13);
    if(_pic){
        cell.orig_pic.frame= CGRectMake(80,cell.origtext.frame.origin.y+origSize.height+2,60, 60);
        height=cell.orig_pic.frame.origin.y +60+3;
    }else
    {  
        cell.orig_pic.hidden=YES;
        height=cell.origtext.frame.origin.x +origSize.height+3;
    }
    cell.bg.frame=CGRectMake(0,0,320, height);
    return height;
}

#pragma make NSURLCONNECTION
-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    if(connection==around_url)
    {
        return [around_data appendData:data];
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
    
    around_url=nil;
}
-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    ErrorBean *error=[[ErrorBean alloc] init];
    
    
    if(connection==around_url)
    {
        NSMutableArray *listdata=[[NSMutableArray alloc] init];
        NSString *return_info_String = [[NSString alloc] initWithData:around_data encoding:NSUTF8StringEncoding];
        [Around_WeiBo_Parse parseArrXML:return_info_String commentArr:listdata errorBean:error];
//        NSLog(@"retu=====>%@",return_info_String);
        self.around_array=listdata;
        [self.tableview reloadData];
        [listdata release];
    }
    [indicatorview stopAnimating];
    indicatorview.hidden=YES;
    [error release];
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
-(void)nav_Item
{
    UIBarButtonItem *u_info=[[UIBarButtonItem alloc] initWithTitle:@"广场" style:UIBarButtonItemStyleBordered target:self action:@selector(back:)];
    self.navigationItem.leftBarButtonItem =u_info;
    UIBarButtonItem *refresh_=[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(refresh:)];
    self.navigationItem.rightBarButtonItem=refresh_;
    [u_info release];
    [refresh_ release];
}
@end
