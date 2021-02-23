//
//  CollectionViewCell.m
//  MVVMAC
//
//  Created by William on 2021/2/23.
//  Copyright © 2021 William. All rights reserved.
//

#import "CollectionViewCell.h"

@interface CollectionViewCell()
@property (nonatomic, strong) UIImageView *imageView;
@end

@implementation CollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _imageView = [[UIImageView alloc] initWithFrame:self.contentView.bounds];
        _imageView.translatesAutoresizingMaskIntoConstraints = NO;
        [self.contentView addSubview:_imageView];
        [self addConstraints];
    }
    return self;
}

- (void)addConstraints {
    [NSLayoutConstraint activateConstraints:@[
        [_imageView.leadingAnchor constraintEqualToAnchor:self.contentView.leadingAnchor],
        [_imageView.trailingAnchor constraintEqualToAnchor:self.contentView.trailingAnchor],
        [_imageView.topAnchor constraintEqualToAnchor:self.contentView.topAnchor],
        [_imageView.bottomAnchor constraintEqualToAnchor:self.contentView.bottomAnchor],
    ]];
}

- (void)configurationCell:(CollectionViewItem *)item {
    _imageView.image = item.image;
}

// Here we remove all the custom stuff that we added to our subclassed cell
-(void)prepareForReuse
{
    [super prepareForReuse];

    [self.imageView removeFromSuperview];
    self.imageView = nil;
}
@end
