//
//  ViewController.m
//  MVVMAC
//
//  Created by William on 2018/11/16.
//  Copyright © 2018年 William. All rights reserved.
//

#import "ViewController.h"
#import "ViewModel.h"

@interface ViewController ()
@end

@implementation ViewController {
    ViewModel *viewModel;
}

- (void)viewDidLoad {
    [super viewDidLoad];
  
    __weak typeof(self) weakSelf = self;
    
    viewModel = [[ViewModel alloc] init];
    [viewModel setupDataSource:self.view];
    [viewModel getFakeData];
    
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC));
        dispatch_after(popTime, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            
            __strong typeof(self) strongSelf = weakSelf;
            if (strongSelf) {
                [strongSelf->viewModel applyInitialSnapshots];
            }
    });
}
@end
