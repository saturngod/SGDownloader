//
//  progressCell.m
//  downloadManager
//
//  Created by Htain Lin Shwe on 11/7/12.
//  Copyright (c) 2012 Edenpod. All rights reserved.
//

#import "progressCell.h"

@interface progressCell()
@property (nonatomic, strong) SGdownloader* download;
@property (nonatomic, strong) UIProgressView* progressV;
@end
@implementation progressCell
@synthesize downloadedData = _downloadedData;
@synthesize download = _download;
@synthesize progressV = _progressV;
@synthesize delegate = _delegate;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier downloadURL:(NSURL*)url {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        _progressV = [[UIProgressView alloc] initWithProgressViewStyle:UIProgressViewStyleBar];
        self.textLabel.text = @"0%";
        self.accessoryView = _progressV;
        _downloadedData = nil;
        
        _download = [[SGdownloader alloc] initWithURL:url timeout:60];
        
    }
    return self;
    
}

-(void)startWithDelegate:(id<progressCellDelegate>)delegate
{
    _delegate = delegate;
    [_download startWithDelegate:self];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
#pragma mark - DownloadProcess
-(void)SGDownloadProgress:(float)progress Percentage:(NSInteger)percentage {
    _progressV.progress = progress;
    
    if([_delegate respondsToSelector:@selector(progressCellDownloadProgress:Percentage:ProgressCell:)]) {
        [_delegate progressCellDownloadProgress:progress Percentage:percentage ProgressCell:self];
    }
    
}
-(void)SGDownloadFinished:(NSData*)fileData {

    if([_delegate respondsToSelector:@selector(progressCellDownloadFinished:ProgressCell:)])
    {
        [_delegate progressCellDownloadFinished:fileData ProgressCell:self];
    }
    
}
-(void)SGDownloadFail:(NSError*)error {

    if([_delegate respondsToSelector:@selector(progressCellDownloadFail:ProgressCell:)])
    {
        [_delegate progressCellDownloadFail:error ProgressCell:self];
    }
    
}
@end
