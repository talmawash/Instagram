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


@end

@implementation PostCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)load {
    PFFileObject *img = self.post[@"image"];
    UIImage *image = [UIImage imageWithData:img.getData];
    [self.imgPost setImage:image];
    self.lblCaption.text = self.post[@"caption"];
    PFUser *user = self.post[@"user"];
    [user fetchIfNeeded];
    self.lblUser.text = [NSString stringWithFormat:@"@%@", user.username];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
