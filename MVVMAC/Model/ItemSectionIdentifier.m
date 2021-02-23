//
//  ItemSectionIdentifier.m
//  MVVMAC
//
//  Created by William on 2021/2/23.
//  Copyright © 2021 William. All rights reserved.
//

#import "ItemSectionIdentifier.h"

@implementation ItemSectionIdentifier
- (instancetype)initWithSection:(ItemSection)section {
    self = [super init];
    if (self) {
        self.sectionType = section;
    }
    return self;
}
@end
