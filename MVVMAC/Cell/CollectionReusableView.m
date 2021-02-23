//
//  CollectionReusableView.m
//  MVVMAC
//
//  Created by William on 2021/2/23.
//  Copyright © 2021 William. All rights reserved.
//

#import "CollectionReusableView.h"

@implementation CollectionReusableView
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self createView];
        [self addConstraints];
    }
    return self;
}

- (void)createView {
    _label = [[UILabel alloc] initWithFrame:self.frame];
    _label.translatesAutoresizingMaskIntoConstraints = false;
    _label.font = [UIFont systemFontOfSize:[UIFont preferredFontForTextStyle:UIFontTextStyleTitle1].pointSize weight:UIFontWeightBold];
    _label.adjustsFontForContentSizeCategory = true;
    if (@available(iOS 13.0, *)) {
        _label.textColor = [UIColor labelColor];
        self.backgroundColor = [UIColor systemBackgroundColor];
    } else {
        // Fallback on earlier versions
    }
    _label.textAlignment = NSTextAlignmentLeft;
    _label.numberOfLines = 1;
    [_label setContentCompressionResistancePriority:UILayoutPriorityDefaultHigh forAxis:UILayoutConstraintAxisHorizontal];
    [self addSubview:_label];
}

- (void)addConstraints {
    UILayoutGuide *guide = self.readableContentGuide;
    
    [NSLayoutConstraint activateConstraints:@[
        [_label.leadingAnchor constraintEqualToAnchor:guide.leadingAnchor],
        [_label.trailingAnchor constraintLessThanOrEqualToAnchor:guide.trailingAnchor],
        
        [_label.topAnchor constraintEqualToAnchor:self.topAnchor constant:10],
        [_label.bottomAnchor constraintEqualToAnchor:self.bottomAnchor constant:-10],
    ]];
}

-(void)prepareForReuse
{
    [super prepareForReuse];

    [_label removeFromSuperview];
    _label.text = @"";
}
@end
