//
//  Category_Controller.m
//  WeiBo
//
//  Created by hcui on 13-7-10.
//  Copyright (c) 2013年 kada. All rights reserved.
//

#import "Category_Controller.h"
#import "ErrorBean.h"
#import "Category_Cell.h"
#import "Category_info_Bean.h"
#import "Categroy_info_Parse.h"
#import "asyncimageview.h"
#import "ToTime.h"
#import "User_Friends_Controller.h"
#import "H_GB_Controller.h"


@interface Category_Controller ()

@end

@implementation Category_Controller
@synthesize database,databasehelp;
@synthesize token_array;
@synthesize category_info_array;
@synthesize child_id,child_name;
@synthesize tableview;
@synthesize row_array;
@synthesize refresh;

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
    [database release];
    [databasehelp release];
    [token_array release];
    [category_info_array release];
    [child_id release];
    [child_name release];
    [tableview release];
    //[refresh release];
    //[row_array release];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self nav_Item];
    [self someinit];
}

-(void)someinit
{
    self.refresh=[[NSMutableArray alloc] init];
    if ([self.child_id isEqualToString:@"1985"]) {
        self.title=@"搞笑";
        [self.refresh addObject:self.child_id];
    }else{
        self.title=self.child_name;
        [self.refresh addObject:self.child_name];
    }
    
    self.row_array=[[[NSMutableArray alloc] init] autorelease];
    self.category_info_array=[[NSMutableArray alloc] init ];
    self.databasehelp =[[TokenDataBaseHelp alloc] init];
    self.database =[[TokenDataBase alloc] init];
    self.token_array =[[NSMutableArray alloc] init];
    [self.databasehelp queryTotable:self.token_array];
    self.database=[self.token_array objectAtIndex:0];
    [self category_info_connection:self.child_name child_id:self.child_id];

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

-(IBAction)refresh:(id)sender
{
   // NSLog(@"name==>%@,id====>%@",self.child_name,self.child_id);
  [self category_info_connection:self.child_name child_id:self.child_id];
}

#pragma make TABLEVIEW
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    int counts=[self.row_array count];
    
    return counts;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    float h;
     Category_info_Bean *bean=[self.row_array objectAtIndex:[indexPath row]];
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
    
    cell=(Category_Cell *)[tableView
                                      dequeueReusableCellWithIdentifier: TableSampleIdentifier];
    
    if(cell==nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"Category_Cell"
                                                     owner:self options:nil];
        for (id oneObject in nib)
            if ([oneObject isKindOfClass:[Category_Cell class]])
                cell = (Category_Cell *)oneObject;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;

    }
    Category_info_Bean *bean=[self.row_array objectAtIndex:[indexPath row]];
    
    [cell.nick setTitle:bean.nick forState:UIControlStateNormal];
    if ([bean.head isEqualToString:@""]) {
        UIImageView *head=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"defaultThunmbnail.png" ]];
        [head setFrame:CGRectMake(0,0,50,50)];
        [cell.head_view addSubview:head];
        [head release];
    }else{
        AsyncImageView *asyncimageview0= [[AsyncImageView alloc] initWithFrame:CGRectMake(0,0,50.0, 50.0)];
        NSString *a=[NSString stringWithFormat:@"%@/50",bean.head];
        [asyncimageview0 loadImageFromURL:[NSURL URLWithString:a] land:NO];
        [cell.head_view addSubview:asyncimageview0];
        cell.head_view.layer.cornerRadius=8;
        cell.head_view.layer.masksToBounds = YES;
        [asyncimageview0 release];
    }
    cell.from.text=[NSString stringWithFormat:@"来自 %@",bean.from];

    cell.time.text=[ToTime Todate:bean.pubtime];
    cell.number.text=bean.count;
    cell.origtext.text=bean.origtext;
    if ([bean.pic_url isEqualToString:@""]) {
        [self tableviewheight:bean.nick textfrom:bean.from origtext:bean.origtext pic:NO sharenum:bean.count ];
        UIImageView *head=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"defaultThunmbnail.png" ]];
        [head setFrame:CGRectMake(0,0,50,50)];
        [cell.orig_pic addSubview:head];
        [head release];
    }else{
        [self tableviewheight:bean.nick textfrom:bean.from origtext:bean.origtext pic:YES sharenum:bean.count ];
        AsyncImageView *asyncimageview0= [[AsyncImageView alloc] initWithFrame:CGRectMake(0,0,50.0, 50.0)];
        NSString *a=[NSString stringWithFormat:@"%@/60",bean.pic_url];
        [asyncimageview0 loadImageFromURL:[NSURL URLWithString:a] land:NO];
        [cell.orig_pic addSubview:asyncimageview0];
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
    Category_info_Bean *bean=[self.row_array objectAtIndex:[indexPath row]];
    friends.title=bean.nick;
//    NSLog(@"name======>%@",bean.name);
    friends.friend_name=bean.name;
    [self.navigationController pushViewController:friends animated:YES];
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

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    H_GB_Controller *guangbo=[[H_GB_Controller alloc] initWithNibName:@"H_GB_Controller" bundle:nil];
    Category_info_Bean *bean=[self.row_array objectAtIndex:[indexPath row]];
    guangbo.hidesBottomBarWhenPushed=YES;
    guangbo.weibo_id=bean.weibo_id;
    guangbo.back_title=@"搞笑";
    [self.navigationController pushViewController:guangbo animated:YES];
}

-(void)category_info_connection:(NSString *)name child_id:(NSString *)_id
{
    [indicatorview startAnimating];
    if (category_info_url!=nil) {
        [category_info_url release];
    }
    if (category_info_data!=nil) {
        [category_info_data release];
    }
    NSString *url=[NSString stringWithFormat:@"https://open.t.qq.com/api/channel/timeline?format=xml&name=%@&id=%@&reqnum=20&content_type=0&pageflag=0&pagetime=0&lastid=0&oauth_consumer_key=801357018&access_token=%@&openid=%@&clientip=122.193.29.102&oauth_version=2.a&scope=all",name,_id,self.database.access_token,self.database.openid];
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:[url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]];
    category_info_url = [[NSURLConnection alloc] initWithRequest:urlRequest delegate:self];
    category_info_data=[[NSMutableData alloc] init];
   // NSLog(@"url====>%@",url);
}
#pragma make NSURLCONNECTION
-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    if(connection==category_info_url)
    {
        return [category_info_data appendData:data];
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
    
    category_info_url=nil;
}
-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    ErrorBean *error=[[ErrorBean alloc] init];
    
   
    if(connection==category_info_url)
    {
        NSMutableArray *listdata=[[NSMutableArray alloc] init];
        NSString *return_info_String = [[NSString alloc] initWithData:category_info_data encoding:NSUTF8StringEncoding];
        [Categroy_info_Parse parseArrXML:return_info_String commentArr:listdata errorBean:error];
       // NSLog(@"retu=====>%@",return_info_String);
        self.row_array=listdata;
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

-(IBAction)back:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
