//
//  Items.m
//  MVVMAC
//
//  Created by William on 2021/2/23.
//  Copyright © 2021 William. All rights reserved.
//

#import "Items.h"

@implementation Items
- (instancetype)initWithIdentifier:(NSUUID *)Identifier title:(NSString *)title  {
    self = [super init];
    if (self) {
        self.uuid = Identifier;
        self.title = title;
    }
    return self;
}
@end
