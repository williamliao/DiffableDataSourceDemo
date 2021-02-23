//
//  CollectionViewItem.h
//  MVVMAC
//
//  Created by William on 2021/2/23.
//  Copyright © 2021 William. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CollectionViewItem : NSObject
@property (nonatomic, strong) UIImage *image;
@property (nonatomic, strong) NSUUID* uuid;

- (instancetype)initWithIdentifier:(NSUUID *)Identifier image:(UIImage *)image;
@end

NS_ASSUME_NONNULL_END
