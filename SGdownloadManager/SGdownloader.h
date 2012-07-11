//
//  SGdownloader.h
//  downloadManager
//
//  Created by Htain Lin Shwe on 11/7/12.
//  Copyright (c) 2012 Edenpod. All rights reserved.
//

#import <Foundation/Foundation.h>

//for block

typedef void (^SGDownloadProgressBlock)(float progressValue,NSInteger percentage);
typedef void (^SGDowloadFinished)(NSData* fileData);
typedef void (^SGDownloadFailBlock)(NSError*error);

@interface SGdownloader : NSObject <NSURLConnectionDataDelegate>

//properties
@property (nonatomic,readonly) NSMutableData* receiveData;
@property (nonatomic,readonly) NSInteger downloadedPercentage;
@property (nonatomic,readonly) float progress;

//initwith file URL and timeout
-(id)initWithURL:(NSURL *)fileURL timeout:(NSInteger)timeout onDownloading:(SGDownloadProgressBlock)progressBlock onFinished:(SGDowloadFinished)finishedBlock onFial:(SGDownloadFailBlock)failBlock;

-(void)start;
-(void)cancel;
@end
