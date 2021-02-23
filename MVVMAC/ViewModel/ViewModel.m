//
//  ViewModel.m
//  MVVMAC
//
//  Created by William on 2021/2/23.
//  Copyright © 2021 William. All rights reserved.
//

#import "ViewModel.h"
#import "Items.h"

@interface ViewModel() <UITableViewDelegate>
@property (nonatomic, strong) UITableViewDiffableDataSource<ItemSectionIdentifier *, NSDictionary *> *dataSource API_AVAILABLE(ios(13.0));
@property (nonatomic, strong) UITableViewDiffableDataSourceCellProvider cellProvider API_AVAILABLE(ios(13.0));

@property (nonatomic, strong) NSMutableArray *items;
@property (nonatomic, strong) NSMutableArray *items2;

@property (nonatomic, strong) UITableView *tableView;
@end

@implementation ViewModel

- (instancetype)init {
    self = [super init];
    if (self) {
        _items = [[NSMutableArray alloc] init];
        _items2 = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)getFakeData {
    
    [_items addObject:[[Items alloc] initWithIdentifier:[NSUUID UUID] title:@"1"]];
    [_items addObject:[[Items alloc] initWithIdentifier:[NSUUID UUID] title:@"2"]];
    [_items addObject:[[Items alloc] initWithIdentifier:[NSUUID UUID] title:@"3"]];
    [_items addObject:[[Items alloc] initWithIdentifier:[NSUUID UUID] title:@"4"]];
    [_items addObject:[[Items alloc] initWithIdentifier:[NSUUID UUID] title:@"5"]];
    
    [_items2 addObject:[[Items alloc] initWithIdentifier:[NSUUID UUID] title:@"6"]];
    [_items2 addObject:[[Items alloc] initWithIdentifier:[NSUUID UUID] title:@"7"]];
    [_items2 addObject:[[Items alloc] initWithIdentifier:[NSUUID UUID] title:@"8"]];
    [_items2 addObject:[[Items alloc] initWithIdentifier:[NSUUID UUID] title:@"9"]];
    [_items2 addObject:[[Items alloc] initWithIdentifier:[NSUUID UUID] title:@"10"]];
}

- (UITableViewDiffableDataSourceCellProvider)createDataSource API_AVAILABLE(ios(13.0)) {
    
    return ^UITableViewCell*(UITableView * tableView, NSIndexPath *indexPath, Items *item) {
        
        if (item) {
            UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"Cell"];
            cell.textLabel.text = item.uuid.UUIDString;
            cell.detailTextLabel.text = item.title;
            return cell;
        }
        
        return [[UITableViewCell alloc] init];
    };
}

- (void)setupDataSource:(UIView *)rootView API_AVAILABLE(ios(13.0)) {
    _cellProvider = [self createDataSource];
    
    if (!_cellProvider) {
        return;
    }
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    _dataSource = [[UITableViewDiffableDataSource alloc] initWithTableView:_tableView cellProvider:_cellProvider];
    
    _tableView.dataSource = _dataSource;
    _tableView.delegate = self;

    _tableView.translatesAutoresizingMaskIntoConstraints = NO;
    
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
    
    [rootView addSubview:_tableView];
    
    UILayoutGuide *guide = rootView.safeAreaLayoutGuide;
    
    [NSLayoutConstraint activateConstraints:@[
        [_tableView.leadingAnchor constraintEqualToAnchor:guide.leadingAnchor],
        [_tableView.trailingAnchor constraintEqualToAnchor:guide.trailingAnchor],
        [_tableView.topAnchor constraintEqualToAnchor:guide.topAnchor],
        [_tableView.bottomAnchor constraintEqualToAnchor:guide.bottomAnchor],
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

//MARK: - UITableViewDataSource
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 22;
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
   
    switch (section) {
        case 0: {
            UIView *view = [[UIView alloc] init];

            view.frame = CGRectZero;
           
            UILabel *label = [[UILabel alloc] init];
            label.textColor = [UIColor blackColor];
            label.textAlignment = NSTextAlignmentCenter;
            
            label.translatesAutoresizingMaskIntoConstraints = false;
         
            [view addSubview:label];
            
            label.text = @"Main";
            
            [label.centerXAnchor constraintEqualToAnchor:view.centerXAnchor].active = YES;
            [label.centerYAnchor constraintEqualToAnchor:view.centerYAnchor].active = YES;
            
            return view;
        }
            
        case 1: {
            UIView *view = [[UIView alloc] init];

            view.frame = CGRectZero;
            
            UILabel *label = [[UILabel alloc] init];
            label.textColor = [UIColor blackColor];
            label.textAlignment = NSTextAlignmentCenter;
            
            label.translatesAutoresizingMaskIntoConstraints = false;
            
            [view addSubview:label];
            
            label.text = @"Second";
            
            [label.centerXAnchor constraintEqualToAnchor:view.centerXAnchor].active = YES;
            [label.centerYAnchor constraintEqualToAnchor:view.centerYAnchor].active = YES;
            
            return view;
        }
         
        default:
            break;
    }
    
    return nil;
}
@end
