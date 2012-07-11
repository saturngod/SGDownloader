//
//  MasterViewController.h
//  downloadManager
//
//  Created by Htain Lin Shwe on 11/7/12.
//  Copyright (c) 2012 Edenpod. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "progressCell.h"
@class DetailViewController;

@interface MasterViewController : UITableViewController <progressCellDelegate>

@property (strong, nonatomic) DetailViewController *detailViewController;

@end
