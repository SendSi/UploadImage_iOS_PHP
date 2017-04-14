//
//  AppDelegate.h
//  UploadImage_iOS_PHP
//
//  Created by u% on 17/4/14.
//  Copyright © 2017年 ming. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;


@end

