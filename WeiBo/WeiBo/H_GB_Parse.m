//
//  H_GB_Parse.m
//  WeiBo
//
//  Created by hcui on 13-7-17.
//  Copyright (c) 2013年 kada. All rights reserved.
//

#import "H_GB_Parse.h"
#import "ErrorBean.h"
#import "H_GB_Bean.h"

@implementation H_GB_Parse
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
            H_GB_Bean *comment = [[H_GB_Bean alloc] init];
            comment.pic_url=@"";
			xmlNodePtr c2_node =cur_node->children;
			xmlNodePtr cur2_node;
            
			for(cur2_node = c2_node;cur2_node;cur2_node=cur2_node->next)
			{
				NSString *cur2_name = [NSString stringWithUTF8String:(char *)cur2_node->name];
                if ([@"nick" isEqual:cur2_name]) {
                    if (cur2_node->children != nil)  {
                        NSString * content = [NSString stringWithUTF8String:(char *)cur2_node->children->content];
                        comment.nick =content;
                        
                    }else {
                        comment.nick=@"";
                    }
                }else if ([@"name" isEqual:cur2_name]) {
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
                }else if ([@"origtext" isEqual:cur2_name]) {
                    if (cur2_node->children != nil)  {
                        NSString * content = [NSString stringWithUTF8String:(char *)cur2_node->children->content];
                        comment.origtext =content;
                    }else {
                        comment.origtext=@"";
                    }
                }else if ([@"timestamp" isEqual:cur2_name]) {
                    if (cur2_node->children != nil)  {
                        NSString * content = [NSString stringWithUTF8String:(char *)cur2_node->children->content];
                        comment.timestamp =content;
                    }else {
                        comment.timestamp=@"";
                    }
                }else if ([@"from" isEqual:cur2_name]) {
                    if (cur2_node->children != nil)  {
                        NSString * content = [NSString stringWithUTF8String:(char *)cur2_node->children->content];
                        comment.from =content;
                    }else {
                        comment.from=@"";
                    }
                }else if ([@"id" isEqual:cur2_name]) {
                    if (cur2_node->children != nil)  {
                        NSString * content = [NSString stringWithUTF8String:(char *)cur2_node->children->content];
                        comment.orig_id =content;
                    }else {
                        comment.orig_id=@"";
                    }
                }else if ([@"pic" isEqual:cur2_name]) {
                    xmlNodePtr c3_node =cur2_node->children;
                    xmlNodePtr cur3_node;
                    comment.pic_url=@"";
                    for(cur3_node = c3_node;cur3_node;cur3_node=cur3_node->next)
                    {
                        NSString *cur3_name = [NSString stringWithUTF8String:(char *)cur3_node->name];
                        if ([@"info" isEqual:cur3_name]) {
                            xmlNodePtr c4_node =cur3_node->children;
                            xmlNodePtr cur4_node;
                            
                            for(cur4_node = c4_node;cur4_node;cur4_node=cur4_node->next)
                            {
                                NSString *cur4_name = [NSString stringWithUTF8String:(char *)cur4_node->name];
                                if ([@"url" isEqual:cur4_name]) {
                                    if (cur4_node->children != nil)  {
                                        NSString * content = [NSString stringWithUTF8String:(char *)cur4_node->children->content];
                                        comment.pic_url =content;
                                        
                                    }else {
                                        comment.pic_url=@"";
                                    }
                                }
                            }
                        }
                    }
                }else
                {
                }
		    }
//            NSLog(@"nick====>%@",comment.nick);
            [_commentArr addObject:comment];
            [comment release];
        }
    }
    xmlFreeDoc(doc);
    return YES;
}

@end
