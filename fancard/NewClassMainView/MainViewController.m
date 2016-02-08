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
<<<<<<< Updated upstream
@interface MainViewController (){
    UIImageView *starUnstarImage;
=======
#import <PureLayout/PureLayout.h>
#import "SRWebSocket.h"
typedef NS_ENUM(NSInteger, RankListTimeType) {
    thisWeekType = 1,
    lastWeekType = 2,
};

typedef NS_ENUM(NSInteger, RanType) {
    top100Type = 1,
    friendType = 2,
    thirdPartType = 3,
};


@interface MainViewController (){
    UIImageView *starUnstarImage;
    
    RankListTimeType listTimeType;
    RanType rankType;
    BotModel *botModel;
    UIImageView *ImagePropilepic,* ImagePropilepicSlider;
    
>>>>>>> Stashed changes
}

@end

@implementation MainViewController

- (void)viewDidLoad

{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [LanbaooPrefs sharedInstance].challengerId = nil;
    self.isFindFriend = YES;
    listTimeType = thisWeekType;
    rankType = top100Type;
    
    self.navigationController.navigationBarHidden = YES;
    
<<<<<<< Updated upstream
=======
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didReceiveMessage:) name:kSocketNotification object:nil];
    
>>>>>>> Stashed changes
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"MenuBg"]]];
    
    self.MainFrontView = [[UIView alloc] initWithFrame:self.view.bounds];
    [self.MainFrontView setUserInteractionEnabled:YES];
    [self.view addSubview:self.MainFrontView];
    
<<<<<<< Updated upstream
    self.SliderView = [[UIView alloc] initWithFrame:CGRectMake(-219, 0, 219, 568)];
=======
    
    self.SliderView = [[UIView alloc] initWithFrame:CGRectMake(-219, 0, 219, 568)];
    [self.SliderView setUserInteractionEnabled:YES];

>>>>>>> Stashed changes
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
                       action:@selector(findFriendBtnClick:)
         forControlEvents:UIControlEventTouchUpInside];
    [buttonContacts setImage:[UIImage imageNamed:@"Frendicon"] forState:UIControlStateNormal];
    buttonContacts.frame = CGRectMake(280, 25, 23, 23);
    [self.MainFrontView addSubview:buttonContacts];
    
    
    UIImageView *imageProfile = [[UIImageView alloc] initWithFrame:CGRectMake(120, 50, 81, 80)];
    [imageProfile setImage:[UIImage imageNamed:@"SmallPlaceholder"]];
    [self.MainFrontView addSubview:imageProfile];
    
    
    ImagePropilepic = [[UIImageView alloc] initWithFrame:CGRectMake(126, 56, 69, 69)];
    //[ImagePropilepic setImage:[UIImage imageNamed:@"PlaceholderImageWithoutBorder"]];
    ImagePropilepic.layer.cornerRadius = ImagePropilepic.layer.frame.size.width/2;
    [ImagePropilepic setClipsToBounds:YES];
    [self.MainFrontView addSubview:ImagePropilepic];
    
   
<<<<<<< Updated upstream
    self.NameLabel = [[UILabel alloc] initWithFrame:CGRectMake(100, 128, 200, 30)];
=======
    self.NameLabel = [[UILabel alloc] initWithFrame:CGRectMake(80, 128, 170, 30)];
>>>>>>> Stashed changes
    [self.NameLabel setTextColor:[UIColor whiteColor]];
    [self.NameLabel setFont:[UIFont fontWithName:@"Montserrat-Regular" size:14.0]];
    [self.NameLabel setTextAlignment:NSTextAlignmentCenter];
    [self.MainFrontView addSubview:self.NameLabel];
  

   
    self.DayLabel = [[UILabel alloc] initWithFrame:CGRectMake(70, 20, 200, 30)];
    //[DayLabel setText:[NSString stringWithFormat:@"Day %ld/7", (long) [componets weekday]]];
    [self.DayLabel setTextColor:[UIColor whiteColor]];
    [self.DayLabel setFont:[UIFont fontWithName:@"Montserrat-Regular" size:14.0]];
    [self.DayLabel setTextAlignment:NSTextAlignmentCenter];
    [self.MainFrontView addSubview:self.DayLabel];
    
    
    m_pTimer = [NSTimer scheduledTimerWithTimeInterval:1.0
                                                target:self
                                              selector:@selector(calcuRemainTime)
                                              userInfo:nil
                                               repeats:YES];
    m_pStartDate = [NSDate date];
    NSLog(@"%@", m_pStartDate);
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond fromDate:m_pStartDate];
    
    components.day += 1;
    components.hour = 0;
    components.minute = 0;
    components.second = 0;
    newDate = [calendar dateFromComponents:components];
    oddTime = [newDate timeIntervalSinceDate:m_pStartDate];
    
    
    UIButton *buttonQuick = [UIButton buttonWithType:UIButtonTypeCustom];
    [buttonQuick addTarget:self
                    action:@selector(QuickGame:)
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
    
    
//    chaView = [[GetChallenge alloc] initWithFrame:CGRectMake(5, 500 - 25 - 165, kScreenWidth - 10, 165)];
//    chaView.reDelegate = self;
//    chaView.backgroundColor = [UIColor clearColor];
//    [self.view addSubview:chaView];
//    chaView.hidden = YES;
    
    
   
    
    
    [self SliderUi];
    
    
   
    
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

#pragma mark - Calculate the remaining time

- (void)calcuRemainTime {
    double deltaTime = [[NSDate date] timeIntervalSinceDate:m_pStartDate];
    
    int remainTime = oddTime - (int) (deltaTime + 0.5);
    
    if (remainTime < 0.0) {
        [m_pTimer invalidate];
        return;
    }
    [self showTime:(int) remainTime];
}

- (void)showTime:(int)time {
    int inputSeconds = (int) time;
    int hours = inputSeconds / 3600;
    int minutes = (inputSeconds - hours * 3600) / 60;
    int seconds = inputSeconds - hours * 3600 - minutes * 60;
    
    NSString *strTime = [NSString stringWithFormat:@"%.2d:%.2d:%.2d", hours, minutes, seconds];
    
    
    NSDate *date = [NSDate date];
    NSDateComponents *componets = [[NSCalendar autoupdatingCurrentCalendar] components:NSWeekdayCalendarUnit fromDate:date];
    
    [self.DayLabel setText:[NSString stringWithFormat:@"%@  %@",[NSString stringWithFormat:@"Day %ld/7", (long) [componets weekday]],strTime]];
}

#pragma mark - responseDelegate

- (void)responseChallenge:(UserInfo *)userInfo {
    self.fid = userInfo.id.intValue;
    
    challengerArr = [[NSMutableArray alloc] init];
   // chaView.hidden = YES;
    [self.ChallengeView setHidden:YES];
    [self sendAcceptChallengeMessage:userInfo];
}

- (void)sendAcceptChallengeMessage:(UserInfo *)userInfo
{
    if ([MySocket singleton].sRWebSocket.readyState == SR_OPEN)
    {
        
        NSString *userId = [LanbaooPrefs sharedInstance].userId;
        
        PushBean *pushBean = [[PushBean alloc] init];
        pushBean.uid = userId;
        pushBean.toUid = @(_fid).stringValue;
        pushBean.action = @"accept";
        
        NSDate *date = [beanTime getDateWithFormat:kDateFormat];
        NSLog(@"sendAcceptChallengeMessage:date=%@", date);
        NSDate *date2 = [[NSDate new] dateByAddingTimeInterval:[LanbaooPrefs sharedInstance].gapTime];
        NSLog(@"sendAcceptChallengeMessage:date2=%@", date2);
        double seconds = [date2 timeIntervalSinceDate:date];
        NSLog(@"seconds%d", (int) seconds);
        pushBean.pushTime = [[NSDate new] getDateStrWithFormat:kDateFormat];
        [[MySocket singleton].sRWebSocket send:pushBean.JSONString];
        VSInfoViewController *vsCtrl = [[VSInfoViewController alloc] init];
        vsCtrl.joinCD24 = 24 - (int) seconds;
        vsCtrl.isAccept = YES;
        vsCtrl.friendId = _fid;
        vsCtrl.friendModel = userInfo;
        [self.navigationController pushViewController:vsCtrl animated:YES];
    }
}

- (void)didReceiveMessage:(NSNotification *)notification {
    NSString *message = [notification object];
    PushBean *pushBean = [PushBean objectWithKeyValues:message];
    if (pushBean) {
        NSString *action = pushBean.action;
        
        if (action.length > 0 && [action isEqualToString:@"challenge"])
        {
            if ([CMOpenALSoundManager singleton])
            {
                [[CMOpenALSoundManager singleton] playSoundWithID:8];
            }
            
            beanTime = pushBean.pushTime;
            NSLog(@"##beanTime:%@", beanTime);
            //        Challenger *challenger = [[Challenger alloc] init];
            //        challenger.fid = pushBean.uid.intValue;
            //        challenger.userName = pushBean.userName;
            //         challenger.avatar = pushBean.avatar;
            
            UserInfo *userInfo = pushBean.userInfo;
            
            if (!challengerArr) {
                challengerArr = [[NSMutableArray alloc] init];
            }
            
            if (userInfo)
            {
                [challengerArr addObject:userInfo];
                
                if (challengerArr && challengerArr.count > 0)
                {
                    chaView.hidden = NO;
                   [self.ChallengeView setHidden:NO];
                   [self.ChallengeUserImage sd_setImageWithURL:[NSURL URLWithString:userInfo.avatar] placeholderImage:[UIImage imageNamed:@"ImagePlaceholder"]];
                   [self.challengeNameLabel setText:[NSString stringWithFormat:@"%@ %@",userInfo.firstname,userInfo.lastname]];
                    
//                    NSString *stringRate = [[self._userArray objectAtIndex:indexPath.row]valueForKey:@"number_win"];
//                    int level = 0;
//                    
//                    if ([stringRate intValue]>0 && [stringRate intValue]<= 4)
//                    {
//                        level = 1;
//                    }
//                    else if ([stringRate intValue]>4 && [stringRate intValue]<= 24){
//                        level = 2;
//                        
//                    }
//                    else if ([stringRate intValue]>24 && [stringRate intValue]<= 74){
//                        level = 3;
//                        
//                    }
//                    else if ([stringRate intValue]>74 && [stringRate intValue]<= 124){
//                        level = 4;
//                        
//                    }
//                    else if ([stringRate intValue]>124){
//                        level = 5;
//                    }
                }
            }
            
            //[chaView setInfo:challengerArr];
        }
    }
}

-(void)viewWillAppear:(BOOL)animated

{

    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,     NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *getImagePath = [documentsDirectory stringByAppendingPathComponent:@"myfile.png"];
    UIImage *img = [UIImage imageWithContentsOfFile:getImagePath];
    if (img != nil) {
      [self.largeImage setImage:img];
    }
    else{
        [self.largeImage setImage:img];
    }
    
    
    
    if (![[[NSUserDefaults standardUserDefaults] objectForKey:@"CheckMusic"]isEqualToString:@"MusicOff"])
    {
        if (![LanbaooPrefs sharedInstance].musicOff)
        {
            [[CMOpenALSoundManager singleton] playBackgroundMusic:@"Mind-Gym-Main.mp3"];
        }
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
<<<<<<< Updated upstream
=======
    self.navigationController.navigationBarHidden = YES;
    [self getChallenger];
    
    
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
    
    //[self HomeButtonMethod:nil];
    
>>>>>>> Stashed changes
    
}

-(void)viewDidAppear:(BOOL)animated{
    
    UIImageView *imageSlider = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 219, 568)];
    [imageSlider setImage:[UIImage imageNamed:@"MenuScreen"]];
<<<<<<< Updated upstream
    //[self.SliderView addSubview:imageSlider];
    [self SliderUi];
    [self HomeButtonMethod:nil];
=======
    hasNextPage = YES;
    //[self.SliderView addSubview:imageSlider];
    
    
    //[self RankDataService];
    [self FrendsButtonMethod:nil];
    
    [self challengeViewSetUp];
    
    
    UISwipeGestureRecognizer *swipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(SwipeView:)];
    [swipe setDirection:UISwipeGestureRecognizerDirectionRight];
    [[self MainFrontView] addGestureRecognizer: swipe];
    
    UISwipeGestureRecognizer *swipeLeftMain = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(SwipeView:)];
    [swipeLeftMain setDirection:UISwipeGestureRecognizerDirectionLeft];
    [[self MainFrontView] addGestureRecognizer: swipeLeftMain];
    
    
    UISwipeGestureRecognizer *swipeleft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(SwipeView:)];
    [swipeleft setDirection:UISwipeGestureRecognizerDirectionLeft];
    [[self SliderView] addGestureRecognizer: swipeleft];
    
>>>>>>> Stashed changes
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
    userid = [uid intValue];
    if (uid.length == 0 || uid.intValue == 0)
    {
        return;
    }
    
    NSDictionary *parameters = @{
                                 @"command" : @"index_rank",
                                 @"uid" : uid,
                                 };
    
    [manager GET:mURL parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *data = responseObject;
        if ([data[@"data"] isKindOfClass:[NSDictionary class]]) {
            
            NSLog(@"%@",data);
            UserInfo *userInfo = [UserInfo objectWithKeyValues:data[@"data"]];
            [ImagePropilepic sd_setImageWithURL:[NSURL URLWithString:[userInfo valueForKey:@"avatar"]] placeholderImage:[UIImage imageNamed:@"PlaceholderImageWithoutBorder"]];
            [self.NameLabel setText:[NSString stringWithFormat:@"%@ %@",[userInfo valueForKey:@"firstname"],[userInfo valueForKey:@"lastname"]]];
           
             [ImagePropilepicSlider sd_setImageWithURL:[NSURL URLWithString:[userInfo valueForKey:@"avatar"]] placeholderImage:[UIImage imageNamed:@"PlaceholderImageWithoutBorder"]];
            NSString *stringUserInfoImage =[userInfo valueForKey:@"avatar"];
            
            [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%@ %@",[userInfo valueForKey:@"firstname"],[userInfo valueForKey:@"lastname"]] forKey:@"SaveUserName"];
            [[NSUserDefaults standardUserDefaults] setObject:stringUserInfoImage forKey:@"SaveImageUrl"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            
            UIImageView *SelfRate1 = [[UIImageView alloc] initWithFrame:CGRectMake(120, 158, 12, 11)];
            [SelfRate1 setImage:[UIImage imageNamed:@"Unstar"]];
            [self.MainFrontView addSubview:SelfRate1];
            
            UIImageView *SelfRate2 = [[UIImageView alloc] initWithFrame:CGRectMake(135, 158, 12, 11)];
            [SelfRate2 setImage:[UIImage imageNamed:@"Unstar"]];
            [self.MainFrontView addSubview:SelfRate2];
            
            UIImageView *SelfRate3 = [[UIImageView alloc] initWithFrame:CGRectMake(150, 158, 12, 11)];
            [SelfRate3 setImage:[UIImage imageNamed:@"Unstar"]];
            [self.MainFrontView addSubview:SelfRate3];
            
            UIImageView *SelfRate4 = [[UIImageView alloc] initWithFrame:CGRectMake(165, 158, 12, 11)];
            [SelfRate4 setImage:[UIImage imageNamed:@"Unstar"]];
            [self.MainFrontView addSubview:SelfRate4];

            UIImageView *SelfRate5 = [[UIImageView alloc] initWithFrame:CGRectMake(180, 158, 12, 11)];
            [SelfRate5 setImage:[UIImage imageNamed:@"Unstar"]];
            [self.MainFrontView addSubview:SelfRate5];
            
            
            
            NSString *stringRate = [userInfo valueForKey:@"number_win"];
            int level = 0;
            
            if ([stringRate intValue]>0 && [stringRate intValue]<= 4)
            {
                level = 1;
                [SelfRate1 setImage:[UIImage imageNamed:@"StarIcon"]];
            }
            else if ([stringRate intValue]>4 && [stringRate intValue]<= 24){
                level = 2;
                [SelfRate1 setImage:[UIImage imageNamed:@"StarIcon"]];
                [SelfRate2 setImage:[UIImage imageNamed:@"StarIcon"]];
                
            }
            else if ([stringRate intValue]>24 && [stringRate intValue]<= 74){
                level = 3;
                [SelfRate1 setImage:[UIImage imageNamed:@"StarIcon"]];
                [SelfRate2 setImage:[UIImage imageNamed:@"StarIcon"]];
                [SelfRate3 setImage:[UIImage imageNamed:@"StarIcon"]];
                
            }
            else if ([stringRate intValue]>74 && [stringRate intValue]<= 124){
                level = 4;
                [SelfRate1 setImage:[UIImage imageNamed:@"StarIcon"]];
                [SelfRate2 setImage:[UIImage imageNamed:@"StarIcon"]];
                [SelfRate3 setImage:[UIImage imageNamed:@"StarIcon"]];
                [SelfRate4 setImage:[UIImage imageNamed:@"StarIcon"]];
                
            }
            else if ([stringRate intValue]>124){
                level = 5;
                [SelfRate1 setImage:[UIImage imageNamed:@"StarIcon"]];
                [SelfRate2 setImage:[UIImage imageNamed:@"StarIcon"]];
                [SelfRate3 setImage:[UIImage imageNamed:@"StarIcon"]];
                [SelfRate4 setImage:[UIImage imageNamed:@"StarIcon"]];
                [SelfRate5 setImage:[UIImage imageNamed:@"StarIcon"]];
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
            [laebelPoint setText:@"Points"];
            [laebelPoint setFont:[UIFont fontWithName:@"Montserrat-Regular" size:10.0]];
            [laebelPoint setTextColor:[UIColor whiteColor]];
            [laebelPoint setTextAlignment:NSTextAlignmentCenter];
            [self.MainFrontView addSubview:laebelPoint];
            
            
            UILabel *laebelPointValue = [[UILabel alloc] initWithFrame:CGRectMake(81, 235, 80, 30)];
            [laebelPointValue setText:[NSString stringWithFormat:@"%i",[[userInfo valueForKey:@"points_total"] intValue]]];
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

           // int count = userInfo.getNumber_lost() + userInfo.getNumber_tie() + userInfo.getNumber_win();

            int count = [[userInfo valueForKey:@"number_lost"] intValue] + [[userInfo valueForKey:@"number_tie"] intValue] + [[userInfo valueForKey:@"number_win"] intValue] ;
            
            if (count >0) {
                count = [[userInfo valueForKey:@"points_total"] intValue] / count ;
            }
            UILabel *laebelPPgValue = [[UILabel alloc] initWithFrame:CGRectMake(162, 235, 80, 30)];
            [laebelPPgValue setText:[NSString stringWithFormat:@"%i",count]];
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
            [laebelWLValue setText:[NSString stringWithFormat:@"%i-%i",[[userInfo valueForKey:@"number_win"] intValue],[[userInfo valueForKey:@"number_lost"] intValue]]];
            [laebelWLValue setTextAlignment:NSTextAlignmentCenter];
            [laebelWLValue setFont:[UIFont fontWithName:@"Montserrat-Regular" size:14.0]];
            [laebelWLValue setTextColor:[UIColor whiteColor]];
            [laebelWLValue setBackgroundColor:[UIColor clearColor]];
            [self.MainFrontView addSubview:laebelWLValue];
            
<<<<<<< Updated upstream
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
            
=======
>>>>>>> Stashed changes

            
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
<<<<<<< Updated upstream
-(void)SegMentsCustom{
=======
-(void)SegMentsCustom

{
>>>>>>> Stashed changes
    
    UIView *viewSegment = [[UIView alloc] initWithFrame:CGRectMake(0, 287, 320, 40)];
    [viewSegment setBackgroundColor:[UIColor whiteColor]];
    [self.MainFrontView addSubview:viewSegment];
    
    self.FrendsLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 2, 80, 30)];
    [self.FrendsLabel setText:@"Friends"];
    [self.FrendsLabel setTextAlignment:NSTextAlignmentCenter];
<<<<<<< Updated upstream
    [self.FrendsLabel setFont:[UIFont fontWithName:@"Montserrat-Regular" size:15.0]];
=======
    [self.FrendsLabel setFont:[UIFont fontWithName:@"Montserrat-SemiBold" size:15.0]];
>>>>>>> Stashed changes
    [self.FrendsLabel setTextColor:[UIColor colorWithRed:215.0/255.0 green:216.0/255.0 blue:221.0/255.0 alpha:1.0]];
    [viewSegment addSubview:self.FrendsLabel];
    
    self.BottomImageFrend = [[UIImageView alloc] initWithFrame:CGRectMake(0, 30, 107, 8)];
    [self.BottomImageFrend setImage:[UIImage imageNamed:@"BlueArrowLine"]];
    [viewSegment addSubview:self.BottomImageFrend];
    
    self.Top100Label = [[UILabel alloc] initWithFrame:CGRectMake(107, 2, 80, 30)];
    [self.Top100Label setText:@"Top 100"];
    [self.Top100Label setTextAlignment:NSTextAlignmentCenter];
<<<<<<< Updated upstream
    [self.Top100Label setFont:[UIFont fontWithName:@"Montserrat-Regular" size:15.0]];
=======
    [self.Top100Label setFont:[UIFont fontWithName:@"Montserrat-SemiBold" size:15.0]];
>>>>>>> Stashed changes
    [self.Top100Label setTextColor:[UIColor colorWithRed:215.0/255.0 green:216.0/255.0 blue:221.0/255.0 alpha:1.0]];
    [viewSegment addSubview:self.Top100Label];
    
    self.Bottom100Image = [[UIImageView alloc] initWithFrame:CGRectMake(107, 30, 107, 8)];
    [self.Bottom100Image setImage:[UIImage imageNamed:@"BlueArrowLine"]];
    [viewSegment addSubview:self.Bottom100Image];
    
    self.VerifiedLabel = [[UILabel alloc] initWithFrame:CGRectMake(217, 2, 80, 30)];
    [self.VerifiedLabel setText:@"Verified"];
    [self.VerifiedLabel setTextAlignment:NSTextAlignmentCenter];
<<<<<<< Updated upstream
    [self.VerifiedLabel setFont:[UIFont fontWithName:@"Montserrat-Regular" size:15.0]];
=======
    [self.VerifiedLabel setFont:[UIFont fontWithName:@"Montserrat-SemiBold" size:15.0]];
>>>>>>> Stashed changes
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
<<<<<<< Updated upstream
    
=======
    stringButtonOption = @"Friends";
    self.isFindFriend = YES;
    rankType = friendType;
    [self RankDataService];
    

>>>>>>> Stashed changes
}

-(void)Top100ButtonMethod:(id)Sender{
    
<<<<<<< Updated upstream
=======
    stringButtonOption = @"Top100";
    
>>>>>>> Stashed changes
    [self.Bottom100Image setHidden:NO];
    [self.verifiedBottom setHidden:YES];
    [self.BottomImageFrend setHidden:YES];
    
    [self.FrendsLabel setTextColor:[UIColor colorWithRed:215.0/255.0 green:216.0/255.0 blue:221.0/255.0 alpha:1.0]];
    [self.Top100Label setTextColor:[UIColor colorWithRed:44.0/255.0 green:151.0/255.0 blue:222.0/255.0 alpha:1.0]];
    [self.VerifiedLabel setTextColor:[UIColor colorWithRed:215.0/255.0 green:216.0/255.0 blue:221.0/255.0 alpha:1.0]];
    
<<<<<<< Updated upstream
    
}
-(void)ButtonVerifiedMethod:(id)Sender{
=======
    self.isFindFriend = NO;
    rankType = top100Type;
    [self RankDataService];
    
    
}

-(void)ButtonVerifiedMethod:(id)Sender
{
    stringButtonOption = @"Verify";
>>>>>>> Stashed changes
    
    [self.Bottom100Image setHidden:YES];
    [self.verifiedBottom setHidden:NO];
    [self.BottomImageFrend setHidden:YES];
    
    [self.FrendsLabel setTextColor:[UIColor colorWithRed:215.0/255.0 green:216.0/255.0 blue:221.0/255.0 alpha:1.0]];
    [self.Top100Label setTextColor:[UIColor colorWithRed:215.0/255.0 green:216.0/255.0 blue:221.0/255.0 alpha:1.0]];
    [self.VerifiedLabel setTextColor:[UIColor colorWithRed:44.0/255.0 green:151.0/255.0 blue:222.0/255.0 alpha:1.0]];
    
    
<<<<<<< Updated upstream
=======
   // self.isFindFriend = NO;
    rankType = thirdPartType;
    [self RankDataService];
    
>>>>>>> Stashed changes
}

#pragma mark UItableView Methods
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
<<<<<<< Updated upstream
    
    return 2;
=======
    if ([self._userArray count]>0) {
        return [self._userArray count];
    }
    else
    return 0;
>>>>>>> Stashed changes
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
<<<<<<< Updated upstream
=======
    [cell.NameLabel setText:[NSString stringWithFormat:@"%@ %@",[[self._userArray objectAtIndex:indexPath.row] valueForKey:@"firstname"],[[self._userArray objectAtIndex:indexPath.row] valueForKey:@"lastname"]]];
    
    CGSize yourLabelSize = [cell.NameLabel.text sizeWithAttributes:@{NSFontAttributeName : [UIFont fontWithName:@"Montserrat-Regular" size:13.0]}];
    
    [cell.NameLabel setFrame:CGRectMake(cell.NameLabel.frame.origin.x, cell.NameLabel.frame.origin.y, yourLabelSize.width, cell.NameLabel.frame.size.height)];
    

    //[cell.TickImage setFrame:CGRectMake(cell.NameLabel.frame.origin.x + yourLabelSize.width + 5, cell.TickImage.frame.origin.y, cell.TickImage.frame.size.height, cell.TickImage.frame.size.height)];
    
    [cell.NameLabel setFont:[UIFont fontWithName:@"Montserrat-Regular" size:13.0]];
    [cell.NameLabel setTextColor:[UIColor colorWithRed:44.0/255.0 green:62.0/255.0 blue:80.0/255 alpha:1.0]];
    
    [cell.WonLostLabel setText:[NSString stringWithFormat:@"%ldW-%ldL",[[[self._userArray objectAtIndex:indexPath.row] valueForKey:@"number_win"] integerValue],[[[self._userArray objectAtIndex:indexPath.row] valueForKey:@"number_lost"] integerValue]]];
    [cell.WonLostLabel setFont:[UIFont fontWithName:@"Montserrat-Light" size:10.0]];
    [cell.WonLostLabel setTextColor:[UIColor colorWithRed:44.0/255.0 green:62.0/255.0 blue:80.0/255 alpha:1.0]];
    
    [cell.ProfilePic sd_setImageWithURL:[NSURL URLWithString:[[self._userArray objectAtIndex:indexPath.row] valueForKey:@"avatar"]] placeholderImage:[UIImage imageNamed:@"PlaceholderImageWithoutBorder"]];
    
    [cell.ChallengeButton setTag:indexPath.row];
    if ([stringButtonOption isEqualToString:@"Top100"] || [stringButtonOption isEqualToString:@"Verify"]) {
        [cell.AddfriendButton setHidden:NO];
        [cell.ChallengeButton setFrame:CGRectMake(cell.ChallengeButton.frame.origin.x, 34, cell.ChallengeButton.frame.size.width, cell.ChallengeButton.frame.size.height)];
        [cell.AddfriendButton setTag:indexPath.row];
        
    }
    else{
        [cell.AddfriendButton setHidden:YES];
        [cell.ChallengeButton setFrame:CGRectMake(cell.ChallengeButton.frame.origin.x, 22, cell.ChallengeButton.frame.size.width, cell.ChallengeButton.frame.size.height)];
        
        
    }
    
    [cell.PointsLabel setText:[NSString stringWithFormat:@"%i Points",[[[self._userArray objectAtIndex:indexPath.row] valueForKey:@"points_total"] intValue]]];
      [cell.PointsLabel setFont:[UIFont fontWithName:@"Montserrat-Light" size:10.0]];
    
                               
    
    NSString *stringRate = [[self._userArray objectAtIndex:indexPath.row]valueForKey:@"number_win"];
    int level = 0;

    if ([stringRate intValue]>0 && [stringRate intValue]<= 4)
    {
        level = 1;
    }
    else if ([stringRate intValue]>4 && [stringRate intValue]<= 24){
        level = 2;
        
    }
    else if ([stringRate intValue]>24 && [stringRate intValue]<= 74){
        level = 3;
        
    }
    else if ([stringRate intValue]>74 && [stringRate intValue]<= 124){
        level = 4;
       
    }
    else if ([stringRate intValue]>124){
        level = 5;
    }
    
    if (level==1) {
       [cell.RateImage1 setImage:[UIImage imageNamed:@"UserRateslected"]];
    }
    else if (level ==2){
        [cell.RateImage1 setImage:[UIImage imageNamed:@"UserRateslected"]];

        [cell.RateImage2 setImage:[UIImage imageNamed:@"UserRateslected"]];
    }
    else if (level ==3){
        [cell.RateImage1 setImage:[UIImage imageNamed:@"UserRateslected"]];
        
        [cell.RateImage2 setImage:[UIImage imageNamed:@"UserRateslected"]];
        [cell.RateImage3 setImage:[UIImage imageNamed:@"UserRateslected"]];
    }
    else if (level ==4){
        [cell.RateImage1 setImage:[UIImage imageNamed:@"UserRateslected"]];
        
        [cell.RateImage2 setImage:[UIImage imageNamed:@"UserRateslected"]];
        [cell.RateImage3 setImage:[UIImage imageNamed:@"UserRateslected"]];
         [cell.RateImage4 setImage:[UIImage imageNamed:@"UserRateslected"]];
    }
    else if (level ==5){
        [cell.RateImage1 setImage:[UIImage imageNamed:@"UserRateslected"]];
        
        [cell.RateImage2 setImage:[UIImage imageNamed:@"UserRateslected"]];
        [cell.RateImage3 setImage:[UIImage imageNamed:@"UserRateslected"]];
        [cell.RateImage4 setImage:[UIImage imageNamed:@"UserRateslected"]];
        [cell.RateImage5 setImage:[UIImage imageNamed:@"UserRateslected"]];
    }
    
    
>>>>>>> Stashed changes
    
    return cell;
}

<<<<<<< Updated upstream
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
=======
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
>>>>>>> Stashed changes
    return 80;
}

#pragma mark ToMenuSlider
-(void)toMenuSlider
<<<<<<< Updated upstream

{
=======
{
    NSString *userId = [LanbaooPrefs sharedInstance].userId;
    
    if ([[CMOpenALSoundManager singleton] isBackGroundMusicPlaying]) {
        [[CMOpenALSoundManager singleton] stopBackgroundMusic];
    }
    
>>>>>>> Stashed changes
    if (self.SliderView.frame.origin.x == 0)
    {
        [UIView animateWithDuration:0.2 animations:^{
            [self.SliderView setFrame:CGRectMake(-219, 0, self.SliderView.frame.size.width, self.SliderView.frame.size.height)];
            [self.MainFrontView setFrame:CGRectMake(0, 0, self.MainFrontView.frame.size.width, self.MainFrontView.frame.size.height)];
<<<<<<< Updated upstream
=======
           if (![[[NSUserDefaults standardUserDefaults] objectForKey:@"CheckMusic"]isEqualToString:@"MusicOff"])
           {
               if (![LanbaooPrefs sharedInstance].musicOff) {
                   [[CMOpenALSoundManager singleton] playBackgroundMusic:@"Mind-Gym-Main.mp3"];
               }
           }
            
            
>>>>>>> Stashed changes
        }];
    }
    
    else if (self.SliderView.frame.origin.x == -219){
        [UIView animateWithDuration:0.2 animations:^{
            [self.SliderView setFrame:CGRectMake(0, 0, self.SliderView.frame.size.width, self.SliderView.frame.size.height)];
            [self.MainFrontView setFrame:CGRectMake(220, 0, self.MainFrontView.frame.size.width, self.MainFrontView.frame.size.height)];
<<<<<<< Updated upstream
=======
            if (![[[NSUserDefaults standardUserDefaults] objectForKey:@"CheckMusic"]isEqualToString:@"MusicOff"])
            {
                if (![LanbaooPrefs sharedInstance].musicOff) {
                    [[CMOpenALSoundManager singleton] playBackgroundMusic:@"Settings.mp3"];
                }
            }
            
           
            
>>>>>>> Stashed changes
        }];
    }
}


<<<<<<< Updated upstream
-(void)SliderUi{
    
=======
-(void)SliderUi
{
>>>>>>> Stashed changes
    UIImageView *imageProfile = [[UIImageView alloc] initWithFrame:CGRectMake(19, 34, 81, 80)];
    [imageProfile setImage:[UIImage imageNamed:@"SmallPlaceholder"]];
    [self.SliderView addSubview:imageProfile];
    
    
<<<<<<< Updated upstream
    UIImageView *ImagePropilepic = [[UIImageView alloc] initWithFrame:CGRectMake(25, 40, 69, 69)];
    [ImagePropilepic setImage:[UIImage imageNamed:@"Profilepic"]];
    ImagePropilepic.layer.cornerRadius = ImagePropilepic.layer.frame.size.width/2;
    [ImagePropilepic setClipsToBounds:YES];
    [self.SliderView addSubview:ImagePropilepic];
=======
    ImagePropilepicSlider = [[UIImageView alloc] initWithFrame:CGRectMake(25, 40, 69, 69)];
   // [ImagePropilepic12 setImage:[UIImage imageNamed:@"PlaceholderImageWithoutBorder"]];
   
    ImagePropilepicSlider.layer.cornerRadius = ImagePropilepicSlider.layer.frame.size.width/2;
    [ImagePropilepicSlider setClipsToBounds:YES];
    [self.SliderView addSubview:ImagePropilepicSlider];
>>>>>>> Stashed changes
    
    
    UIButton *MyProfile = [UIButton buttonWithType:UIButtonTypeCustom];
    [MyProfile addTarget:self
<<<<<<< Updated upstream
                     action:@selector(Top100ButtonMethod:)
=======
                     action:@selector(MyProfileButtonMethod:)
>>>>>>> Stashed changes
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
<<<<<<< Updated upstream
=======
    
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"CheckNotification"]isEqualToString:@"NotificationOff"]) {
        [switchnotofication setOn:NO];
        [[LanbaooPrefs sharedInstance] setNotificationOff:YES];
    }
    else{
        [switchnotofication setOn:YES];
        [[LanbaooPrefs sharedInstance] setNotificationOff:NO];
    }
    
    
>>>>>>> Stashed changes
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
<<<<<<< Updated upstream
=======
    
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"CheckMusic"]isEqualToString:@"MusicOff"]) {
        [switchnotoficationMusic setOn:NO];
    }
    else{
        [switchnotoficationMusic setOn:YES];
    }
    
    
>>>>>>> Stashed changes
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
<<<<<<< Updated upstream
=======
    [switchSound setOn:YES];
>>>>>>> Stashed changes
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
<<<<<<< Updated upstream

=======
    
    
    
#pragma mark Challengeview
    self.ChallengeView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    [self.ChallengeView setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"ChallengeImage"]]];
    [self.view addSubview:self.ChallengeView];
    [self.ChallengeView setHidden:YES];
    
    
    self.ChallengeUserImage = [[UIImageView alloc] initWithFrame:CGRectMake(121, 140, 79, 80)];
    [self.ChallengeUserImage setImage:[UIImage imageNamed:@"SmallPlaceholder"]];
    [self.ChallengeView addSubview:self.ChallengeUserImage];
    
    
    self.challengeNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(90, 220, 140, 30)];
    [self.challengeNameLabel setTextAlignment:NSTextAlignmentCenter];
    [self.challengeNameLabel setFont:[UIFont fontWithName:@"Montserrat-Regular" size:14.0]];
    [self.challengeNameLabel setBackgroundColor:[UIColor clearColor]];
    [self.ChallengeView addSubview:self.challengeNameLabel];
    
    self.challengeRate1 = [[UIImageView alloc] initWithFrame:CGRectMake(120, 260, 12, 11)];
    [self.challengeRate1 setImage:[UIImage imageNamed:@"userRateUnselect"]];
    [self.ChallengeView addSubview:self.challengeRate1];
    
    self.Challengerate2 = [[UIImageView alloc] initWithFrame:CGRectMake(135, 260, 12, 11)];
    [self.Challengerate2 setImage:[UIImage imageNamed:@"userRateUnselect"]];
    [self.ChallengeView addSubview:self.Challengerate2];
    
    self.challengerate3 = [[UIImageView alloc] initWithFrame:CGRectMake(150, 260, 12, 11)];
    [self.challengerate3 setImage:[UIImage imageNamed:@"userRateUnselect"]];
    [self.ChallengeView addSubview:self.challengerate3];
    
    self.challengerate4 = [[UIImageView alloc] initWithFrame:CGRectMake(165, 260, 12, 11)];
    [self.challengerate4 setImage:[UIImage imageNamed:@"userRateUnselect"]];
    [self.ChallengeView addSubview:self.challengerate4];
    
    self.challengerate5= [[UIImageView alloc] initWithFrame:CGRectMake(180, 260, 12, 11)];
    [self.challengerate5 setImage:[UIImage imageNamed:@"userRateUnselect"]];
    [self.ChallengeView addSubview:self.challengerate5];
>>>>>>> Stashed changes
    
    
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
    
    
<<<<<<< Updated upstream

    
    
=======
  //  AnswerViewController *answer = [[AnswerViewController alloc] init];
   // [self.navigationController pushViewController:answer animated:NO];
    
    YesterDayViewController *yesterDayAnswer = [[YesterDayViewController alloc] init];
    [self presentViewController:yesterDayAnswer animated:YES completion:NULL];
>>>>>>> Stashed changes
    
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
<<<<<<< Updated upstream
=======
    
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.fancardinc.com/mindgym.html"]];
>>>>>>> Stashed changes

    
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
<<<<<<< Updated upstream

    
    
=======
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.fancardinc.com/contact.html"]];
    

>>>>>>> Stashed changes
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
<<<<<<< Updated upstream
=======
    
    
    if ([[CMOpenALSoundManager singleton] isBackGroundMusicPlaying]) {
        [[CMOpenALSoundManager singleton] stopBackgroundMusic];
    }
    [[CMOpenALSoundManager singleton] purgeSounds];
    NSLog(@"######select LogOut");
    
    LKDBHelper *globalHelper = [UserInfo getUsingLKDBHelper];
    [globalHelper dropTableWithClass:[UserInfo class]];
    
    [LanbaooPrefs sharedInstance].userId = nil;
    [self resetDefaults];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"CheckNotification"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"SaveUserName"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"SaveImageUrl"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"CheckMusic"];
    [[NSUserDefaults standardUserDefaults] synchronize];
   [self welcomePage];
   
//    for (UIViewController* viewController in self.navigationController.viewControllers) {
//        
//        //This if condition checks whether the viewController's class is MyGroupViewController
//        // if true that means its the MyGroupViewController (which has been pushed at some point)
//        if ([viewController isKindOfClass:[WelcomeViewController class]] ) {
//            
//            // Here viewController is a reference of UIViewController base class of MyGroupViewController
//            // but viewController holds MyGroupViewController  object so we can type cast it here
//            WelcomeViewController *groupViewController = (WelcomeViewController*)viewController;
//            [self.navigationController popToViewController:groupViewController animated:YES];
//        }
//    }
//    
>>>>>>> Stashed changes


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
<<<<<<< Updated upstream
=======
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.fancardinc.com/terms.html"]];
>>>>>>> Stashed changes

    
    
}


-(void)NotificationSwitch:(UISwitch *)switchh{
<<<<<<< Updated upstream
    
}
-(void)MusicsMethod:(UISwitch *)switchj{
    
}
-(void)SoundMethod:(UISwitch *)ghg{
    
}
=======
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"CheckNotification"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    if ([switchh isOn]) {
        
        
        [[LanbaooPrefs sharedInstance] setNotificationOff:NO];
    }
    else
    {
     
        [[NSUserDefaults standardUserDefaults] setObject:@"NotificationOff" forKey:@"CheckNotification"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        [[LanbaooPrefs sharedInstance] setNotificationOff:YES];
    }
}

-(void)MusicsMethod:(UISwitch *)switchj
{
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"CheckMusic"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    if ([switchj isOn])
    {
        
        if (self.SliderView.frame.origin.x == 0)
        {
          
            if (![LanbaooPrefs sharedInstance].musicOff)
            {
               
                [[CMOpenALSoundManager singleton] playBackgroundMusic:@"Settings.mp3"];
              }

        }
        
        else if (self.SliderView.frame.origin.x == -219)
        {
            if (![LanbaooPrefs sharedInstance].musicOff)
            {
                 [[CMOpenALSoundManager singleton] playBackgroundMusic:@"Mind-Gym-Main.mp3"];
            }
        }
    }
    else
    {
        if ([[CMOpenALSoundManager singleton] isBackGroundMusicPlaying]) {
            [[CMOpenALSoundManager singleton] stopBackgroundMusic];
        }
        [[NSUserDefaults standardUserDefaults] setObject:@"MusicOff" forKey:@"CheckMusic"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}
-(void)SoundMethod:(UISwitch *)ghg{
    
}

#pragma mark Call ServiceTableData 
-(void)RankDataService{
    [self._userArray removeAllObjects];
    self._userArray = nil;
    NSDictionary *parameters = [NSDictionary new];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    parameters = @{@"command" : @"rank_list",
                   @"time" : @(listTimeType),
                   @"uid" : @(userid),
                   @"type" : @(rankType),
                   @"p" : @(1),
                   @"s" : @(10),
                   };
    
    
    [manager GET:kServerURL
      parameters:parameters
         success:^(AFHTTPRequestOperation *operation, id responseObject) {
             LLog(@"operation.response.URL.absoluteString = %@", operation.response.URL.absoluteString);
             
             if (!self._userArray || page == 1) {
                 self._userArray = [[NSMutableArray alloc] init];
             }
             
             //[self hideHUD];
             //             NSLog(@"JSON: %@", responseObject);
             NSDictionary *dic = (NSDictionary *) [responseObject objectForKey:@"data"];
             NSMutableArray *arrayDic = dic[@"result"];
             NSMutableArray *userArray = [UserInfo objectArrayWithKeyValuesArray:arrayDic];
             //             if (_userArray.count == 0) {
             //                 UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Alert"
             //                                                                     message:@"Add some friends from top100!"
             //                                                                    delegate:nil
             //                                                           cancelButtonTitle:@"OK"
             //                                                           otherButtonTitles:nil];
             //                 [alertView show];
             //             }
             
             if (userArray && userArray.count > 0) {
                 [self._userArray addObjectsFromArray:userArray];
             }
             
             [self.tableDetail reloadData];
             
             NSLog(@"---%lu", (unsigned long) self._userArray.count);
             //             for (TopHundredModel *tops in _userArray) {
             //
             //                 NSLog(@"id=%d", tops.id);
             //             }
             
             hasNextPage = [dic getBool:@"hasNext"];
            // self.tableView.mj_footer.hidden = (_userArray.count < pageSize);
             if (hasNextPage) {
                 page++;
             }
             
             if (rankType == top100Type) {
                 if (page > 10) {
                     hasNextPage = NO;
                 }
             }
             
             
         } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
             NSLog(@"Error: %@", error);
             //                [self _parseJson];
            
         }];
    
}


#pragma mark AddFriend

-(IBAction)AddfRIEND:(UIButton *)BUTT{
    NSString *strinUserid = [[self._userArray objectAtIndex:[BUTT tag]] valueForKey:@"id"];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSDictionary *parameters = @{
                                 @"command" : @"add_friends",
                                 @"uid" : [NSString stringWithFormat:@"%i",userid],
                                 @"fid" : strinUserid
                                 };
    [manager POST:kServerURL
       parameters:parameters
          success:^(AFHTTPRequestOperation *operation, id responseObject) {
              
              NSLog(@"JSON:%@", responseObject);
              NSString *message = [responseObject objectForKey:@"message"];
              if ([message isEqualToString:@"he is your friend,you can not add again"]) {
                  message = @"already your friend!";
                  
                  [[[UIAlertView alloc] initWithTitle:@"Alert!!" message:message delegate:self cancelButtonTitle:@"Okay" otherButtonTitles: nil] show];
                  
              } else {
                  //                  [self showHUdComplete:message];
                  [[[UIAlertView alloc] initWithTitle:@"Alert!!" message:message delegate:self cancelButtonTitle:@"Okay" otherButtonTitles: nil] show];
              }
              
          } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
              NSLog(@"Error:%@", error);
              //[self showHUdCompleteWithTitle:@"check the network!"];
              [[[UIAlertView alloc] initWithTitle:@"Alert!!" message:@"Check the Network" delegate:self cancelButtonTitle:@"Okay" otherButtonTitles: nil] show];
          }];

}


-(IBAction)ChallengeButtonMethod:(UIButton *)button{
   // int type = userModels.type.intValue;
    //UserInfo *_userModel;
    int Type = [[[self._userArray objectAtIndex:[button tag]] valueForKey:@"type"] intValue];
    
    //_userModel = userModels;
    NSString *alertString = @"alert";
    
    if (Type == 3 || userUserId == [[[self._userArray objectAtIndex:[button tag]] valueForKey:@"id"] intValue]) {
        if (userUserId == userid) {
            alertString = @"Yourself!";
        } else {
            alertString = @"User has already played VS a Friend today!";
        }
        [[CMOpenALSoundManager singleton] playSoundWithID:3];
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Alert"
                                                            message:alertString
                                                           delegate:nil
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil];
        [alertView show];
    } else {
        
        UserInfo *userInfo = [UserInfo searchSingleWithWhere:nil orderBy:nil];
        
        NSString *dateStr = userInfo.lastFrdFight;
        NSDate *dateFight = [dateStr getDateWithFormat:kDateFormat];
        
        NSDate *dateNow = [NSDate new];
        NSString *dateNowStr = [dateNow getDateStrWithFormat:@"yyyy-MM-dd"];
        
        if (dateFight) {
            
            if ([dateNowStr isEqualToString:[dateFight getDateStrWithFormat:@"yyyy-MM-dd"]]) {
                [[CMOpenALSoundManager singleton] playSoundWithID:3];
                [[[UIAlertView alloc] initWithTitle:@"Alert"
                                            message:@"You have already played today."
                                           delegate:nil
                                  cancelButtonTitle:@"OK"
                                  otherButtonTitles:nil] show];
                
                return;
            }
        }
        
        
        //dateStr = userModels.lastFrdFight;
        dateStr = [[self._userArray objectAtIndex:[button tag]] valueForKey:@"lastFrdFight"];
        dateFight = [dateStr getDateWithFormat:kDateFormat];
        
        if (dateFight) {
            if ([dateNowStr isEqualToString:[dateFight getDateStrWithFormat:@"yyyy-MM-dd"]]) {
                [[[UIAlertView alloc] initWithTitle:@"Alert"
                                            message:@"They have already played today."
                                           delegate:nil
                                  cancelButtonTitle:@"OK"
                                  otherButtonTitles:nil] show];
                
                return;
            }
        }
        
        //alert
        _background.hidden = NO;
        NSString *name = [NSString stringWithFormat:@"%@ %@", [[self._userArray objectAtIndex:[button tag]] valueForKey:@"firstname"], [[self._userArray objectAtIndex:[button tag]] valueForKey:@"lastname"]];
        _oppNameLabel.text = name;
       // _friendModel = userModels;
       // _friendModel.rank = rank;
        _friendId = [[[self._userArray objectAtIndex:[button tag]] valueForKey:@"id"] intValue];
    }
}


#pragma mark FindFriendButton
-(void)findFriendBtnClick:(id)sender{
    NSString *userId = [LanbaooPrefs sharedInstance].userId;
    
    if ([[CMOpenALSoundManager singleton] isBackGroundMusicPlaying]) {
        [[CMOpenALSoundManager singleton] stopBackgroundMusic];
    }
    
    if (userId.intValue == 0) {
        LogInViewController *loginVC = [[LogInViewController alloc] init];
        [self.navigationController pushViewController:loginVC animated:NO];
    } else {
//        LevelsFindFriendViewController *findFriend = [[LevelsFindFriendViewController alloc] init];
//        findFriend.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
//        [self.view.window.rootViewController presentViewController:findFriend animated:YES completion:nil];
        
      self.levelsFriends  = [[LevelsFriendsViewController alloc] init];
        [self.navigationController pushViewController:self.levelsFriends  animated:YES];
        
    }
}

#pragma mark QuickGameButtonMethod
- (void)QuickGame:(id)sender {
    
    NSString *userId = [LanbaooPrefs sharedInstance].userId;
    
    if (userId.intValue == 0) {
        [self welcomePage];
    } else {
        
        UserInfo *userInfo = [UserInfo searchSingleWithWhere:nil orderBy:nil];
        
        NSString *dateStr = userInfo.lastBotFight;
        NSDate *dateFight = [dateStr getDateWithFormat:kDateFormat];
        
        if (!dateFight) {
            [self bindingBot];
            return;
        }
        
        NSDate *dateNow = [NSDate new];
        NSString *dateNowStr = [dateNow getDateStrWithFormat:@"yyyy-MM-dd"];
        
        if ([dateNowStr isEqualToString:[dateFight getDateStrWithFormat:@"yyyy-MM-dd"]]) {
            
            [[CMOpenALSoundManager singleton] playSoundWithID:3];
            [[[UIAlertView alloc] initWithTitle:@"Alert"
                                        message:@"A new game will be available soon!"
                                       delegate:nil
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil] show];
            
            return;
        } else {
            [self bindingBot];
        }
        
    }
}


- (void)bindingBot
{
//[self showHUD:@"Loading..." isDim:NO];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSInteger useridLocal = [LanbaooPrefs sharedInstance].userId.intValue;
    
    NSDictionary *parameters = @{
                                 @"command" : @"bind_user_bot",
                                 @"id" : @(useridLocal)
                                 };
    [manager GET:kServerURL
      parameters:parameters
         success:^(AFHTTPRequestOperation *operation, id responseObject) {
            // [self hideHUD];
             NSLog(@"JSON:%@", responseObject);
             
             NSDictionary *botDic = [responseObject objectForKey:@"data"];
             
             [BotModel map];
             botModel = [BotModel objectWithKeyValues:botDic];
             
             [LanbaooPrefs sharedInstance].botId = botModel.botId;
             
             VSInfoViewController *info = [[VSInfoViewController alloc] init];
             info.botModel = botModel;
             [self.navigationController pushViewController:info animated:YES];
             
         } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
             NSLog(@"Error: %@", error);
         }];
}


#pragma mark ChallengeView
-(void)challengeViewSetUp{
    //-------------------------------alert view---------------------------------
    _background = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    [self.view addSubview:_background];
    _background.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.8f];
    _background.hidden = YES;
    
    _cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _cancelButton.frame = CGRectMake(kScreenWidth - 50, 10, 50, 50);
    [_cancelButton setImage:[UIImage imageNamed:@"btn_close"] forState:UIControlStateNormal];
    _cancelButton.imageEdgeInsets = UIEdgeInsetsMake(15, 15, 15, 15);
    [_cancelButton addTarget:self action:@selector(cancelAction) forControlEvents:UIControlEventTouchUpInside];
    [_background addSubview:_cancelButton];
    
    _challengeView = [[UIView alloc] init];
    _challengeView.backgroundColor = [UIColor whiteColor];
    [_background addSubview:_challengeView];
    [_challengeView autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:15.0f];
    [_challengeView autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:150.0f];
    [_challengeView autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:15.0f];
    [_challengeView autoSetDimension:ALDimensionHeight toSize:220.0f];
    _challengeView.userInteractionEnabled = YES;
    
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.text = @"Today's Challenge";
    [titleLabel setTextColor:[UIColor blackColor]];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = [UIFont fontWithName:kAsapRegularFont size:20.0f];
    [_challengeView addSubview:titleLabel];
    [titleLabel autoPinEdgeToSuperviewEdge:ALEdgeTop];
    [titleLabel autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:40.0f];
    [titleLabel autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:40.0f];
    [titleLabel autoSetDimension:ALDimensionHeight toSize:50.0f];
    
    UIButton *vsButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [vsButton setTitle:@"vs" forState:UIControlStateNormal];
    [vsButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    vsButton.titleLabel.font = [UIFont fontWithName:kAsapBoldFont size:14.0f];
    [vsButton.layer setMasksToBounds:YES];
    [vsButton.layer setCornerRadius:10.0f];
    vsButton.backgroundColor = [UIColor blackColor];
    [_challengeView addSubview:vsButton];
    [vsButton autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:40.0f];
    [vsButton autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:132.0f];
    [vsButton autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:132.0f];
    [vsButton autoSetDimension:ALDimensionHeight toSize:20.0f];
    
    UILabel *line1 = [[UILabel alloc] init];
    line1.backgroundColor = [UIColor blackColor];
    [_challengeView addSubview:line1];
    [line1 autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:49.0f];
    [line1 autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:5.0f];
    [line1 autoSetDimension:ALDimensionWidth toSize:120.0f];
    [line1 autoSetDimension:ALDimensionHeight toSize:1.0f];
    
    UILabel *line2 = [[UILabel alloc] init];
    line2.backgroundColor = [UIColor blackColor];
    [_challengeView addSubview:line2];
    [line2 autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:49.0f];
    [line2 autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:5.0f];
    [line2 autoSetDimension:ALDimensionWidth toSize:120.0f];
    [line2 autoSetDimension:ALDimensionHeight toSize:1.0f];
    
    _oppNameLabel = [[UILabel alloc] init];
    _oppNameLabel.text = @"FirstName LastName";
    [_oppNameLabel setTextColor:kMyBlue];
    _oppNameLabel.textAlignment = NSTextAlignmentCenter;
    _oppNameLabel.font = [UIFont fontWithName:kAsapRegularFont size:23.0f];
    [_challengeView addSubview:_oppNameLabel];
    [_oppNameLabel autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:50.0f];
    [_oppNameLabel autoPinEdgeToSuperviewEdge:ALEdgeLeft];
    [_oppNameLabel autoPinEdgeToSuperviewEdge:ALEdgeRight];
    [_oppNameLabel autoSetDimension:ALDimensionHeight toSize:50.0f];
    
    _buttonChallenge = [UIButton buttonWithType:UIButtonTypeCustom];
    _buttonChallenge.backgroundColor = [UIColor redColor];
    [_buttonChallenge setTitle:@"Challenge!" forState:UIControlStateNormal];
    [_buttonChallenge setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_buttonChallenge setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    _buttonChallenge.titleLabel.font = [UIFont boldSystemFontOfSize:40.0f];
    [_challengeView addSubview:_buttonChallenge];
    [_buttonChallenge autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:100.0f];
    [_buttonChallenge autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:5.0f];
    [_buttonChallenge autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:5.0f];
    [_buttonChallenge autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:30.0f];
    [_buttonChallenge addTarget:self action:@selector(chanllengeSomebody) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel *hintLabel = [[UILabel alloc] init];
    hintLabel.text = @"They will receive a notification to join the match!";
    [hintLabel setTextColor:[UIColor redColor]];
    hintLabel.textAlignment = NSTextAlignmentCenter;
    hintLabel.font = [UIFont fontWithName:kAsapRegularFont size:12.0f];
    [_challengeView addSubview:hintLabel];
    [hintLabel autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:190.0f];
    [hintLabel autoPinEdgeToSuperviewEdge:ALEdgeLeft];
    [hintLabel autoPinEdgeToSuperviewEdge:ALEdgeRight];
    [hintLabel autoPinEdgeToSuperviewEdge:ALEdgeBottom];
}

- (void)cancelAction {
    _background.hidden = YES;
}

- (void)chanllengeSomebody {
    if ([CMOpenALSoundManager singleton]) {
        [[CMOpenALSoundManager singleton] playSoundWithID:9];
    }
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSDictionary *parameters = @{
                                 @"command" : @"challenge_friend",
                                 @"uid" : @(userid),
                                 @"fid" : @(_friendId),
                                 };
    
    [manager GET:kServerURL
      parameters:parameters
         success:^(AFHTTPRequestOperation *operation, id responseObject)
    {
             NSLog(@"JSON: %@", responseObject);
             
             UserInfo *userInfo = [UserInfo searchSingleWithWhere:nil orderBy:nil];
             
             NSLog(@"challenge");
             PushBean *pushBean = [[PushBean alloc] init];
             pushBean.uid = @(userid).stringValue;
             pushBean.toUid = @(_friendId).stringValue;
             pushBean.userInfo = userInfo;
             pushBean.action = @"challenge";
             double gapTime = [LanbaooPrefs sharedInstance].gapTime;
             NSLog(@"gapTime:%f", gapTime);
             NSDate *tureTime = [[NSDate new] dateByAddingTimeInterval:gapTime];
             NSLog(@"tureTime:%@", tureTime);
             pushBean.pushTime = [tureTime getDateStrWithFormat:kDateFormat];
             if ([MySocket singleton].sRWebSocket.readyState == SR_OPEN) {
                 [[MySocket singleton].sRWebSocket send:pushBean.JSONString];
                 VSInfoViewController *vsCtrl = [[VSInfoViewController alloc] init];
                 vsCtrl.isChallenger = YES;
                 vsCtrl.friendId = _friendId;
                // vsCtrl.friendModel = _friendModel;
                 [self.navigationController pushViewController:vsCtrl animated:YES];
             }
             
         } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
             NSLog(@"Error: %@", error);
             _background.hidden = YES;
         }];
    
}



>>>>>>> Stashed changes
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
<<<<<<< Updated upstream
=======
}
- (void)getChallenger {
    NSString *uid = [LanbaooPrefs sharedInstance].userId;
    
    if (uid.length == 0) {
        return;
    }
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSDictionary *parameters = @{
                                 @"command" : @"get_challenger",
                                 @"uid" : uid
                                 };
    [manager GET:kServerURL
      parameters:parameters
         success:^(AFHTTPRequestOperation *operation, id responseObject) {
             NSLog(@"JSON: %@", responseObject);
             
             if (!responseObject) {
                 return;
             }
             
             UserInfo *userInfo = [UserInfo searchSingleWithWhere:nil orderBy:nil];
             
             NSString *dateStr = userInfo.lastBotFight;
             NSDate *dateFight = [dateStr getDateWithFormat:kDateFormat];
             
             if (dateFight) {
                 NSDate *dateNow = [NSDate new];
                 NSString *dateNowStr = [dateNow getDateStrWithFormat:@"yyyy-MM-dd"];
                 if ([dateNowStr isEqualToString:[dateFight getDateStrWithFormat:@"yyyy-MM-dd"]]) {
                     return;
                 }
             }
             
             NSDictionary *dict = responseObject;
             NSArray *arrayDic = [dict getArray:@"data"];
             
             challengerArr = [UserInfo objectArrayWithKeyValuesArray:arrayDic];
             
             if (challengerArr && challengerArr.count > 0) {
                 chaView.hidden = NO;
             }
             [chaView setInfo:challengerArr];
             
             
         } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
             NSLog(@"Error: %@", error);
         }];
}

-(void)SwipeView:(UISwipeGestureRecognizer *)swipeGesture{
    
    
    NSString *userId = [LanbaooPrefs sharedInstance].userId;
    
    if ([[CMOpenALSoundManager singleton] isBackGroundMusicPlaying]) {
        [[CMOpenALSoundManager singleton] stopBackgroundMusic];
    }
    
    if (swipeGesture.direction == UISwipeGestureRecognizerDirectionRight)
    {
      
        
        
         if (self.SliderView.frame.origin.x == -219){
            [UIView animateWithDuration:0.2 animations:^{
                [self.SliderView setFrame:CGRectMake(0, 0, self.SliderView.frame.size.width, self.SliderView.frame.size.height)];
                [self.MainFrontView setFrame:CGRectMake(220, 0, self.MainFrontView.frame.size.width, self.MainFrontView.frame.size.height)];
                if (![[[NSUserDefaults standardUserDefaults] objectForKey:@"CheckMusic"]isEqualToString:@"MusicOff"])
                {
                    if (![LanbaooPrefs sharedInstance].musicOff) {
                        [[CMOpenALSoundManager singleton] playBackgroundMusic:@"Settings.mp3"];
                    }
                }
                
                
                
            }];
        }
    }

   else if (swipeGesture.direction == UISwipeGestureRecognizerDirectionLeft)
    {
        if (self.SliderView.frame.origin.x == 0)
        {
            [UIView animateWithDuration:0.2 animations:^{
                [self.SliderView setFrame:CGRectMake(-219, 0, self.SliderView.frame.size.width, self.SliderView.frame.size.height)];
                [self.MainFrontView setFrame:CGRectMake(0, 0, self.MainFrontView.frame.size.width, self.MainFrontView.frame.size.height)];
                if (![[[NSUserDefaults standardUserDefaults] objectForKey:@"CheckMusic"]isEqualToString:@"MusicOff"])
                {
                    if (![LanbaooPrefs sharedInstance].musicOff) {
                        [[CMOpenALSoundManager singleton] playBackgroundMusic:@"Mind-Gym-Main.mp3"];
                    }
                }
                
                
            }];
        }
    }
}


-(void)MyProfileButtonMethod:(id)sender{
    ProfileViewController *profileView = [[ProfileViewController alloc] init];
    [self.navigationController pushViewController:profileView animated:YES];
}
- (void)resetDefaults {
    NSUserDefaults *defs = [NSUserDefaults standardUserDefaults];
    NSDictionary *dict = [defs dictionaryRepresentation];
    for (id key in dict) {
        [defs removeObjectForKey:key];
    }
    [defs synchronize];
>>>>>>> Stashed changes
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
