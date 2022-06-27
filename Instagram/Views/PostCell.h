//
//  PostCell.h
//  Instagram
//
//  Created by Tariq Almawash on 6/27/22.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PostCell : UITableViewCell

@property (weak, nonatomic) NSDictionary *post;

- (void)load;

@end

NS_ASSUME_NONNULL_END
