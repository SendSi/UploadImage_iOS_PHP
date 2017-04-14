//
//  ViewController.m
//  UploadImage_iOS_PHP
//
//  Created by u% on 17/4/14.
//  Copyright © 2017年 ming. All rights reserved.
//

#import "ViewController.h"
#import "PictureUpload.h"
#import "AFHTTPSessionManager.h"
#import "LEDPersonAPI.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.imageHeader.userInteractionEnabled=YES;
    [self.imageHeader lh_setTapActionWithBlock:^{
        [self modifyHeadImage];
    }];
}

-(void)modifyHeadImage{
    [[PictureUpload sharedBase] initPictureUPload:nil andShowVC:kKeyWindow.rootViewController];
    [[PictureUpload sharedBase] changePictureUploadAction:^(UIImage *image) {
        NSData *data = UIImageJPEGRepresentation(image, 0.3);
        [self upUserIcon:data];
        self.imageHeader.image=image;
    }];
}
//上传头像  AFN 3.0的上传方式  NSString * appendStr = [NSString stringWithFormat:@"data:image/png;base64,%@", imgStrBase64];//注意,看这个跟后台 协商,谁传
-(void)upUserIcon:(NSData *)iconData{
    NSString *imgStrBase64 = [iconData base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
    NSString *url=@"http://www.333f.com/xiaobaozi/index.php?g=Saleipadapp&m=Business&a=change_avatar";
    NSDictionary  *params= @{@"id":@"317",@"avatar":imgStrBase64};//

    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    

    [manager POST:url parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"success===%@",responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"fail===%@",error);
    }];
    
}
//上传头像  AFN 3.0的上传方式   NSString * appendStr = [NSString stringWithFormat:@"data:image/png;base64,%@", imgStrBase64];//注意,看这个跟后台 协商,谁传
-(void)upLoadAFNNot3:(NSData *)iconData{
//    UIImage * image = [UIImage imageNamed:@"37"];
//    NSData * imageData = UIImageJPEGRepresentation(image, 0.3); // 将图片转换成jpeg格式的NSData，压缩到0.3
//    NSString *encodedImageStr = [imageData base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
//    NSString *url=@"http://www.xbzgj.net/xbz_text/index.php?g=Saleipadapp&m=Business&a=change_avatar";
//    NSDictionary  *params= @{@"id":@"37",@"avatar":encodedImageStr};
//    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
//    // 采用POST的方式上传，因为POST对长度没有限制
//    [manager POST:url parameters:params success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
//        NSLog(@"success===%@",responseObject);
//    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
//        NSLog(@"fail===%@",error);
//    }];
}

//java上传图片
-(void)upUserIconJava:(NSData *)iconData{
    NSString *imgStrBase64 = [iconData base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
    NSString * appendStr = [NSString stringWithFormat:@"data:image/png;base64,%@", imgStrBase64];//注意,看这个跟后台 协商,谁传
    LEDPersonAPI *api= [[LEDPersonAPI alloc] init];
    [api HttpPostAsync:@"/user/upload_headimg_android" parameter: [NSString stringWithFormat:@"params=%@", appendStr] cb:^(NSDictionary *dict) {
        
    }];
}

- (void)didReceiveMemoryWarning {    [super didReceiveMemoryWarning];}


@end
