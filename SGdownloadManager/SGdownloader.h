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


@protocol SGdownloaderDelegate <NSObject>

@required
-(void)SGDownloadProgress:(float)progress Percentage:(NSInteger)percentage;
-(void)SGDownloadFinished:(NSData*)fileData;
-(void)SGDownloadFail:(NSError*)error;
@end

@interface SGdownloader : NSObject <NSURLConnectionDataDelegate>

//properties
@property (nonatomic,readonly) NSMutableData* receiveData;
@property (nonatomic,readonly) NSInteger downloadedPercentage;
@property (nonatomic,readonly) float progress;

@property (nonatomic,strong) id<SGdownloaderDelegate>delegate;
//initwith file URL and timeout
-(id)initWithURL:(NSURL *)fileURL timeout:(NSInteger)timeout;

-(void)startWithDownloading:(SGDownloadProgressBlock)progressBlock onFinished:(SGDowloadFinished)finishedBlock onFail:(SGDownloadFailBlock)failBlock;

-(void)startWithDelegate:(id<SGdownloaderDelegate>)delegate;
-(void)cancel;
@end
