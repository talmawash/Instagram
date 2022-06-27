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
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
