//
//  RootViewController.m
//  CellHighlight-Demo
//
//  Created by Jakey on 16/7/15.
//  Copyright © 2016年 www.skyfox.org. All rights reserved.
//

#import "RootViewController.h"
#import "TableViewCell.h"
#import "CollectionViewCell.h"
@interface RootViewController ()

@end
static NSString *TableViewCellIdentifier = @"TableViewCell";
NSString *CollectionViewCellIdentifier = @"CollectionViewCell";

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.myTableView registerNib:[UINib nibWithNibName:TableViewCellIdentifier bundle:nil] forCellReuseIdentifier:TableViewCellIdentifier];
    [self.myCollectionView registerNib:[UINib nibWithNibName:CollectionViewCellIdentifier bundle:nil] forCellWithReuseIdentifier:CollectionViewCellIdentifier];
    
    _items = [NSMutableArray array];
    for (int i=0; i<20;i++) {
        [_items addObject:[NSString stringWithFormat:@"测试标题%zd",i]];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark -
#pragma -mark TableView Delegate
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_items count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:TableViewCellIdentifier];
    NSString *item =_items[indexPath.row];
    cell.label.text = item;
    
#warning 当selectionStyle设置为none的时候，imageView的highlight会失效，所以开启selectionStyle，把selectedBackgroundView之位空view
//    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.selectedBackgroundView = nil;
    cell.backgroundColor = [UIColor clearColor];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *item = [_items objectAtIndex:indexPath.row];
    
    NSLog(@"tableView:%@",item);
}

#pragma mark -
#pragma mark Collection view data source
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [_items count];
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CollectionViewCell *cell = (CollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:CollectionViewCellIdentifier forIndexPath:indexPath];
    NSString *item = [_items objectAtIndex:indexPath.row];
    cell.label.text = item;

    return cell;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *item = [_items objectAtIndex:indexPath.row];

    NSLog(@"collectionView:%@",item);
}

- (IBAction)selectTouched:(id)sender {
    //选中某行要先高亮后 手动调用 didSelect 方法
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:2 inSection:0];
    dispatch_async(dispatch_get_main_queue(), ^{
        //高亮
        [self.myTableView selectRowAtIndexPath:indexPath animated:YES scrollPosition:UITableViewScrollPositionTop];
        //点击
        [self tableView:self.myTableView  didSelectRowAtIndexPath:indexPath];
    });
    
    
    dispatch_async(dispatch_get_main_queue(), ^{
        //高亮
        [self.myCollectionView selectItemAtIndexPath:indexPath animated:YES scrollPosition:UICollectionViewScrollPositionTop];
        //点击
        [self collectionView:self.myCollectionView didSelectItemAtIndexPath:indexPath];
    });

}

- (IBAction)reloadSelectedTouched:(id)sender {
    [self.myTableView reloadData];
    [self.myCollectionView reloadData];
    [self selectTouched:nil];
    
}
@end
