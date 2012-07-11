//
//  progressCell.m
//  downloadManager
//
//  Created by Htain Lin Shwe on 11/7/12.
//  Copyright (c) 2012 Edenpod. All rights reserved.
//

#import "progressCell.h"
#import "SGdownloader.h"
@implementation progressCell
@synthesize downloadedData = _downloadedData;



- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier downloadURL:(NSURL*)url {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        UIProgressView* progressV = [[UIProgressView alloc] initWithProgressViewStyle:UIProgressViewStyleBar];
        self.textLabel.text = @"0%";
        self.accessoryView = progressV;
        _downloadedData = nil;
        
        SGdownloader* download = [[SGdownloader alloc] initWithURL:url timeout:60 onDownloading:^(float progressValue,NSInteger percentage){
            
            
            self.textLabel.text = [NSString stringWithFormat:@"%d %%",percentage];
            progressV.progress = progressValue;
            
        }onFinished:^(NSData* data) {
            progressV.progress = 1.0f;
            self.textLabel.text = @"Done";
            
            _downloadedData = data;
            
        }onFial:^(NSError* error){
            self.textLabel.text = @"Error";
        }];
        
        
        [download start];
    }
    return self;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
