//
//  FirstPageViewController.m
//  Lesson2
//
//  Created by Admin on 12.10.15.
//  Copyright © 2015 Azat Almeev. All rights reserved.
//

#import "FirstPageViewController.h"
#import "FirstViewController.h"
#import "SecondViewController.h"
#import "ThirdViewController.h"

@interface FirstPageViewController ()
@property (nonatomic, retain) FirstViewController *firstViewController;
@property (nonatomic, retain) SecondViewController *secondViewController;
@property (nonatomic, retain) ThirdViewController *thirdViewController;
@end

@implementation FirstPageViewController



@synthesize firstViewController = _firstViewController;
@synthesize secondViewController = _secondViewController;
@synthesize thirdViewController = _thirdViewController;
- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataSource = self;
    [self setViewControllers:@[self.firstViewController]
                   direction:UIPageViewControllerNavigationDirectionForward
                    animated:YES
                  completion:nil];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (UIViewController *)presentViewController {
    return [self.storyboard instantiateViewControllerWithIdentifier:@"First"];
}

- (FirstViewController *)firstViewController {
    
    if (!_firstViewController) {
        UIStoryboard *storyboard = self.storyboard;
        _firstViewController = [storyboard instantiateViewControllerWithIdentifier:@"First"];
    }
    
    return _firstViewController;
}

- (SecondViewController *)secondViewController {
    
    if (!_secondViewController) {
        UIStoryboard *storyboard = self.storyboard;
        _secondViewController = [storyboard instantiateViewControllerWithIdentifier:@"Second"];
    }
    
    return _secondViewController;
}

- (ThirdViewController *)thirdViewController {
    
    if (!_thirdViewController) {
        UIStoryboard *storyboard = self.storyboard;
        _thirdViewController = [storyboard instantiateViewControllerWithIdentifier:@"Third"];
    }
    
    return _thirdViewController;
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
    UIViewController *prevViewController = nil;
    
    if (viewController == self.secondViewController) {
        prevViewController = self.firstViewController;
    }
    if (viewController == self.thirdViewController) {
        prevViewController = self.secondViewController;
    }
    return prevViewController;
    
    
    
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
    UIViewController *nextViewController = nil;
    
    if (viewController == self.firstViewController) {
        nextViewController = self.secondViewController;
    }
    if (viewController == self.secondViewController) {
        nextViewController = self.thirdViewController;
    }
    return nextViewController;
    
}



@end
