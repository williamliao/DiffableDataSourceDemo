//
//  Items.h
//  MVVMAC
//
//  Created by William on 2021/2/23.
//  Copyright © 2021 William. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Items : NSObject
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSUUID* uuid;

- (instancetype)initWithIdentifier:(NSUUID *)Identifier title:(NSString *)title;
@end

NS_ASSUME_NONNULL_END
