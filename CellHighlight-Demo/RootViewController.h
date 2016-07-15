//
//  RootViewController.h
//  CellHighlight-Demo
//
//  Created by Jakey on 16/7/15.
//  Copyright © 2016年 www.skyfox.org. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RootViewController : UIViewController
{
    NSMutableArray *_items;
}
@property (weak, nonatomic) IBOutlet UITableView *myTableView;
@property (weak, nonatomic) IBOutlet UICollectionView *myCollectionView;
- (IBAction)selectTouched:(id)sender;
- (IBAction)reloadSelectedTouched:(id)sender;
@end
