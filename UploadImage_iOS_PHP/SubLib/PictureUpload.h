//
//  PictureUpload.h
//  ChildCareExpert
//
//  Created by jiangjunwy on 15/11/4.
//  Copyright © 2015年 sanyou. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^changePictureUploadBlock)(UIImage * image);

@interface PictureUpload : NSObject
@property (nonatomic,strong) changePictureUploadBlock   PictureUploadBlock     ;

+(instancetype)sharedBase ;

//初始化图片上传获取
-(void)initPictureUPload:(UIImageView *)imageView andShowVC:(UIViewController*)showViewController;

//图片填写完毕后的block回调
-(void)changePictureUploadAction:(changePictureUploadBlock)block;

@end
