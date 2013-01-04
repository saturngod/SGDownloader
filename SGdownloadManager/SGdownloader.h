//
//  SGdownloader.h
//  downloadManager
//
//  Created by Htain Lin Shwe on 11/7/12.
//  Copyright (c) 2012. All rights reserved.
//


/**
 Version 0.2 at 4 Jan 2013
 
 - Allow Pause and Resume
 
 Version 0.1 at 11 July 2012
 
 - Allow Download with Progress
 */


#import <Foundation/Foundation.h>

//for block

typedef void (^SGDownloadProgressBlock)(float progressValue,NSInteger percentage);
typedef void (^SGDowloadFinished)(NSData* fileData,NSString* fileName);
typedef void (^SGDownloadFailBlock)(NSError*error);


@protocol SGdownloaderDelegate <NSObject>

@required
-(void)SGDownloadProgress:(float)progress Percentage:(NSInteger)percentage;
-(void)SGDownloadFinished:(NSData*)fileData;
-(void)SGDownloadFail:(NSError*)error;
@end

@interface SGdownloader : NSObject <NSURLConnectionDataDelegate>

/**
 Get Receive NSData.
 */
@property (nonatomic,readonly) NSMutableData* receiveData;

/**
 Current Download Percentage
*/
@property (nonatomic,readonly) NSInteger downloadedPercentage;

/**
 `float` value for progress bar
 */
@property (nonatomic,readonly) float progress;

/**
 Server is allow resume or not
 */
@property (nonatomic,readonly) BOOL allowResume;

/**
 Suggest Download File Name
 */
@property (nonatomic,readonly) NSString* fileName;

/**
 Delegate Method
 */
@property (nonatomic,strong) id<SGdownloaderDelegate>delegate;


//initwith file URL and timeout
-(id)initWithURL:(NSURL *)fileURL timeout:(NSInteger)timeout;

-(void)startWithDownloading:(SGDownloadProgressBlock)progressBlock onFinished:(SGDowloadFinished)finishedBlock onFail:(SGDownloadFailBlock)failBlock;

-(void)startWithDelegate:(id<SGdownloaderDelegate>)delegate;
-(void)cancel;
-(void)pause;
-(void)resume;
@end
