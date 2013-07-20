//
//  IssueCellHeader.h
//  ADVNewsstand
//
//  Created by Tope Abayomi on 17/07/2013.
//  Copyright (c) 2013 App Design Vault. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol IssueCellHeaderDelegate;

@interface IssueCellHeader : UICollectionReusableView

@property (nonatomic, weak) IBOutlet UILabel* subscribeInfoLabel;

@property (nonatomic, weak) IBOutlet UIButton* subscribeButton;

@property (nonatomic, weak) IBOutlet UIView* bgView;

@property id<IssueCellHeaderDelegate> delegate;

@end


@protocol IssueCellHeaderDelegate <NSObject>

-(void)subscribeButtonTapped;

@end