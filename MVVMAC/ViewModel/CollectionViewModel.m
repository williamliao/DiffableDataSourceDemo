//
//  CollectionViewModel.m
//  MVVMAC
//
//  Created by William on 2021/2/23.
//  Copyright © 2021 William. All rights reserved.
//

#import "CollectionViewModel.h"
#import "ItemSectionIdentifier.h"
#import "CollectionViewItem.h"
#import "CollectionViewCell.h"
#import "CollectionReusableView.h"

@interface CollectionViewModel() <UICollectionViewDelegateFlowLayout, UICollectionViewDelegate>
@property (nonatomic, strong) UICollectionViewDiffableDataSource<ItemSectionIdentifier *, NSDictionary *> *dataSource API_AVAILABLE(ios(13.0));
@property (nonatomic, strong) UICollectionViewDiffableDataSourceCellProvider cellProvider API_AVAILABLE(ios(13.0));

@property (nonatomic, strong) NSMutableArray *items;
@property (nonatomic, strong) NSMutableArray *items2;

@property (nonatomic, strong) UICollectionView *collectionView;
@end

@implementation CollectionViewModel


- (instancetype)init {
    self = [super init];
    if (self) {
        _items = [[NSMutableArray alloc] init];
        _items2 = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)getFakeData API_AVAILABLE(ios(13.0)) {
    
    [_items addObject:[[CollectionViewItem alloc] initWithIdentifier:[NSUUID UUID] image:[UIImage systemImageNamed:@"sun.min"]]];
    [_items addObject:[[CollectionViewItem alloc] initWithIdentifier:[NSUUID UUID] image:[UIImage systemImageNamed:@"sun.max"]]];
    [_items addObject:[[CollectionViewItem alloc] initWithIdentifier:[NSUUID UUID] image:[UIImage systemImageNamed:@"sunrise"]]];
    [_items addObject:[[CollectionViewItem alloc] initWithIdentifier:[NSUUID UUID] image:[UIImage systemImageNamed:@"sunset"]]];
    [_items addObject:[[CollectionViewItem alloc] initWithIdentifier:[NSUUID UUID] image:[UIImage systemImageNamed:@"sun.dust"]]];
    
    [_items2 addObject:[[CollectionViewItem alloc] initWithIdentifier:[NSUUID UUID] image:[UIImage systemImageNamed:@"sun.haze"]]];
    [_items2 addObject:[[CollectionViewItem alloc] initWithIdentifier:[NSUUID UUID] image:[UIImage systemImageNamed:@"moon"]]];
    [_items2 addObject:[[CollectionViewItem alloc] initWithIdentifier:[NSUUID UUID] image:[UIImage systemImageNamed:@"moon.circle"]]];
    [_items2 addObject:[[CollectionViewItem alloc] initWithIdentifier:[NSUUID UUID] image:[UIImage systemImageNamed:@"moon.zzz"]]];
    [_items2 addObject:[[CollectionViewItem alloc] initWithIdentifier:[NSUUID UUID] image:[UIImage systemImageNamed:@"moon.stars"]]];
}

- (UICollectionViewDiffableDataSourceCellProvider)createDataSource API_AVAILABLE(ios(13.0)) {
    
    return ^CollectionViewCell*(UICollectionView * collectionView, NSIndexPath *indexPath, CollectionViewItem *item) {
        
        if (item) {
         
            CollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellIdentifier" forIndexPath:indexPath];
            [cell configurationCell:item];
            return cell;
        }
        
        return [[CollectionViewCell alloc] init];
    };
}

- (void)setupDataSource:(UIView *)rootView API_AVAILABLE(ios(13.0)) {
    _cellProvider = [self createDataSource];
    
    
    if (!_cellProvider) {
        return;
    }
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.headerReferenceSize = CGSizeMake(self.collectionView.frame.size.width, 44);
    
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    _dataSource = [[UICollectionViewDiffableDataSource alloc] initWithCollectionView:_collectionView cellProvider:_cellProvider];
    
    __weak typeof(self) weakSelf = self;
    _dataSource.supplementaryViewProvider = ^UICollectionReusableView * _Nullable(UICollectionView * _Nonnull collectionView, NSString * _Nonnull elementKind, NSIndexPath * _Nonnull indexPath) {
        
        if (elementKind == UICollectionElementKindSectionHeader) {
            
            __strong typeof(self) strongSelf = weakSelf;
            if (strongSelf) {
                
                ItemSectionIdentifier *sectionIdentifier = strongSelf->_dataSource.snapshot.sectionIdentifiers[indexPath.section];
                
                switch (sectionIdentifier.sectionType) {
                    case 0: {
                        
                        CollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:
                                                             UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderView" forIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
                        
                        NSString *text = @"main";
                        headerView.label.text = text;
                        
                        return headerView;
                    }
                    case 1: {
                        
                        CollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:
                                                             UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderView" forIndexPath:[NSIndexPath indexPathForRow:0 inSection:1]];
                        
                        NSString *text = @"second";
                        headerView.label.text = text;
                        
                        return headerView;
                    }
                    default:
                        break;
                }
            }
        }
        
        return nil;
    };
    
    [_collectionView setDataSource:_dataSource];
    [_collectionView setDelegate:self];
    _collectionView.translatesAutoresizingMaskIntoConstraints = NO;

    [_collectionView registerClass:[CollectionViewCell class] forCellWithReuseIdentifier:@"cellIdentifier"];
    [_collectionView registerClass:[CollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderView"];

    [rootView addSubview:_collectionView];
    
    UILayoutGuide *guide = rootView.safeAreaLayoutGuide;
    
    [NSLayoutConstraint activateConstraints:@[
        [_collectionView.leadingAnchor constraintEqualToAnchor:guide.leadingAnchor],
        [_collectionView.trailingAnchor constraintEqualToAnchor:guide.trailingAnchor],
        [_collectionView.topAnchor constraintEqualToAnchor:guide.topAnchor],
        [_collectionView.bottomAnchor constraintEqualToAnchor:guide.bottomAnchor],
    ]];
    
}

- (void)applyInitialSnapshots API_AVAILABLE(ios(13.0)) {
    NSDiffableDataSourceSnapshot<ItemSectionIdentifier *, NSDictionary *> *snapshot = [[NSDiffableDataSourceSnapshot alloc] init];
    
    for(ItemSection i = 0; i <= EnumValueLast; i++) {
        ItemSectionIdentifier *sectionExisting = [[ItemSectionIdentifier alloc] initWithSection: i];
        
        [snapshot appendSectionsWithIdentifiers: @[sectionExisting]];
        
        //NSLog(@"NSDiffableDataSourceSnapshot sction 1 %ld", sectionExisting.sectionType);
        
        switch (sectionExisting.sectionType) {
            case 0:
                
                if (_items.count > 0) {
                    [snapshot appendItemsWithIdentifiers:_items intoSectionWithIdentifier:sectionExisting];
                }
                
            case 1:
                
                if (_items2.count > 0) {
                    [snapshot appendItemsWithIdentifiers:_items2 intoSectionWithIdentifier:sectionExisting];
                }

            default:
                break;
        }
    }
  
    [_dataSource applySnapshot:snapshot animatingDifferences:YES];
}

//MARK: - UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(100, 100);
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(5, 0, 5, 0);
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 5;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 5;
}
@end
