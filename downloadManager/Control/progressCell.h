//
//  progressCell.h
//  downloadManager
//
//  Created by Htain Lin Shwe on 11/7/12.
//  Copyright (c) 2012 Edenpod. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SGdownloader.h"

@class progressCell;
@protocol progressCellDelegate<NSObject>
@required
-(void)progressCellDownloadProgress:(float)progress Percentage:(NSInteger)percentage ProgressCell:(progressCell*)cell;
-(void)progressCellDownloadFinished:(NSData*)fileData ProgressCell:(progressCell*)cell;
-(void)progressCellDownloadFail:(NSError*)error ProgressCell:(progressCell*)cell; 
@end



@interface progressCell : UITableViewCell <SGdownloaderDelegate>
@property (nonatomic,readonly) NSData *downloadedData;
@property (nonatomic,readonly) NSURL *downloadURL;
@property (nonatomic,strong) id<progressCellDelegate> delegate;
@property (nonatomic,assign) BOOL pause;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier downloadURL:(NSURL*)url;

-(void)startWithDelegate:(id<progressCellDelegate>)delegate;
-(void)downloadPause;
-(void)downloadResume;
-(BOOL)isAllowResume;
@end
