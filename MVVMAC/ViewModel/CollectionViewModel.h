//
//  CollectionViewModel.h
//  MVVMAC
//
//  Created by William on 2021/2/23.
//  Copyright © 2021 William. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CollectionViewModel : NSObject
- (void)getFakeData API_AVAILABLE(ios(13.0));
- (void)setupDataSource:(UIView *)rootView API_AVAILABLE(ios(13.0));
- (void)applyInitialSnapshots API_AVAILABLE(ios(13.0));
@end

NS_ASSUME_NONNULL_END
