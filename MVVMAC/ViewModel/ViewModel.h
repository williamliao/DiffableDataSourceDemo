//
//  ViewModel.h
//  MVVMAC
//
//  Created by William on 2021/2/23.
//  Copyright © 2021 William. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "ItemSectionIdentifier.h"

NS_ASSUME_NONNULL_BEGIN

@interface ViewModel : NSObject
- (void)setupDataSource:(UIView *)rootView API_AVAILABLE(ios(13.0));
- (void)applyInitialSnapshots API_AVAILABLE(ios(13.0));
- (void)getFakeData;
@end

NS_ASSUME_NONNULL_END
