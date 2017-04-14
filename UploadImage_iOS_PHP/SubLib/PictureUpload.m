//
//  PictureUpload.m
//  ChildCareExpert
//
//  Created by jiangjunwy on 15/11/4.
//  Copyright © 2015年 sanyou. All rights reserved.
//

#import "PictureUpload.h"
#import <MobileCoreServices/MobileCoreServices.h>
@interface PictureUpload ()<UIActionSheetDelegate,UINavigationControllerDelegate, UIImagePickerControllerDelegate>{
    
    UIViewController * showVC ;//出现截取照片功能的视图
    UIImageView      * showImageView ;//保存图片的容器
}
@end

@implementation PictureUpload

+(instancetype)sharedBase {
    static PictureUpload *sharedPictureUpload = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedPictureUpload = [[PictureUpload alloc] init];
        
    });
    return sharedPictureUpload;
}

-(void)initPictureUPload:(UIImageView *)imageView andShowVC:(UIViewController*)showViewController{
    
    showImageView = imageView ;
    showVC        = showViewController ;
    
    UIActionSheet* actionSheet = [[UIActionSheet alloc]
                                  initWithTitle:nil
                                  delegate:self
                                  cancelButtonTitle:@"取消"
                                  destructiveButtonTitle:nil
                                  otherButtonTitles:@"照相机",@"本地相簿",nil];
    [actionSheet showInView:showVC.view];
}
-(void)changePictureUploadAction:(changePictureUploadBlock)block{
    self.PictureUploadBlock = block ;
}
#pragma mark                 --------UIActionSheet Delegate--------
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (buttonIndex) {
        case 0://照相机
        {
            UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
            imagePicker.delegate = self;
            imagePicker.allowsEditing = YES;
            imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
            [showVC presentViewController:imagePicker animated:YES completion:nil];
        }
            break;
        case 1://本地相簿
        {
            UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
            imagePicker.delegate = self;
            imagePicker.allowsEditing = YES;
            imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            [showVC presentViewController:imagePicker animated:YES completion:nil];
        }
            break;
        default:
            break;
    }
}
#pragma mark           ----------UIImagePickerController Delegate---------
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    if ([[info objectForKey:UIImagePickerControllerMediaType] isEqualToString:(__bridge NSString *)kUTTypeImage]) {
        UIImage *img = [info objectForKey:UIImagePickerControllerEditedImage];
        [self performSelector:@selector(saveImage:)  withObject:img afterDelay:0.5];
    }
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)saveImage:(UIImage *)image {
    [showImageView setImage:image];
    self.PictureUploadBlock (image);
}
@end
