//
//  CollectionViewController.m
//  MVVMAC
//
//  Created by William on 2021/2/23.
//  Copyright © 2021 William. All rights reserved.
//

#import "CollectionViewController.h"
#import "CollectionViewModel.h"

@implementation CollectionViewController {
    CollectionViewModel *viewModel;
}

- (void)viewDidLoad {
    [super viewDidLoad];
  
    __weak typeof(self) weakSelf = self;
    
    viewModel = [[CollectionViewModel alloc] init];
    if (@available(iOS 13.0, *)) {
        [viewModel setupDataSource:self.view];
        [viewModel getFakeData];
        
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC));
            dispatch_after(popTime, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                
                __strong typeof(self) strongSelf = weakSelf;
                if (strongSelf) {
                    [strongSelf->viewModel applyInitialSnapshots];
                }
        });
        
    } else {
        // Fallback on earlier versions
    }
}
@end
