//
//  NavigationViewController.h
//  REMenuExample
//
//  Created by Roman Efimov on 4/18/13.
//  Copyright (c) 2013 Roman Efimov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "REMenu.h"
#import "SVProgressHUD.h"
#import "MMProgressHUDOverlayView.h"
#import "MMProgressHUD.h"

@interface NavigationViewController : UINavigationController

@property (strong, readonly, nonatomic) REMenu *menu;

- (void)toggleMenu;

@end
