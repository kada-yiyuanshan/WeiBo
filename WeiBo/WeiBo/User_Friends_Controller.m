//
//  User_Friends_Controller.m
//  WeiBo
//
//  Created by hcui on 13-7-18.
//  Copyright (c) 2013年 kada. All rights reserved.
//

#import "User_Friends_Controller.h"
#import "User_Friend_Cell.h"
#import "ErrorBean.h"
#import "User_Friends_Bean.h"
#import "User_Friends_Parse.h"
#import "asyncimageview.h"
#import "User_WeiBo_Bean.h"
#import "User_WeiBo_Parse.h"
#import "ToTime.h"
#import "H_GB_Controller.h"

@interface User_Friends_Controller ()

@end

@implementation User_Friends_Controller
@synthesize head_view,other_info_bt,photo_bt,more_bt;
@synthesize zt_bt,st_bt,gb_bt,yc_bt;
@synthesize other_image;
@synthesize scrollView;
@synthesize view01;
@synthesize database,database_array,databasehelp;
@synthesize tableview,friends_info_array;
@synthesize name_lb,gb_number_lb,gender_lb,where_lb,f_info_lb,some_text_lb,st_number_lb,tz_number_lb,yc_number_lb,years_lb,phone_image,each_other_lb;
@synthesize friend_name,people_info_view,gb_and_yc_view,tz_and_st_view;
@synthesize user_gb_array;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(void)dealloc
{
    [super dealloc];
    [name_lb release];
    [gb_number_lb release];
    [gender_lb release];
    [where_lb release];
    [f_info_lb release];
    [some_text_lb release];
    [st_number_lb release];
    [tz_number_lb release];
    [yc_number_lb release];
    [friend_name release];
    [years_lb release];
    [phone_image release];
    [head_view release];
    [other_info_bt release];
    [each_other_lb release];
    [photo_bt release];
    [more_bt release];
    [zt_bt release];
    [st_bt release];
    [yc_bt release];
    [other_image release];
    [scrollView release];
    [view01 release];
    [database release];
    [database_array release];
    [databasehelp release];
    [tableview release];
    [friends_info_array release];
    [people_info_view release];
    [tz_and_st_view release];
    [gb_and_yc_view release];
    [user_gb_array release];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setbutton];
    [self nav_Item];
    [self addscrView];
}
-(void)addscrView
{
    [self.scrollView setBackgroundColor:[UIColor whiteColor]];
	[self.scrollView setCanCancelContentTouches:YES];
	self.scrollView.clipsToBounds = YES;	// default is NO, we want to restrict drawing within our scrollview
    
	self.scrollView.indicatorStyle = UIScrollViewIndicatorStyleWhite;
	[self.scrollView setContentSize:CGSizeMake(320,1000)];
	[self.scrollView setScrollEnabled:YES];
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
//     NSLog(@"tabview_height===%f",tableview_height);
//    self.tableview.frame=CGRectMake(0,view_height,320,tableview_height+18);
//     [self.scrollView setContentSize:CGSizeMake(320, self.view01.frame.size.height+self.tableview.frame.size.height-150)];
}
-(void)viewWillAppear:(BOOL)animated
{
    self.databasehelp=[[TokenDataBaseHelp alloc] init];
    self.database=[[TokenDataBase alloc] init];
    self.database_array=[[NSMutableArray alloc] init];
    self.friends_info_array =[[NSMutableArray alloc] init];
    [self.databasehelp queryTotable:self.database_array];
    self.user_gb_array =[[NSMutableArray alloc] init];
    self.database=[self.database_array objectAtIndex:0];
    [self friends_info_url_connection:self.friend_name];
    [self ueser_gb_url_connection:self.friend_name];
}
-(void)friends_info_url_connection:(NSString *)name
{
    [indicatorview startAnimating];
    if (friends_info_url!=nil) {
        [friends_info_url release];
    }
    if (friends_info_data!=nil) {
        [friends_info_data release];
    }
    
    NSString *url=[NSString stringWithFormat:@"https://open.t.qq.com/api/user/other_info?format=xml&name=%@&fopenid=&oauth_consumer_key=801357018&access_token=%@&openid=%@&clientip=122.193.29.102&oauth_version=2.a&scope=all",name,database.access_token,database.openid];
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    friends_info_url = [[NSURLConnection alloc] initWithRequest:urlRequest delegate:self];
    friends_info_data =[[NSMutableData alloc] init];
   //  NSLog(@"url==>%@",url);
}
-(void)ueser_gb_url_connection:(NSString *)name
{
    [indicatorview1 startAnimating];
    if (user_gb_url!=nil) {
        [user_gb_url release];
    }
    if (user_gb_data!=nil) {
        [user_gb_data release];
    }
    
    NSString *url=[NSString stringWithFormat:@"https://open.t.qq.com/api/statuses/user_timeline?format=xml&pageflag=0&pagetime=0&reqnum=18&lastid=0&name=%@&fopenid=&type=1&contenttype=0&oauth_consumer_key=801357018&access_token=%@&openid=%@&clientip=122.193.29.102&oauth_version=2.a&scope=all",name,database.access_token,database.openid];
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    user_gb_url = [[NSURLConnection alloc] initWithRequest:urlRequest delegate:self];
    user_gb_data =[[NSMutableData alloc] init];
//    NSLog(@"url==>%@",url);
}

- (BOOL) shouldAutorotateToInterfaceOrientation:
(UIInterfaceOrientation) interfaceOrientation {
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
-(void)nav_Item
{
    UIBarButtonItem *u_info=[[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStyleBordered target:self action:@selector(back:)];
    self.navigationItem.leftBarButtonItem =u_info;
    UIBarButtonItem *cancel=[[UIBarButtonItem alloc] initWithTitle:@"取消收听" style:UIBarButtonItemStyleBordered target:self action:nil];
    self.navigationItem.rightBarButtonItem =cancel;
}
-(IBAction)back:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)setbutton
{
    [self.photo_bt setBackgroundImage:[[UIImage imageNamed:@"wb_icon_micro_album_nor.png"]stretchableImageWithLeftCapWidth:12 topCapHeight:0] forState:UIControlStateNormal];
    [self.photo_bt setBackgroundImage:[[UIImage imageNamed:@"wb_icon_micro_album_press.png"]stretchableImageWithLeftCapWidth:12 topCapHeight:0] forState:UIControlStateHighlighted];
    [self.more_bt setBackgroundImage:[[UIImage imageNamed:@"wb_icon_more_nor.png"]stretchableImageWithLeftCapWidth:12 topCapHeight:0] forState:UIControlStateNormal];
    [self.more_bt setBackgroundImage:[[UIImage imageNamed:@"wb_icon_more_press.png"]stretchableImageWithLeftCapWidth:12 topCapHeight:0] forState:UIControlStateHighlighted];
    [self.other_info_bt setBackgroundImage:[[UIImage imageNamed:@"wb_icon_mail_nor.png"]stretchableImageWithLeftCapWidth:12 topCapHeight:0] forState:UIControlStateNormal];
    [self.other_info_bt setBackgroundImage:[[UIImage imageNamed:@"wb_icon_mail_press.png"]stretchableImageWithLeftCapWidth:12 topCapHeight:0] forState:UIControlStateHighlighted];
    [self.other_image setImage:[[UIImage imageNamed:@"information_bg_others_02_nor.png"]stretchableImageWithLeftCapWidth:50 topCapHeight:1]];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma make TABLEVIEW
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.user_gb_array count];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    float h;
    User_WeiBo_Bean *bean=[self.user_gb_array objectAtIndex:[indexPath row]];
    [self tableView:self.tableview cellForRowAtIndexPath:indexPath];
    if ([bean.pic_url isEqualToString:@""]) {
       h=[self viewCellheight:bean.nick origtext:bean.origtext origfrom:bean.from pic_view:NO];
    }else
    {
     h= [self viewCellheight:bean.nick origtext:bean.origtext origfrom:bean.from pic_view:YES];
    }
    tableview_height+=h;
    if (h<60) {
        return 65;
    }
    return h+3;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString  *TableSampleIdentifier=@"TableSampleIdentifier";
    
    cell=(User_Friend_Cell *)[tableView
                         dequeueReusableCellWithIdentifier: TableSampleIdentifier];
    
    if(cell==nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"User_Friend_Cell"
                                                     owner:self options:nil];
        for (id oneObject in nib)
            if ([oneObject isKindOfClass:[User_Friend_Cell class]])
                cell = (User_Friend_Cell *)oneObject;
        cell.selectionStyle = UITableViewCellSelectionStyleBlue;
    }
    float h;
    User_WeiBo_Bean *bean=[self.user_gb_array objectAtIndex:[indexPath row]];
    if ([bean.pic_url isEqualToString:@""]) {
        cell.pic_view.hidden=YES;
        h=[self viewCellheight:bean.nick origtext:bean.origtext origfrom:bean.from pic_view:NO];
    }else
    {
        h= [self viewCellheight:bean.nick origtext:bean.origtext origfrom:bean.from pic_view:YES];
        AsyncImageView *asyncimageview0= [[AsyncImageView alloc] initWithFrame:CGRectMake(0,0,60.0, 60.0)];
        NSString *a=[NSString stringWithFormat:@"%@/60",bean.pic_url];
        [asyncimageview0 loadImageFromURL:[NSURL URLWithString:a] land:NO];
        [cell.pic_view addSubview:asyncimageview0];

    }
    //tableview_height+=h;
    cell.name.text= bean.nick;
    cell.origtext.text=bean.origtext;
    cell.time.text= [ToTime Todate:bean.timestamp];
    cell.from.text=[NSString stringWithFormat:@"来自 %@",bean.from ];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    H_GB_Controller *guangbo=[[H_GB_Controller alloc] initWithNibName:@"H_GB_Controller" bundle:nil];
    User_WeiBo_Bean *bean=[self.user_gb_array objectAtIndex:[indexPath row]];
    guangbo.hidesBottomBarWhenPushed=YES;
    
    guangbo.weibo_id=bean.weibo_id;
    
    guangbo.back_title=@"广播";
    [self.navigationController pushViewController:guangbo animated:YES];
}
#pragma make NSURLCONNECTION
-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    if (connection==user_gb_url) {
        return [user_gb_data appendData:data];
    }
    if (connection==friends_info_url) {
        return [friends_info_data appendData:data];
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
    
    friends_info_url = nil;
    user_gb_url=nil;
}
-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    ErrorBean *error=[[ErrorBean alloc] init];
    if (connection==friends_info_url) {
        
        NSMutableArray *listdata=[[NSMutableArray alloc] init];
        NSString *returnString = [[NSString alloc] initWithData:friends_info_data encoding:NSUTF8StringEncoding];
        [User_Friends_Parse parseArrXML:returnString commentArr:listdata errorBean:error];
//         NSLog(@"return_string==>%@",returnString);
       self.friends_info_array =listdata;
        [self add_friend_info];
        
        [listdata release];
    }
    if (connection==user_gb_url) {
        NSMutableArray *user_data=[[NSMutableArray alloc] init];
        NSString *user_str= [[NSString alloc] initWithData:user_gb_data encoding:NSUTF8StringEncoding];
        [User_WeiBo_Parse parseArrXML:user_str commentArr:user_data errorBean:error];
        self.user_gb_array=user_data;
//        NSLog(@"return_str==>%@",return_str);
    }
    [error release];
    [self.tableview reloadData];
    [indicatorview stopAnimating];
    indicatorview.hidden=YES;
    [indicatorview1 stopAnimating];
    indicatorview1.hidden=YES;
}
-(void)add_friend_info
{
    User_Friends_Bean *bean=[self.friends_info_array objectAtIndex:0];

    self.name_lb.text=[NSString  stringWithFormat:@"@%@",bean.name ];
    if ([bean.sex isEqualToString:@"1"]) {
        self.gender_lb.text=@"男";
    }else if ([bean.sex isEqualToString:@"2"]) {
        self.gender_lb.text=@"女";
    }
    if ([bean.ismyfans isEqualToString:@"1"]&& [bean.ismyidol isEqualToString:@"1"]) {
        self.each_other_lb.text=@"(已互听)";
    }else if ([bean.ismyfans isEqualToString:@"1"]&& [bean.ismyidol isEqualToString:@"0"]) {
        self.each_other_lb.text=@"(听众)";
    }else if ([bean.ismyfans isEqualToString:@"0"]&& [bean.ismyidol isEqualToString:@"1"]) {
        self.each_other_lb.text=@"(已收听)";
    }
    self.where_lb.text=bean.location;
   
    if ([bean.introduction isEqualToString:@""]) {
        bean.introduction=@"还没想好写什么";
    }
    self.some_text_lb.text=bean.introduction;
    self.tz_number_lb.text=bean.fansnum;
    self.st_number_lb.text=bean.idolnum;
    self.gb_number_lb.text=bean.tweetnum;
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy  +0800"];
    NSString *datetime = [formatter stringFromDate:[NSDate date]];
    NSString *now_time = [[NSString stringWithFormat:@"%@",datetime] retain];
    if ([bean.years isEqualToString:@"0"]) {
        [self view_height:bean.name gender:bean.sex years:bean.years city:bean.location introduction:bean.introduction];
        self.years_lb.text=@"0";
    }else{
        NSString *b_y=[NSString stringWithFormat:@"%d岁",[now_time integerValue]-[bean.years integerValue]];
        self.years_lb.text=b_y;
        [self view_height:bean.name gender:bean.sex years:b_y city:bean.location introduction:bean.introduction];
    }
    if ([bean.head isEqualToString:@""]) {
        UIImageView *head=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"defaultThunmbnail.png" ]];
        [head setFrame:CGRectMake(0,0,60,60)];
        [self.head_view addSubview:head];
        [head release];
    }else{
        AsyncImageView *asyncimageview0= [[AsyncImageView alloc] initWithFrame:CGRectMake(0,0,60.0, 60.0)];
        NSString *a=[NSString stringWithFormat:@"%@/50",bean.head];
        [asyncimageview0 loadImageFromURL:[NSURL URLWithString:a] land:NO];
        [self.head_view addSubview:asyncimageview0];
        self.head_view.layer.cornerRadius=8;
        self.head_view.layer.masksToBounds = YES;
        [asyncimageview0 release];
    }
}
-(void)view_height:(NSString *)name gender:(NSString *)sex years:(NSString *)year city:(NSString *)location introduction:(NSString *)origtext
{
    CGSize size = CGSizeMake(300.0, 1000);
    CGSize nn = [@"@" sizeWithFont:self.name_lb.font constrainedToSize:size lineBreakMode:UILineBreakModeClip];
    CGSize namesize = [name sizeWithFont:self.name_lb.font constrainedToSize:size lineBreakMode:UILineBreakModeClip];
    self.name_lb.frame = CGRectMake(5,5,namesize.width+nn.width, namesize.height);
    
    CGSize gendersize = [sex sizeWithFont:self.gender_lb.font constrainedToSize:size lineBreakMode:UILineBreakModeClip];
    self.gender_lb.frame = CGRectMake(self.name_lb.frame.origin.x+namesize.width+nn.width+3,5,20, gendersize.height);
    
    CGSize yy= [@"岁" sizeWithFont:self.name_lb.font constrainedToSize:size lineBreakMode:UILineBreakModeClip];
    CGSize yearsize = [year sizeWithFont:self.years_lb.font constrainedToSize:size lineBreakMode:UILineBreakModeClip];
    self.years_lb.frame = CGRectMake(self.gender_lb.frame.origin.x+gendersize.width+nn.width,5,yearsize.width+yy.width+5, yearsize.height);
    
    CGSize locationsize = [location sizeWithFont:self.where_lb.font constrainedToSize:size lineBreakMode:UILineBreakModeClip];
    self.where_lb.frame = CGRectMake(self.years_lb.frame.origin.x+yearsize.width+nn.width,5,locationsize.width, locationsize.height);
    CGSize origtextsize = [origtext sizeWithFont:self.some_text_lb.font constrainedToSize:size lineBreakMode:UILineBreakModeClip];
    self.some_text_lb.frame = CGRectMake(5,43,origtextsize.width, origtextsize.height);
    self.people_info_view.frame=CGRectMake(0,115,320, origtextsize.height+self.some_text_lb.frame.origin.y);
    people_image.frame=CGRectMake(0,115,320, origtextsize.height+self.some_text_lb.frame.origin.y);
    self.tz_and_st_view.frame=CGRectMake(0,self.people_info_view.frame.origin.y+self.people_info_view.frame.size.height+9,320,40);
    self.gb_and_yc_view.frame=CGRectMake(0,self.tz_and_st_view.frame.origin.y+self.tz_and_st_view.frame.size.height+9,320,40);
    view_height=self.gb_and_yc_view.frame.origin.y+self.gb_and_yc_view.frame.size.height+9;
    self.tableview.frame=CGRectMake(0,view_height,320,1000);
}
-(float)viewCellheight:(NSString *)nick origtext:(NSString *)text origfrom:(NSString *)from pic_view:(BOOL)pic
{
    CGSize size = CGSizeMake(300.0, 1000);
    CGSize nicksize = [nick sizeWithFont:cell.name.font constrainedToSize:size lineBreakMode:UILineBreakModeClip];
     cell.name.frame = CGRectMake(5,5,nicksize.width, nicksize.height);
    CGSize textsize = [text sizeWithFont:cell.origtext.font constrainedToSize:size lineBreakMode:UILineBreakModeClip];
    cell.origtext.frame = CGRectMake(5,cell.name.frame.origin.y+cell.name.frame.size.height+4,textsize.width, textsize.height);
    CGSize fromsize = [from sizeWithFont:cell.from.font constrainedToSize:size lineBreakMode:UILineBreakModeClip];
    if (pic) {
        cell.pic_view.frame = CGRectMake(20,cell.origtext.frame.origin.y+cell.origtext.frame.size.height+4,60.0,60.0);
        CGSize laizi = [@"来自 " sizeWithFont:cell.from.font constrainedToSize:size lineBreakMode:UILineBreakModeClip];
        cell.from.frame = CGRectMake(5,cell.pic_view.frame.origin.y+cell.pic_view.frame.size.height+4,fromsize.width+laizi.width, fromsize.height);
    }else{
        cell.pic_view.hidden=YES;
        CGSize laizi = [@"来自 " sizeWithFont:cell.from.font constrainedToSize:size lineBreakMode:UILineBreakModeClip];
        cell.from.frame = CGRectMake(5, cell.origtext.frame.origin.y+cell.origtext.frame.size.height+4,fromsize.width+laizi.width, fromsize.height);
    }
    height=cell.from.frame.origin.y+cell.from.frame.size.height+3;
    
    return height;
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

@end
