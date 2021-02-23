//
//  CollectionViewItem.m
//  MVVMAC
//
//  Created by William on 2021/2/23.
//  Copyright © 2021 William. All rights reserved.
//

#import "CollectionViewItem.h"

@implementation CollectionViewItem
- (instancetype)initWithIdentifier:(NSUUID *)Identifier image:(UIImage *)image {
    self = [super init];
    if (self) {
        self.uuid = Identifier;
        self.image = image;
    }
    return self;
}
@end
