//
//  FrendsTableViewCell.h
//  fancard
//
//  Created by Mandeep on 28/01/16.
//  Copyright © 2016 MEETStudio. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FrendsTableViewCell : UITableViewCell
@property (nonatomic,retain) IBOutlet UIImageView *ProfilePic;
@property (nonatomic,retain) IBOutlet UILabel *LabelCount;
@property (nonatomic,retain) IBOutlet UIButton *ChallengeButton;
@end
