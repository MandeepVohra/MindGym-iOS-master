//
//  MainViewController.h
//  fancard
//
//  Created by Mandeep on 27/01/16.
//  Copyright © 2016 MEETStudio. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,retain)  UIView *MainFrontView,*SliderView;
@property (nonatomic,retain)  UIImageView *largeImage,*BottomImageFrend,*Bottom100Image,*verifiedBottom;
@property (nonatomic,retain)  UILabel *NameLabel,*FrendsLabel,*Top100Label,*VerifiedLabel;
@property (nonatomic,retain) UITableView *tableDetail;

@property (nonatomic,retain)  UIImageView *HomeIcon,*YeterDayImage,*NotificationImage,*MusicImage,*SoundImage,*PlayImage,*ContactUsImage,*TermsImage,*LogoutImage;
@property (nonatomic,retain)  UILabel *HomeLabel,*YesterdayLabel,*NotificationLabel,*MusicLabel,*SoundLabel,*PlayLabel,*ContactUsLabel,*TermsLabel,*Logoutlabel;
@property (nonatomic,retain) UIButton *HomeButton,*YesterdayButton,*HowtoPlayButton,*ContactButton,*TermsButton,*LogoutButton;
@property (nonatomic,retain)  UIImageView *ArrowHome,*ArrowYesterday,*ArrowHowtoplay,*ArrowContactUs,*ArrowTerms,*ArrowLogout;
@end
