//
//  progressCell.h
//  downloadManager
//
//  Created by Htain Lin Shwe on 11/7/12.
//  Copyright (c) 2012 Edenpod. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface progressCell : UITableViewCell
@property (nonatomic,retain) NSData* downloadedData;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier downloadURL:(NSURL*)url;
@end
