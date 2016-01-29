//
//  MainViewController.m
//  fancard
//
//  Created by Mandeep on 27/01/16.
//  Copyright © 2016 MEETStudio. All rights reserved.
//

#import "MainViewController.h"
#import "Mconfig.h"
#import "UIFactory.h"
#import "SettingsViewController.h"
#import "LeaderViewController.h"
#import "VSInfoViewController.h"
#import "UIViewExt.h"
#import "LevelsViewController.h"
#import "LogInViewController.h"
#import <AFNetworking/AFNetworking.h>
#import <MJExtension/MJExtension.h>
#import "UIView+Round.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import <LKDBHelper/NSObject+LKDBHelper.h>
#import "CMOpenALSoundManager.h"
#import "CMOpenALSoundManager+Singleton.h"
#import "WelcomeViewController.h"
#import "NSDate+FormatDateString.h"
#import "NSString+StringFormatDate.h"
#import "MySocket.h"
#import "UserInfo.h"
#import "LanbaooPrefs.h"
#import "LevelsFindFriendViewController.h"
#import "NSDictionary+NotNULL.h"
#import "FrendsTableViewCell.h"
@interface MainViewController (){
    UIImageView *starUnstarImage;
}

@end

@implementation MainViewController

- (void)viewDidLoad

{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationController.navigationBarHidden = YES;
    
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"MenuBg"]]];
    
    self.MainFrontView = [[UIView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:self.MainFrontView];
    
    self.SliderView = [[UIView alloc] initWithFrame:CGRectMake(-219, 0, 219, 568)];
    [self.view addSubview:self.SliderView];
    
    
    self.largeImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 287)];
    [self.largeImage setImage:[UIImage imageNamed:@"LargePlaceholder"]];
    
    UIBlurEffect *blur = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
    UIVisualEffectView *effectView = [[UIVisualEffectView alloc]initWithEffect:blur];
    effectView.frame = self.largeImage.frame;
    [self.largeImage addSubview:effectView];
    [self.MainFrontView addSubview:self.largeImage];
    
    
    UIButton *buttonMenu = [UIButton buttonWithType:UIButtonTypeCustom];
    [buttonMenu addTarget:self
                   action:@selector(toMenuSlider)
         forControlEvents:UIControlEventTouchUpInside];
    [buttonMenu setImage:[UIImage imageNamed:@"MenuListIcon"] forState:UIControlStateNormal];
    buttonMenu.frame = CGRectMake(17, 25, 23, 23);
    [self.MainFrontView addSubview:buttonMenu];
    
    
    UIButton *buttonContacts = [UIButton buttonWithType:UIButtonTypeCustom];
    [buttonContacts addTarget:self
                   action:@selector(toSignIn)
         forControlEvents:UIControlEventTouchUpInside];
    [buttonContacts setImage:[UIImage imageNamed:@"Frendicon"] forState:UIControlStateNormal];
    buttonContacts.frame = CGRectMake(280, 25, 23, 23);
    [self.MainFrontView addSubview:buttonContacts];
    
    
    UIImageView *imageProfile = [[UIImageView alloc] initWithFrame:CGRectMake(120, 50, 81, 80)];
    [imageProfile setImage:[UIImage imageNamed:@"SmallPlaceholder"]];
    [self.MainFrontView addSubview:imageProfile];
    
    
    UIImageView *ImagePropilepic = [[UIImageView alloc] initWithFrame:CGRectMake(126, 56, 69, 69)];
    [ImagePropilepic setImage:[UIImage imageNamed:@"Profilepic"]];
    ImagePropilepic.layer.cornerRadius = ImagePropilepic.layer.frame.size.width/2;
    [ImagePropilepic setClipsToBounds:YES];
    [self.MainFrontView addSubview:ImagePropilepic];
    
   
    self.NameLabel = [[UILabel alloc] initWithFrame:CGRectMake(100, 128, 200, 30)];
    [self.NameLabel setTextColor:[UIColor whiteColor]];
    [self.NameLabel setFont:[UIFont fontWithName:@"Montserrat-Regular" size:14.0]];
    [self.MainFrontView addSubview:self.NameLabel];
    
   
    
    UIButton *buttonQuick = [UIButton buttonWithType:UIButtonTypeCustom];
    [buttonQuick addTarget:self
                   action:@selector(toSignIn)
         forControlEvents:UIControlEventTouchUpInside];
    [buttonQuick setTitle:@"Quick Game" forState:UIControlStateNormal];
    buttonQuick.titleLabel.font =[UIFont fontWithName:@"Montserrat-Regular" size:13.0];
    [buttonQuick setBackgroundColor:[UIColor colorWithRed:44.0/255.0 green:151.0/255.0 blue:222.0/255.0 alpha:1.0]];
    [buttonQuick.layer setCornerRadius:15];
    buttonQuick.frame = CGRectMake(105, 190, 109.0, 32.0);
    [self.MainFrontView addSubview:buttonQuick];
    
    
    self.tableDetail = [[UITableView alloc] initWithFrame:CGRectMake(0, 327, 320, 241)];
    [self.tableDetail setDelegate:self];
    [self.tableDetail setDataSource:self];
    [self.tableDetail setSeparatorColor:[UIColor clearColor]];
    [self.MainFrontView addSubview:self.tableDetail];
    
    
}

-(void)viewWillAppear:(BOOL)animated

{
    if (![LanbaooPrefs sharedInstance].musicOff)
    {
        [[CMOpenALSoundManager singleton] playBackgroundMusic:@"Mind-Gym-Main.mp3"];
    }
    
    if ([LanbaooPrefs sharedInstance].userId.intValue == 0)
    {
        [self welcomePage];
    }
    
     [self getUserInfo];
    
    
    [self SegMentsCustom];
    [self.BottomImageFrend setHidden:NO];
    [self.Bottom100Image setHidden:YES];
    [self.verifiedBottom setHidden:YES];
    [self.FrendsLabel setTextColor:[UIColor colorWithRed:44.0/255.0 green:151.0/255.0 blue:222.0/255.0 alpha:1.0]];
    [self.Top100Label setTextColor:[UIColor colorWithRed:215.0/255.0 green:216.0/255.0 blue:221.0/255.0 alpha:1.0]];
    [self.VerifiedLabel setTextColor:[UIColor colorWithRed:215.0/255.0 green:216.0/255.0 blue:221.0/255.0 alpha:1.0]];
    
}

-(void)viewDidAppear:(BOOL)animated{
    
    UIImageView *imageSlider = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 219, 568)];
    [imageSlider setImage:[UIImage imageNamed:@"MenuScreen"]];
    //[self.SliderView addSubview:imageSlider];
    [self SliderUi];
    [self HomeButtonMethod:nil];
}

- (void)welcomePage
{
    WelcomeViewController *welcome = [[WelcomeViewController alloc] init];
    welcome.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    UINavigationController *navCtrl = [[UINavigationController alloc] initWithRootViewController:welcome];
    [self presentViewController:navCtrl animated:NO completion:nil];
}

- (void)getUserInfo
{
    
    WS(weakSelf)
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    NSString *timeSp = [NSString stringWithFormat:@"%ld", (long) [[NSDate new] timeIntervalSince1970]];
    //    NSDictionary *dic = @{@"uid" : uid};
    NSString *mURL = kServerURL;
    LLog(@"mURL = %@", mURL);
    
    NSString *uid = [LanbaooPrefs sharedInstance].userId;
    
    if (uid.length == 0 || uid.intValue == 0) {
        return;
    }
    
    NSDictionary *parameters = @{
                                 @"command" : @"index_rank",
                                 @"uid" : uid,
                                 };
    
    [manager GET:mURL parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *data = responseObject;
        if ([data[@"data"] isKindOfClass:[NSDictionary class]]) {
            //            [weakSelf showData:data[@"result"]];
            //            UserInfo *userInfo = [UserInfo searchSingleWithWhere:nil orderBy:nil];
            //            UserRankIndex *userRankIndex = [UserRankIndex objectWithKeyValues:data[@"data"]];
            UserInfo *userInfo = [UserInfo objectWithKeyValues:data[@"data"]];
            
            //            userInfo.points_week = userRankIndex.points_week;
            //            userInfo.points_total = userRankIndex.totalPoints;
            //            userInfo.number_win = userRankIndex.winCount;
            //            userInfo.number_lost = userRankIndex.loseCount;
            //            userInfo.rank = @(userRankIndex.rank).stringValue;
            //            userInfo.lastBotFight = userRankIndex.lastBotFight;
            //            userInfo.lastFrdFight = userRankIndex.lastFrdFight;
            
            [self.NameLabel setText:[NSString stringWithFormat:@"%@ %@",[userInfo valueForKey:@"firstname"],[userInfo valueForKey:@"lastname"]]];
            
            CGFloat xPostion = 120;
            for (int i =0; i <5; i++) {
                starUnstarImage = [[UIImageView alloc] initWithFrame:CGRectMake(xPostion, 158, 12, 11)];
                if ([[userInfo valueForKey:@"number_win"] integerValue] > 0)
                {
                    
                    if ([[userInfo valueForKey:@"number_win"] integerValue]==1)
                    {
                        if (i == 1) {
                            [starUnstarImage setImage:[UIImage imageNamed:@"StarIcon"]];
                        }
                        
                    }
                    else if ([[userInfo valueForKey:@"number_win"] integerValue]==2)
                    {
                        if (i <= 2)
                        {
                            [starUnstarImage setImage:[UIImage imageNamed:@"StarIcon"]];
                        }
                    }
                    else if ([[userInfo valueForKey:@"number_win"] integerValue]==3)
                    {
                        if (i <= 3)
                        {
                            [starUnstarImage setImage:[UIImage imageNamed:@"StarIcon"]];
                        }
                    }
                    else if ([[userInfo valueForKey:@"number_win"] integerValue]==4)
                    {
                        if (i <= 4)
                        {
                            [starUnstarImage setImage:[UIImage imageNamed:@"StarIcon"]];
                        }
                    }
                    else if ([[userInfo valueForKey:@"number_win"] integerValue]==5)
                    {
                        if (i <= 5)
                        {
                            [starUnstarImage setImage:[UIImage imageNamed:@"StarIcon"]];
                        }
                    }
                }
                else{
                    [starUnstarImage setImage:[UIImage imageNamed:@"Unstar"]];
                }
                
                [self.MainFrontView addSubview:starUnstarImage];
                xPostion = xPostion + 15;
            }
            
            
            UILabel *laebelRank = [[UILabel alloc] initWithFrame:CGRectMake(18, 254, 40, 30)];
            [laebelRank setText:@"Rank"];
            [laebelRank setFont:[UIFont fontWithName:@"Montserrat-Regular" size:10.0]];
            [laebelRank setTextColor:[UIColor whiteColor]];
            [laebelRank setTextAlignment:NSTextAlignmentCenter];
            [self.MainFrontView addSubview:laebelRank];
            
            UILabel *laebelRankValue = [[UILabel alloc] initWithFrame:CGRectMake(0, 235, 80, 30)];
            [laebelRankValue setText:[userInfo valueForKey:@"rank"]];
            [laebelRankValue setTextAlignment:NSTextAlignmentCenter];
            [laebelRankValue setFont:[UIFont fontWithName:@"Montserrat-Regular" size:14.0]];
            [laebelRankValue setTextColor:[UIColor whiteColor]];
            [laebelRankValue setBackgroundColor:[UIColor clearColor]];
            [self.MainFrontView addSubview:laebelRankValue];
            
            
            UILabel *laebelline = [[UILabel alloc] initWithFrame:CGRectMake(78, 252, 1, 30)];
            [laebelline setFont:[UIFont fontWithName:@"Montserrat-Regular" size:12.0]];
            [laebelline setBackgroundColor:[UIColor whiteColor]];
            [self.MainFrontView addSubview:laebelline];
            
            
            UILabel *laebelPoint = [[UILabel alloc] initWithFrame:CGRectMake(100, 252, 40, 30)];
            [laebelPoint setText:@"Point"];
            [laebelPoint setFont:[UIFont fontWithName:@"Montserrat-Regular" size:10.0]];
            [laebelPoint setTextColor:[UIColor whiteColor]];
            [laebelPoint setTextAlignment:NSTextAlignmentCenter];
            [self.MainFrontView addSubview:laebelPoint];
            
            
            UILabel *laebelPointValue = [[UILabel alloc] initWithFrame:CGRectMake(81, 235, 80, 30)];
            [laebelPointValue setText:@"520"];
            [laebelPointValue setTextAlignment:NSTextAlignmentCenter];
            [laebelPointValue setFont:[UIFont fontWithName:@"Montserrat-Regular" size:14.0]];
            [laebelPointValue setTextColor:[UIColor whiteColor]];
            [laebelPointValue setBackgroundColor:[UIColor clearColor]];
            [self.MainFrontView addSubview:laebelPointValue];
            
            
            UILabel *laebellineSec = [[UILabel alloc] initWithFrame:CGRectMake(160, 252, 1, 30)];
            [laebellineSec setFont:[UIFont fontWithName:@"Montserrat-Regular" size:12.0]];
            [laebellineSec setBackgroundColor:[UIColor whiteColor]];
            [self.MainFrontView addSubview:laebellineSec];
            
            
            UILabel *laebelPpg = [[UILabel alloc] initWithFrame:CGRectMake(192, 254, 40, 30)];
            [laebelPpg setText:@"PPG"];
            [laebelPpg setFont:[UIFont fontWithName:@"Montserrat-Regular" size:10.0]];
            [laebelPpg setTextColor:[UIColor whiteColor]];
            //[laebelPpg setTextAlignment:NSTextAlignmentCenter];
            [self.MainFrontView addSubview:laebelPpg];
            
            UILabel *laebelPPgValue = [[UILabel alloc] initWithFrame:CGRectMake(162, 235, 80, 30)];
            [laebelPPgValue setText:@"20.2"];
            [laebelPPgValue setTextAlignment:NSTextAlignmentCenter];
            [laebelPPgValue setFont:[UIFont fontWithName:@"Montserrat-Regular" size:14.0]];
            [laebelPPgValue setTextColor:[UIColor whiteColor]];
            [laebelPPgValue setBackgroundColor:[UIColor clearColor]];
            [self.MainFrontView addSubview:laebelPPgValue];
            
            
            UILabel *laebellineThird = [[UILabel alloc] initWithFrame:CGRectMake(245, 252, 1, 30)];
            [laebellineThird setFont:[UIFont fontWithName:@"Montserrat-Regular" size:12.0]];
            [laebellineThird setBackgroundColor:[UIColor whiteColor]];
            [self.MainFrontView addSubview:laebellineThird];
            
            UILabel *laebelWl = [[UILabel alloc] initWithFrame:CGRectMake(275, 254, 40, 30)];
            [laebelWl setText:@"W-L"];
            [laebelWl setFont:[UIFont fontWithName:@"Montserrat-Regular" size:10.0]];
            [laebelWl setTextColor:[UIColor whiteColor]];
           // [laebelWl setTextAlignment:NSTextAlignmentCenter];
            [self.MainFrontView addSubview:laebelWl];
            
            UILabel *laebelWLValue = [[UILabel alloc] initWithFrame:CGRectMake(242, 235, 80, 30)];
            [laebelWLValue setText:@"23-3"];
            [laebelWLValue setTextAlignment:NSTextAlignmentCenter];
            [laebelWLValue setFont:[UIFont fontWithName:@"Montserrat-Regular" size:14.0]];
            [laebelWLValue setTextColor:[UIColor whiteColor]];
            [laebelWLValue setBackgroundColor:[UIColor clearColor]];
            [self.MainFrontView addSubview:laebelWLValue];
            

            
            if (userInfo) {
                [userInfo updateToDB];
            }
            
            [LanbaooPrefs sharedInstance].rank = userInfo.rank.intValue;
           // [self refreshInfo];
            
        }
    }    failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        LLog(@"%@", error);
    }];
}


#pragma mark segments Custom
-(void)SegMentsCustom{
    
    UIView *viewSegment = [[UIView alloc] initWithFrame:CGRectMake(0, 287, 320, 40)];
    [viewSegment setBackgroundColor:[UIColor whiteColor]];
    [self.MainFrontView addSubview:viewSegment];
    
    self.FrendsLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 2, 80, 30)];
    [self.FrendsLabel setText:@"Friends"];
    [self.FrendsLabel setTextAlignment:NSTextAlignmentCenter];
    [self.FrendsLabel setFont:[UIFont fontWithName:@"Montserrat-Regular" size:15.0]];
    [self.FrendsLabel setTextColor:[UIColor colorWithRed:215.0/255.0 green:216.0/255.0 blue:221.0/255.0 alpha:1.0]];
    [viewSegment addSubview:self.FrendsLabel];
    
    self.BottomImageFrend = [[UIImageView alloc] initWithFrame:CGRectMake(0, 30, 107, 8)];
    [self.BottomImageFrend setImage:[UIImage imageNamed:@"BlueArrowLine"]];
    [viewSegment addSubview:self.BottomImageFrend];
    
    self.Top100Label = [[UILabel alloc] initWithFrame:CGRectMake(107, 2, 80, 30)];
    [self.Top100Label setText:@"Top 100"];
    [self.Top100Label setTextAlignment:NSTextAlignmentCenter];
    [self.Top100Label setFont:[UIFont fontWithName:@"Montserrat-Regular" size:15.0]];
    [self.Top100Label setTextColor:[UIColor colorWithRed:215.0/255.0 green:216.0/255.0 blue:221.0/255.0 alpha:1.0]];
    [viewSegment addSubview:self.Top100Label];
    
    self.Bottom100Image = [[UIImageView alloc] initWithFrame:CGRectMake(107, 30, 107, 8)];
    [self.Bottom100Image setImage:[UIImage imageNamed:@"BlueArrowLine"]];
    [viewSegment addSubview:self.Bottom100Image];
    
    self.VerifiedLabel = [[UILabel alloc] initWithFrame:CGRectMake(217, 2, 80, 30)];
    [self.VerifiedLabel setText:@"Verified"];
    [self.VerifiedLabel setTextAlignment:NSTextAlignmentCenter];
    [self.VerifiedLabel setFont:[UIFont fontWithName:@"Montserrat-Regular" size:15.0]];
    [self.VerifiedLabel setTextColor:[UIColor colorWithRed:215.0/255.0 green:216.0/255.0 blue:221.0/255.0 alpha:1.0]];
    [viewSegment addSubview:self.VerifiedLabel];
    
    self.verifiedBottom = [[UIImageView alloc] initWithFrame:CGRectMake(214, 30, 107, 8)];
    [self.verifiedBottom setImage:[UIImage imageNamed:@"BlueArrowLine"]];
    [viewSegment addSubview:self.verifiedBottom];
    
    UIButton *ButtonFrend = [UIButton buttonWithType:UIButtonTypeCustom];
    [ButtonFrend addTarget:self
                    action:@selector(FrendsButtonMethod:)
                 forControlEvents:UIControlEventTouchUpInside];
    ButtonFrend.frame = CGRectMake(0, 0, 107, 37);
    [viewSegment addSubview:ButtonFrend];
    
    
    UIButton *ButtonTop100 = [UIButton buttonWithType:UIButtonTypeCustom];
    [ButtonTop100 addTarget:self
                    action:@selector(Top100ButtonMethod:)
          forControlEvents:UIControlEventTouchUpInside];
    ButtonTop100.frame = CGRectMake(107, 0, 107, 37);
    [viewSegment addSubview:ButtonTop100];
    
    
    UIButton *ButtonVerified = [UIButton buttonWithType:UIButtonTypeCustom];
    [ButtonVerified addTarget:self
                     action:@selector(ButtonVerifiedMethod:)
           forControlEvents:UIControlEventTouchUpInside];
    ButtonVerified.frame = CGRectMake(214, 0, 107, 37);
    [viewSegment addSubview:ButtonVerified];
    
    
    
}

-(void)FrendsButtonMethod:(id)Sender{
    [self.Bottom100Image setHidden:YES];
    [self.verifiedBottom setHidden:YES];
    [self.BottomImageFrend setHidden:NO];
    
    [self.FrendsLabel setTextColor:[UIColor colorWithRed:44.0/255.0 green:151.0/255.0 blue:222.0/255.0 alpha:1.0]];
    [self.Top100Label setTextColor:[UIColor colorWithRed:215.0/255.0 green:216.0/255.0 blue:221.0/255.0 alpha:1.0]];
    [self.VerifiedLabel setTextColor:[UIColor colorWithRed:215.0/255.0 green:216.0/255.0 blue:221.0/255.0 alpha:1.0]];
    
}

-(void)Top100ButtonMethod:(id)Sender{
    
    [self.Bottom100Image setHidden:NO];
    [self.verifiedBottom setHidden:YES];
    [self.BottomImageFrend setHidden:YES];
    
    [self.FrendsLabel setTextColor:[UIColor colorWithRed:215.0/255.0 green:216.0/255.0 blue:221.0/255.0 alpha:1.0]];
    [self.Top100Label setTextColor:[UIColor colorWithRed:44.0/255.0 green:151.0/255.0 blue:222.0/255.0 alpha:1.0]];
    [self.VerifiedLabel setTextColor:[UIColor colorWithRed:215.0/255.0 green:216.0/255.0 blue:221.0/255.0 alpha:1.0]];
    
    
}
-(void)ButtonVerifiedMethod:(id)Sender{
    
    [self.Bottom100Image setHidden:YES];
    [self.verifiedBottom setHidden:NO];
    [self.BottomImageFrend setHidden:YES];
    
    [self.FrendsLabel setTextColor:[UIColor colorWithRed:215.0/255.0 green:216.0/255.0 blue:221.0/255.0 alpha:1.0]];
    [self.Top100Label setTextColor:[UIColor colorWithRed:215.0/255.0 green:216.0/255.0 blue:221.0/255.0 alpha:1.0]];
    [self.VerifiedLabel setTextColor:[UIColor colorWithRed:44.0/255.0 green:151.0/255.0 blue:222.0/255.0 alpha:1.0]];
    
    
}

#pragma mark UItableView Methods
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *simpleTableIdentifier = @"FrendsTableViewCell";
    
    FrendsTableViewCell *cell = (FrendsTableViewCell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil)
    {
        NSArray *outlets = [[NSBundle mainBundle] loadNibNamed:@"FrendsTableViewCell" owner:self options:nil];
        for (id outlet in outlets)
        {
            if ([outlet isKindOfClass:[FrendsTableViewCell class]])
            {
                cell = (FrendsTableViewCell *)outlet;
                break;
            }
        }
    }
    
    [cell.LabelCount setText:[NSString stringWithFormat:@"%ld",indexPath.row + 1]];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}

#pragma mark ToMenuSlider
-(void)toMenuSlider

{
    if (self.SliderView.frame.origin.x == 0)
    {
        [UIView animateWithDuration:0.2 animations:^{
            [self.SliderView setFrame:CGRectMake(-219, 0, self.SliderView.frame.size.width, self.SliderView.frame.size.height)];
            [self.MainFrontView setFrame:CGRectMake(0, 0, self.MainFrontView.frame.size.width, self.MainFrontView.frame.size.height)];
        }];
    }
    
    else if (self.SliderView.frame.origin.x == -219){
        [UIView animateWithDuration:0.2 animations:^{
            [self.SliderView setFrame:CGRectMake(0, 0, self.SliderView.frame.size.width, self.SliderView.frame.size.height)];
            [self.MainFrontView setFrame:CGRectMake(220, 0, self.MainFrontView.frame.size.width, self.MainFrontView.frame.size.height)];
        }];
    }
}


-(void)SliderUi{
    
    UIImageView *imageProfile = [[UIImageView alloc] initWithFrame:CGRectMake(19, 34, 81, 80)];
    [imageProfile setImage:[UIImage imageNamed:@"SmallPlaceholder"]];
    [self.SliderView addSubview:imageProfile];
    
    
    UIImageView *ImagePropilepic = [[UIImageView alloc] initWithFrame:CGRectMake(25, 40, 69, 69)];
    [ImagePropilepic setImage:[UIImage imageNamed:@"Profilepic"]];
    ImagePropilepic.layer.cornerRadius = ImagePropilepic.layer.frame.size.width/2;
    [ImagePropilepic setClipsToBounds:YES];
    [self.SliderView addSubview:ImagePropilepic];
    
    
    UIButton *MyProfile = [UIButton buttonWithType:UIButtonTypeCustom];
    [MyProfile addTarget:self
                     action:@selector(Top100ButtonMethod:)
           forControlEvents:UIControlEventTouchUpInside];
    [MyProfile setTitle:@"My Profile" forState:UIControlStateNormal];
    MyProfile.frame = CGRectMake(100, 52, 90, 37);
    [self.SliderView addSubview:MyProfile];
    
    
//

    
    
#pragma mark HomeButton
    
    self.HomeIcon = [[UIImageView alloc] initWithFrame:CGRectMake(15, 127, 23, 24)];
    [self.HomeIcon setImage:[UIImage imageNamed:@"HomeUnselect"]];
    [self.SliderView addSubview:self.HomeIcon];
    
    self.HomeLabel = [[UILabel alloc] initWithFrame:CGRectMake(60, 125, 80, 30)];
    [self.HomeLabel setText:@"Home"];
    [self.HomeLabel setTextAlignment:NSTextAlignmentLeft];
    [self.HomeLabel setFont:[UIFont fontWithName:@"Montserrat-Regular" size:14.0]];
    [self.HomeLabel setTextColor:[UIColor colorWithRed:255.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:0.6]];
    [self.HomeLabel setBackgroundColor:[UIColor clearColor]];
    [self.SliderView addSubview:self.HomeLabel];
    
    
        self.HomeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.HomeButton addTarget:self
                      action:@selector(HomeButtonMethod:)
            forControlEvents:UIControlEventTouchUpInside];
        self.HomeButton.frame = CGRectMake(0, 124, 150, 40);
        [self.SliderView addSubview:self.HomeButton];
    
    
    self.ArrowHome = [[UIImageView alloc] initWithFrame:CGRectMake(200, 135, 12, 13)];
    [self.ArrowHome setImage:[UIImage imageNamed:@"ArrowUnselect"]];
    [self.SliderView addSubview:self.ArrowHome];
    

    
    
#pragma mark YesterDay
    
    self.YeterDayImage = [[UIImageView alloc] initWithFrame:CGRectMake(15, 168, 23, 24)];
    [self.YeterDayImage setImage:[UIImage imageNamed:@"AnswerUnselect"]];
    [self.SliderView addSubview:self.YeterDayImage];
    
    
    self.YesterdayLabel = [[UILabel alloc] initWithFrame:CGRectMake(60, 165, 180, 30)];
    [self.YesterdayLabel setText:@"Yesterdays Answers"];
    [self.YesterdayLabel setTextAlignment:NSTextAlignmentLeft];
    [self.YesterdayLabel setFont:[UIFont fontWithName:@"Montserrat-Regular" size:14.0]];
    [self.YesterdayLabel setTextColor:[UIColor colorWithRed:255.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:0.6]];
    [self.YesterdayLabel setBackgroundColor:[UIColor clearColor]];
    [self.SliderView addSubview:self.YesterdayLabel];
    
    self.YesterdayButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.YesterdayButton addTarget:self
                        action:@selector(YesterdayButtonMethod:)
              forControlEvents:UIControlEventTouchUpInside];
    self.YesterdayButton.frame = CGRectMake(0, 165, 150, 40);
    [self.SliderView addSubview:self.YesterdayButton];
    
    
    self.ArrowYesterday = [[UIImageView alloc] initWithFrame:CGRectMake(200, 175, 12, 13)];
    [self.ArrowYesterday setImage:[UIImage imageNamed:@"ArrowUnselect"]];
    [self.SliderView addSubview:self.ArrowYesterday];

    

#pragma mark notification
    
    self.NotificationImage = [[UIImageView alloc] initWithFrame:CGRectMake(15, 208, 23, 24)];
    [self.NotificationImage setImage:[UIImage imageNamed:@"NotifiyUnselect"]];
    [self.SliderView addSubview:self.NotificationImage];
    
    
    self.NotificationLabel = [[UILabel alloc] initWithFrame:CGRectMake(60, 205, 180, 30)];
    [self.NotificationLabel setText:@"Notifications"];
    [self.NotificationLabel setTextAlignment:NSTextAlignmentLeft];
    [self.NotificationLabel setFont:[UIFont fontWithName:@"Montserrat-Regular" size:14.0]];
    [self.NotificationLabel setTextColor:[UIColor colorWithRed:255.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:0.6]];
    [self.NotificationLabel setBackgroundColor:[UIColor clearColor]];
    [self.SliderView addSubview:self.NotificationLabel];
    
    UISwitch *switchnotofication = [[UISwitch alloc] initWithFrame:CGRectMake(170, 205, 25, 24)];
    [switchnotofication setOnTintColor:[UIColor colorWithRed:45.0/255.0 green:62.0/255.0 blue:80.0/255.0 alpha:1.0]];
    switchnotofication.transform = CGAffineTransformMakeScale(0.75, 0.75);
    [switchnotofication addTarget: self action: @selector(NotificationSwitch:) forControlEvents: UIControlEventValueChanged];
    [self.SliderView addSubview:switchnotofication];
    
    
    
#pragma mark music
    
    self.MusicImage = [[UIImageView alloc] initWithFrame:CGRectMake(15, 248, 23, 24)];
    [self.MusicImage setImage:[UIImage imageNamed:@"MusicUnselect"]];
    [self.SliderView addSubview:self.MusicImage];
    
    
    self.MusicLabel = [[UILabel alloc] initWithFrame:CGRectMake(60, 245, 180, 30)];
    [self.MusicLabel setText:@"Music"];
    [self.MusicLabel setTextAlignment:NSTextAlignmentLeft];
    [self.MusicLabel setFont:[UIFont fontWithName:@"Montserrat-Regular" size:14.0]];
    [self.MusicLabel setTextColor:[UIColor colorWithRed:255.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:0.6]];
    [self.MusicLabel setBackgroundColor:[UIColor clearColor]];
    [self.SliderView addSubview:self.MusicLabel];
    
    UISwitch *switchnotoficationMusic = [[UISwitch alloc] initWithFrame:CGRectMake(170, 245, 25, 24)];
    [switchnotoficationMusic setOnTintColor:[UIColor colorWithRed:45.0/255.0 green:62.0/255.0 blue:80.0/255.0 alpha:1.0]];
    switchnotoficationMusic.transform = CGAffineTransformMakeScale(0.75, 0.75);
    [switchnotoficationMusic addTarget:self action: @selector(MusicsMethod:) forControlEvents: UIControlEventValueChanged];
    [self.SliderView addSubview:switchnotoficationMusic];
    
    
    
#pragma mark Sound
    
    self.SoundImage = [[UIImageView alloc] initWithFrame:CGRectMake(15, 288, 12, 13)];
    [self.SoundImage setImage:[UIImage imageNamed:@"SoundUnselect"]];
    [self.SliderView addSubview:self.SoundImage];
    
    
    self.SoundLabel = [[UILabel alloc] initWithFrame:CGRectMake(60, 285, 180, 30)];
    [self.SoundLabel setText:@"Sound Fx"];
    [self.SoundLabel setTextAlignment:NSTextAlignmentLeft];
    [self.SoundLabel setFont:[UIFont fontWithName:@"Montserrat-Regular" size:14.0]];
    [self.SoundLabel setTextColor:[UIColor colorWithRed:255.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:0.6]];
    [self.SoundLabel setBackgroundColor:[UIColor clearColor]];
    [self.SliderView addSubview:self.SoundLabel];
    
    UISwitch *switchSound = [[UISwitch alloc] initWithFrame:CGRectMake(170, 285, 25, 24)];
    [switchSound setOnTintColor:[UIColor colorWithRed:45.0/255.0 green:62.0/255.0 blue:80.0/255.0 alpha:1.0]];
    switchSound.transform = CGAffineTransformMakeScale(0.75, 0.75);
    [switchSound addTarget:self action: @selector(SoundMethod:) forControlEvents: UIControlEventValueChanged];
    [self.SliderView addSubview:switchSound];
    
    
    
    
#pragma mark Play
    
    
    self.PlayImage = [[UIImageView alloc] initWithFrame:CGRectMake(15, 328, 23, 24)];
    [self.PlayImage setImage:[UIImage imageNamed:@"HowtoPlayUnselect"]];
    [self.SliderView addSubview:self.PlayImage];
    
    
    self.PlayLabel = [[UILabel alloc] initWithFrame:CGRectMake(60, 325, 180, 30)];
    [self.PlayLabel setText:@"How to play"];
    [self.PlayLabel setTextAlignment:NSTextAlignmentLeft];
    [self.PlayLabel setFont:[UIFont fontWithName:@"Montserrat-Regular" size:14.0]];
    [self.PlayLabel setTextColor:[UIColor colorWithRed:255.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:0.6]];
    [self.PlayLabel setBackgroundColor:[UIColor clearColor]];
    [self.SliderView addSubview:self.PlayLabel];
    
    self.HowtoPlayButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.HowtoPlayButton addTarget:self
                         action:@selector(PlayButtonMethod:)
               forControlEvents:UIControlEventTouchUpInside];
    self.HowtoPlayButton.frame = CGRectMake(0, 323, 150, 40);
    [self.SliderView addSubview:self.HowtoPlayButton];
    
    self.ArrowHowtoplay = [[UIImageView alloc] initWithFrame:CGRectMake(200, 336, 12, 13)];
    [self.ArrowHowtoplay setImage:[UIImage imageNamed:@"ArrowUnselect"]];
    [self.SliderView addSubview:self.ArrowHowtoplay];
    
    
    
#pragma mark ContactUs
    
    self.ContactUsImage = [[UIImageView alloc] initWithFrame:CGRectMake(15, 368, 23, 24)];
    [self.ContactUsImage setImage:[UIImage imageNamed:@"ContactsUnselect"]];
    [self.SliderView addSubview:self.ContactUsImage];
    
    
    self.ContactUsLabel = [[UILabel alloc] initWithFrame:CGRectMake(60, 365, 180, 30)];
    [self.ContactUsLabel setText:@"Contact Us"];
    [self.ContactUsLabel setTextAlignment:NSTextAlignmentLeft];
    [self.ContactUsLabel setFont:[UIFont fontWithName:@"Montserrat-Regular" size:14.0]];
    [self.ContactUsLabel setTextColor:[UIColor colorWithRed:255.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:0.6]];
    [self.ContactUsLabel setBackgroundColor:[UIColor clearColor]];
    [self.SliderView addSubview:self.ContactUsLabel];
    
    self.ContactButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.ContactButton addTarget:self
                             action:@selector(ContactsButtonMethod:)
                   forControlEvents:UIControlEventTouchUpInside];
    self.ContactButton.frame = CGRectMake(0, 363, 150, 40);
    [self.SliderView addSubview:self.ContactButton];
    
    self.ArrowContactUs = [[UIImageView alloc] initWithFrame:CGRectMake(200, 373, 12, 13)];
    [self.ArrowContactUs setImage:[UIImage imageNamed:@"ArrowUnselect"]];
    [self.SliderView addSubview:self.ArrowContactUs];
    


#pragma mark Terms
    
    self.TermsImage = [[UIImageView alloc] initWithFrame:CGRectMake(15, 408, 23, 24)];
    [self.TermsImage setImage:[UIImage imageNamed:@"TermsUnselect"]];
    [self.SliderView addSubview:self.TermsImage];
    
    
    self.TermsLabel = [[UILabel alloc] initWithFrame:CGRectMake(60, 405, 180, 30)];
    [self.TermsLabel setText:@"Terms / Privacy"];
    [self.TermsLabel setTextAlignment:NSTextAlignmentLeft];
    [self.TermsLabel setFont:[UIFont fontWithName:@"Montserrat-Regular" size:14.0]];
    [self.TermsLabel setTextColor:[UIColor colorWithRed:255.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:0.6]];
    [self.TermsLabel setBackgroundColor:[UIColor clearColor]];
    [self.SliderView addSubview:self.TermsLabel];
    
    self.TermsButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.TermsButton addTarget:self
                           action:@selector(TermsButtonMethod:)
                 forControlEvents:UIControlEventTouchUpInside];
    self.TermsButton.frame = CGRectMake(0, 403, 150, 40);
    [self.SliderView addSubview:self.TermsButton];
    
    self.ArrowTerms = [[UIImageView alloc] initWithFrame:CGRectMake(200, 413, 12, 13)];
    [self.ArrowTerms setImage:[UIImage imageNamed:@"ArrowUnselect"]];
    [self.SliderView addSubview:self.ArrowTerms];
    
    

#pragma mark Logout
    
    self.LogoutImage = [[UIImageView alloc] initWithFrame:CGRectMake(15, 448, 23, 24)];
    [self.LogoutImage setImage:[UIImage imageNamed:@"LogoutUnselect"]];
    [self.SliderView addSubview:self.LogoutImage];
    
    
    self.Logoutlabel = [[UILabel alloc] initWithFrame:CGRectMake(60, 445, 180, 30)];
    [self.Logoutlabel setText:@"Logout"];
    [self.Logoutlabel setTextAlignment:NSTextAlignmentLeft];
    [self.Logoutlabel setFont:[UIFont fontWithName:@"Montserrat-Regular" size:14.0]];
    [self.Logoutlabel setTextColor:[UIColor colorWithRed:255.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:0.6]];
    [self.Logoutlabel setBackgroundColor:[UIColor clearColor]];
    [self.SliderView addSubview:self.Logoutlabel];
    
    
    self.LogoutButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.LogoutButton addTarget:self
                         action:@selector(LogoutButtonMethod:)
               forControlEvents:UIControlEventTouchUpInside];
    self.LogoutButton.frame = CGRectMake(0, 444, 150, 40);
    [self.SliderView addSubview:self.LogoutButton];
    
    self.ArrowLogout = [[UIImageView alloc] initWithFrame:CGRectMake(200, 456, 12, 13)];
    [self.ArrowLogout setImage:[UIImage imageNamed:@"ArrowUnselect"]];
    [self.SliderView addSubview:self.ArrowLogout];

    
    
}

-(void)HomeButtonMethod:(id)sender
{
    
    
    [self.HomeLabel setTextColor:[UIColor whiteColor]];
    [self.TermsLabel setTextColor:[UIColor colorWithRed:255.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:0.6]];
    [self.YesterdayLabel setTextColor:[UIColor colorWithRed:255.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:0.6]];
    [self.PlayLabel setTextColor:[UIColor colorWithRed:255.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:0.6]];
    [self.ContactUsLabel setTextColor:[UIColor colorWithRed:255.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:0.6]];
    [self.Logoutlabel setTextColor:[UIColor colorWithRed:255.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:0.6]];
    
    [self.HomeIcon setImage:[UIImage imageNamed:@"Homeicon"]];
    [self.YeterDayImage setImage:[UIImage imageNamed:@"AnswerUnselect"]];
    [self.PlayImage setImage:[UIImage imageNamed:@"HowtoPlayUnselect"]];
    [self.ContactUsImage setImage:[UIImage imageNamed:@"ContactsUnselect"]];
    [self.LogoutImage setImage:[UIImage imageNamed:@"LogoutUnselect"]];
    [self.TermsImage setImage:[UIImage imageNamed:@"TermsUnselect"]];
    
    
    [self.ArrowHome setImage:[UIImage imageNamed:@"ArrowSelection"]];
    [self.ArrowYesterday setImage:[UIImage imageNamed:@"ArrowUnselect"]];
    [self.ArrowHowtoplay setImage:[UIImage imageNamed:@"ArrowUnselect"]];
    [self.ContactUsImage setImage:[UIImage imageNamed:@"ArrowUnselect"]];
    [self.ArrowTerms setImage:[UIImage imageNamed:@"ArrowUnselect"]];
    [self.ArrowLogout setImage:[UIImage imageNamed:@"ArrowUnselect"]];
    
}

-(void)YesterdayButtonMethod:(id)sender{
    
    [self.HomeLabel setTextColor:[UIColor colorWithRed:255.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:0.6]];
    [self.YesterdayLabel setTextColor:[UIColor whiteColor]];
    [self.TermsLabel setTextColor:[UIColor colorWithRed:255.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:0.6]];
    [self.PlayLabel setTextColor:[UIColor colorWithRed:255.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:0.6]];
    [self.ContactUsLabel setTextColor:[UIColor colorWithRed:255.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:0.6]];
    [self.Logoutlabel setTextColor:[UIColor colorWithRed:255.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:0.6]];
    
    [self.HomeIcon setImage:[UIImage imageNamed:@"HomeUnselect"]];
    [self.YeterDayImage setImage:[UIImage imageNamed:@"AnswerIcon"]];
    [self.PlayImage setImage:[UIImage imageNamed:@"HowtoPlayUnselect"]];
    [self.ContactUsImage setImage:[UIImage imageNamed:@"ContactsUnselect"]];
    [self.LogoutImage setImage:[UIImage imageNamed:@"LogoutUnselect"]];
    [self.TermsImage setImage:[UIImage imageNamed:@"TermsUnselect"]];
    
    [self.ArrowHome setImage:[UIImage imageNamed:@"ArrowUnselect"]];
    [self.ArrowYesterday setImage:[UIImage imageNamed:@"ArrowSelection"]];
    [self.ArrowHowtoplay setImage:[UIImage imageNamed:@"ArrowUnselect"]];
    [self.ContactUsImage setImage:[UIImage imageNamed:@"ArrowUnselect"]];
    [self.ArrowTerms setImage:[UIImage imageNamed:@"ArrowUnselect"]];
    [self.ArrowLogout setImage:[UIImage imageNamed:@"ArrowUnselect"]];
    
    

    
    
    
}
-(void)PlayButtonMethod:(id)sender{
    [self.HomeLabel setTextColor:[UIColor colorWithRed:255.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:0.6]];
    [self.YesterdayLabel setTextColor:[UIColor colorWithRed:255.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:0.6]];
    [self.PlayLabel setTextColor:[UIColor whiteColor]];
    [self.TermsLabel setTextColor:[UIColor colorWithRed:255.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:0.6]];
    [self.ContactUsLabel setTextColor:[UIColor colorWithRed:255.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:0.6]];
    [self.Logoutlabel setTextColor:[UIColor colorWithRed:255.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:0.6]];
    
    [self.HomeIcon setImage:[UIImage imageNamed:@"HomeUnselect"]];
    [self.YeterDayImage setImage:[UIImage imageNamed:@"AnswerUnselect"]];
    [self.PlayImage setImage:[UIImage imageNamed:@"PlayIcon"]];
    [self.ContactUsImage setImage:[UIImage imageNamed:@"ContactsUnselect"]];
    [self.LogoutImage setImage:[UIImage imageNamed:@"LogoutUnselect"]];
    [self.TermsImage setImage:[UIImage imageNamed:@"TermsUnselect"]];
    
    
    [self.ArrowHome setImage:[UIImage imageNamed:@"ArrowUnselect"]];
    [self.ArrowYesterday setImage:[UIImage imageNamed:@"ArrowUnselect"]];
    [self.ArrowHowtoplay setImage:[UIImage imageNamed:@"ArrowSelection"]];
    [self.ContactUsImage setImage:[UIImage imageNamed:@"ArrowUnselect"]];
    [self.ArrowTerms setImage:[UIImage imageNamed:@"ArrowUnselect"]];
    [self.ArrowLogout setImage:[UIImage imageNamed:@"ArrowUnselect"]];

    
}



-(void)ContactsButtonMethod:(id)sender{
    [self.HomeLabel setTextColor:[UIColor colorWithRed:255.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:0.6]];
    [self.YesterdayLabel setTextColor:[UIColor colorWithRed:255.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:0.6]];
    [self.PlayLabel setTextColor:[UIColor colorWithRed:255.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:0.6]];
    [self.ContactUsLabel setTextColor:[UIColor whiteColor]];
    [self.TermsLabel setTextColor:[UIColor colorWithRed:255.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:0.6]];
    [self.Logoutlabel setTextColor:[UIColor colorWithRed:255.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:0.6]];
    
    [self.HomeIcon setImage:[UIImage imageNamed:@"HomeUnselect"]];
    [self.YeterDayImage setImage:[UIImage imageNamed:@"AnswerUnselect"]];
    [self.PlayImage setImage:[UIImage imageNamed:@"HowtoPlayUnselect"]];
    [self.ContactUsImage setImage:[UIImage imageNamed:@"ContactIcon"]];
    [self.LogoutImage setImage:[UIImage imageNamed:@"LogoutUnselect"]];
    [self.TermsImage setImage:[UIImage imageNamed:@"TermsUnselect"]];
    
    [self.ArrowHome setImage:[UIImage imageNamed:@"ArrowUnselect"]];
    [self.ArrowYesterday setImage:[UIImage imageNamed:@"ArrowUnselect"]];
    [self.ArrowHowtoplay setImage:[UIImage imageNamed:@"ArrowUnselect"]];
    [self.ContactUsImage setImage:[UIImage imageNamed:@"ArrowSelection"]];
    [self.ArrowTerms setImage:[UIImage imageNamed:@"ArrowUnselect"]];
    [self.ArrowLogout setImage:[UIImage imageNamed:@"ArrowUnselect"]];

    
    
}

-(void)LogoutButtonMethod:(id)sender{
    [self.HomeLabel setTextColor:[UIColor colorWithRed:255.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:0.6]];
    [self.YesterdayLabel setTextColor:[UIColor colorWithRed:255.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:0.6]];
    [self.PlayLabel setTextColor:[UIColor colorWithRed:255.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:0.6]];
    [self.ContactUsLabel setTextColor:[UIColor colorWithRed:255.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:0.6]];
    [self.TermsLabel setTextColor:[UIColor colorWithRed:255.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:0.6]];
    [self.Logoutlabel setTextColor:[UIColor whiteColor]];
    
    
    [self.HomeIcon setImage:[UIImage imageNamed:@"HomeUnselect"]];
    [self.YeterDayImage setImage:[UIImage imageNamed:@"AnswerUnselect"]];
    [self.PlayImage setImage:[UIImage imageNamed:@"HowtoPlayUnselect"]];
    [self.ContactUsImage setImage:[UIImage imageNamed:@"ContactsUnselect"]];
    [self.LogoutImage setImage:[UIImage imageNamed:@"LoutOutIcon"]];
    [self.TermsImage setImage:[UIImage imageNamed:@"TermsUnselect"]];
    
    
    [self.ArrowHome setImage:[UIImage imageNamed:@"ArrowUnselect"]];
    [self.ArrowYesterday setImage:[UIImage imageNamed:@"ArrowUnselect"]];
    [self.ArrowHowtoplay setImage:[UIImage imageNamed:@"ArrowUnselect"]];
    [self.ContactUsImage setImage:[UIImage imageNamed:@"ArrowUnselect"]];
    [self.ArrowTerms setImage:[UIImage imageNamed:@"ArrowUnselect"]];
    [self.ArrowLogout setImage:[UIImage imageNamed:@"ArrowSelection"]];


}
-(void)TermsButtonMethod:(id)sender{
    [self.HomeLabel setTextColor:[UIColor colorWithRed:255.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:0.6]];
    [self.YesterdayLabel setTextColor:[UIColor colorWithRed:255.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:0.6]];
    [self.PlayLabel setTextColor:[UIColor colorWithRed:255.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:0.6]];
    [self.ContactUsLabel setTextColor:[UIColor colorWithRed:255.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:0.6]];
    [self.TermsLabel setTextColor:[UIColor whiteColor]];
    [self.Logoutlabel setTextColor:[UIColor colorWithRed:255.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:0.6]];
    
    [self.HomeIcon setImage:[UIImage imageNamed:@"HomeUnselect"]];
    [self.YeterDayImage setImage:[UIImage imageNamed:@"AnswerUnselect"]];
    [self.PlayImage setImage:[UIImage imageNamed:@"HowtoPlayUnselect"]];
    [self.ContactUsImage setImage:[UIImage imageNamed:@"ContactsUnselect"]];
    [self.LogoutImage setImage:[UIImage imageNamed:@"LogoutUnselect"]];
    [self.TermsImage setImage:[UIImage imageNamed:@"TermIcon"]];
    
    [self.ArrowHome setImage:[UIImage imageNamed:@"ArrowUnselect"]];
    [self.ArrowYesterday setImage:[UIImage imageNamed:@"ArrowUnselect"]];
    [self.ArrowHowtoplay setImage:[UIImage imageNamed:@"ArrowUnselect"]];
    [self.ContactUsImage setImage:[UIImage imageNamed:@"ArrowUnselect"]];
    [self.ArrowTerms setImage:[UIImage imageNamed:@"ArrowSelection"]];
    [self.ArrowLogout setImage:[UIImage imageNamed:@"ArrowUnselect"]];

    
    
}


-(void)NotificationSwitch:(UISwitch *)switchh{
    
}
-(void)MusicsMethod:(UISwitch *)switchj{
    
}
-(void)SoundMethod:(UISwitch *)ghg{
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
