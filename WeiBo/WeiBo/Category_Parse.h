//
//  Category_Parse.h
//  WeiBo
//
//  Created by hcui on 13-7-10.
//  Copyright (c) 2013年 kada. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <libxml/xmlreader.h>
#import <libxml/xmlmemory.h>

@class Return_Bean;
@interface Category_Parse : NSObject
+(BOOL) parseArrXML:(NSString *)xml commentArr:(NSMutableArray*)_commentArr return_bean:(Return_Bean*)_return_bean;


@end
