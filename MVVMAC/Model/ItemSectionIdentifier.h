//
//  ItemSectionIdentifier.h
//  MVVMAC
//
//  Created by William on 2021/2/23.
//  Copyright © 2021 William. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, ItemSection) {
    main,
    second
    #define EnumValueLast second
};

@interface ItemSectionIdentifier : NSObject
@property (nonatomic) ItemSection sectionType;

- (instancetype)initWithSection:(ItemSection)section;
@end

NS_ASSUME_NONNULL_END
