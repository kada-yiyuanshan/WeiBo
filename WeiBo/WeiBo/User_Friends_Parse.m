//
//  User_Friends_Parse.m
//  WeiBo
//
//  Created by hcui on 13-7-19.
//  Copyright (c) 2013年 kada. All rights reserved.
//

#import "User_Friends_Parse.h"
#import "User_Friends_Bean.h"
#import "ErrorBean.h"

@implementation User_Friends_Parse
+(BOOL) parseArrXML:(NSString *)xml commentArr:(NSMutableArray*)_commentArr errorBean:(ErrorBean*)_error
{
	
    //NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
	xmlDocPtr doc = xmlParseMemory([xml UTF8String], [xml lengthOfBytesUsingEncoding:NSUTF8StringEncoding]);
	if(doc ==nil)
	{
		[NSException raise:NSGenericException format:@"image xml error"];
	}
	xmlNodePtr root = xmlDocGetRootElement(doc);
	
	xmlNodePtr node = root->children;
	
	xmlNodePtr cur_node;
	
	//LoginBean *loginBean = [[LoginBean alloc] init];
	
	for(cur_node = node;cur_node;cur_node = cur_node->next)
	{
		
		NSString *cur_name = [NSString stringWithUTF8String:(char *)cur_node->name];
        if([cur_name isEqual:@"data"])
		{
            User_Friends_Bean *comment = [[User_Friends_Bean alloc] init];
			xmlNodePtr c2_node =cur_node->children;
			xmlNodePtr cur2_node;
            
			for(cur2_node = c2_node;cur2_node;cur2_node=cur2_node->next)
			{
				NSString *cur2_name = [NSString stringWithUTF8String:(char *)cur2_node->name];
              if ([@"name" isEqual:cur2_name]) {
                    if (cur2_node->children != nil)  {
                        NSString * content = [NSString stringWithUTF8String:(char *)cur2_node->children->content];
                        comment.name =content;
                    }else {
                        comment.name=@"";
                    }
                }else if ([@"head" isEqual:cur2_name]) {
                    if (cur2_node->children != nil)  {
                        NSString * content = [NSString stringWithUTF8String:(char *)cur2_node->children->content];
                        comment.head =content;
                    }else {
                        comment.head=@"";
                    }
                }else if ([@"fansnum" isEqual:cur2_name]) {
                    if (cur2_node->children != nil)  {
                        NSString * content = [NSString stringWithUTF8String:(char *)cur2_node->children->content];
                        comment.fansnum =content;
                    }else {
                        comment.fansnum=@"";
                    }
                }else if ([@"idolnum" isEqual:cur2_name]) {
                    if (cur2_node->children != nil)  {
                        NSString * content = [NSString stringWithUTF8String:(char *)cur2_node->children->content];
                        comment.idolnum =content;
                    }else {
                        comment.idolnum=@"";
                    }
                }else if ([@"introduction" isEqual:cur2_name]) {
                    if (cur2_node->children != nil)  {
                        NSString * content = [NSString stringWithUTF8String:(char *)cur2_node->children->content];
                        comment.introduction =content;
                    }else {
                        comment.introduction=@"";
                    }
                }else if ([@"regtime" isEqual:cur2_name]) {
                    if (cur2_node->children != nil)  {
                        NSString * content = [NSString stringWithUTF8String:(char *)cur2_node->children->content];
                        comment.regtime =content;
                    }else {
                        comment.regtime=@"";
                    }
                }else if ([@"ismyfans" isEqual:cur2_name]) {
                    if (cur2_node->children != nil)  {
                        NSString * content = [NSString stringWithUTF8String:(char *)cur2_node->children->content];
                        comment.ismyfans =content;
                    }else {
                        comment.ismyfans=@"";
                    }
                }else if ([@"ismyidol" isEqual:cur2_name]) {
                    if (cur2_node->children != nil)  {
                        NSString * content = [NSString stringWithUTF8String:(char *)cur2_node->children->content];
                        comment.ismyidol =content;
                    }else {
                        comment.ismyidol=@"";
                    }
                }else if ([@"sex" isEqual:cur2_name]) {
                    if (cur2_node->children != nil)  {
                        NSString * content = [NSString stringWithUTF8String:(char *)cur2_node->children->content];
                        comment.sex =content;
                    }else {
                        comment.sex=@"";
                    }
                }else if ([@"location" isEqual:cur2_name]) {
                    if (cur2_node->children != nil)  {
                        NSString * content = [NSString stringWithUTF8String:(char *)cur2_node->children->content];
                        comment.location =content;
                    }else {
                        comment.location=@"";
                    }
                }else if ([@"tweetnum" isEqual:cur2_name]) {
                    if (cur2_node->children != nil)  {
                        NSString * content = [NSString stringWithUTF8String:(char *)cur2_node->children->content];
                        comment.tweetnum =content;
                    }else {
                        comment.tweetnum=@"";
                    }
                }else if ([@"birth_year" isEqual:cur2_name]) {
                    if (cur2_node->children != nil)  {
                        NSString * content = [NSString stringWithUTF8String:(char *)cur2_node->children->content];
                        comment.years =content;
                    }else {
                        comment.years=@"";
                    }
                }else
                {
                }
		    }
//            NSLog(@"nick====>%@",comment.name);
            [_commentArr addObject:comment];
            [comment release];
        }
    }
    xmlFreeDoc(doc);
    return YES;
}

@end
