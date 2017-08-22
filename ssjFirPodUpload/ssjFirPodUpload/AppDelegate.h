//
//  AppDelegate.h
//  ssjFirPodUpload
//
//  Created by jssName on 2017/8/22.
//  Copyright © 2017年 jssName. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;


@end

