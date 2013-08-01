//
//  H_GB_Parse.h
//  WeiBo
//
//  Created by hcui on 13-7-17.
//  Copyright (c) 2013年 kada. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <libxml/xmlreader.h>
#import <libxml/xmlmemory.h>

@class H_GB_Bean;
@class ErrorBean;
@interface H_GB_Parse : NSObject
+(BOOL) parseArrXML:(NSString *)xml commentArr:(NSMutableArray*)_commentArr errorBean:(ErrorBean*)_error;
@end
