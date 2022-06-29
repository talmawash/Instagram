//
//  PostCell.m
//  Instagram
//
//  Created by Tariq Almawash on 6/27/22.
//

#import "PostCell.h"
#import "Parse/Parse.h"

@interface PostCell ()

@property (weak, nonatomic) IBOutlet UIImageView *imgPost;
@property (weak, nonatomic) IBOutlet UILabel *lblCaption;
@property (weak, nonatomic) IBOutlet UILabel *lblUser;
@property (weak, nonatomic) IBOutlet UILabel *lblDate;


@end

@implementation PostCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void) expand {
    if (self.lblDate.hidden) {
        self.lblCaption.numberOfLines = 0;
        self.lblDate.hidden = NO;
    }
    else {
        self.lblCaption.numberOfLines = 4;
        self.lblDate.hidden = YES;
    }
}

- (void)load {
    PFFileObject *img = self.post[@"image"];
    UIImage *image = [UIImage imageWithData:img.getData];
    [self.imgPost setImage:image];
    self.lblCaption.text = self.post[@"caption"];
    PFUser *user = self.post[@"user"];
    [user fetchIfNeeded];
    self.lblUser.text = [NSString stringWithFormat:@"@%@", user.username];
    self.lblCaption.numberOfLines = 4;
    NSDate* date = [((PFObject*)self.post) createdAt];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MMM d, h:mm a"];
    self.lblDate.text = [formatter stringFromDate:date];
    self.lblDate.hidden = YES;

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
