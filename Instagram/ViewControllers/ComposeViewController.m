//
//  ComposeViewController.m
//  Instagram
//
//  Created by Tariq Almawash on 6/27/22.
//

#import "ComposeViewController.h"
#import "Parse/Parse.h"

@interface ComposeViewController ()
@property (weak, nonatomic) IBOutlet UITextView *txtCaption;
@property (weak, nonatomic) IBOutlet UIImageView *imgPost;

@end

@implementation ComposeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIImagePickerController *imagePickerVC = [UIImagePickerController new];
    imagePickerVC.delegate = self;
    imagePickerVC.modalPresentationStyle = UIModalPresentationFullScreen;
    imagePickerVC.allowsEditing = NO;

    // The Xcode simulator does not support taking pictures, so let's first check that the camera is indeed supported on the device before trying to present it.
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        imagePickerVC.sourceType = UIImagePickerControllerSourceTypeCamera;
    }
    else {
        NSLog(@"Camera 🚫 available so we will use photo library instead");
        imagePickerVC.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }

    [self presentViewController:imagePickerVC animated:NO completion:nil];
    
    self.txtCaption.layer.borderWidth = 0.1f;
    self.txtCaption.layer.borderColor = [[UIColor blackColor] CGColor];
    [self.txtCaption becomeFirstResponder];
}

- (UIImage *)resizeImage:(UIImage *)image withSize:(CGSize)size {
    UIImageView *resizeImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, size.width, size.height)];
    
    resizeImageView.contentMode = UIViewContentModeScaleToFill;
    resizeImageView.image = image;
    
    UIGraphicsBeginImageContext(size);
    [resizeImageView.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [self dismissViewControllerAnimated:NO completion:nil];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    
    // Get the image captured by the UIImagePickerController

    UIImage *editedImage = info[UIImagePickerControllerOriginalImage];

    // Do something with the images (based on your use case)
    editedImage = [self resizeImage:editedImage withSize:CGSizeMake(374, 210.5)];
    [self.imgPost setImage:editedImage];
    // Dismiss UIImagePickerController to go back to your original view controller
    [self dismissViewControllerAnimated:NO completion:nil];
}


- (IBAction)share:(id)sender {
    PFObject *newPost = [PFObject objectWithClassName:@"Posts"];
    newPost[@"caption"] = self.txtCaption.text;
    newPost[@"image"] = [PFFileObject fileObjectWithData:UIImagePNGRepresentation(self.imgPost.image) contentType:@"image/png"];
    newPost[@"user"] = [PFUser currentUser];
    [newPost saveInBackgroundWithBlock:^(BOOL succeeded, NSError * error) {
        if (succeeded) {
            [self dismissViewControllerAnimated:true completion:nil];
        } else {
            NSLog(@"Problem saving message: %@", error.localizedDescription);
        }
    }];
}

- (IBAction)cancel:(id)sender {
    [self dismissViewControllerAnimated:true completion:nil];
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
