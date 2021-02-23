//
//  CollectionViewCell.h
//  MVVMAC
//
//  Created by William on 2021/2/23.
//  Copyright © 2021 William. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CollectionViewItem.h"

NS_ASSUME_NONNULL_BEGIN

@interface CollectionViewCell : UICollectionViewCell
- (void)configurationCell:(CollectionViewItem *)item;
@end

NS_ASSUME_NONNULL_END
