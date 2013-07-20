//
//  IssueCellProtocol.h
//  ADVNewsstand
//
//  Created by Tope Abayomi on 04/07/2013.
//  Copyright (c) 2013 App Design Vault. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IssueInfo.h"

@protocol IssueCellProtocol <NSObject>

@property (nonatomic, strong) IssueInfo* issueInfo;

@end
