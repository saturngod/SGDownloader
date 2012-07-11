//
//  SGdownloader.m
//  downloadManager
//
//  Created by saturngod on 11/7/12.
//

#import "SGdownloader.h"

@interface SGdownloader()
@property (nonatomic,assign) float receiveBytes;
@property (nonatomic,assign) float exceptedBytes;
@property (nonatomic,strong) NSURLRequest *request;
@property (nonatomic,strong) NSURLConnection *connection;

//for block
@property (nonatomic,strong) SGDownloadProgressBlock progressDownloadBlock;
@property (nonatomic,strong) SGDowloadFinished progressFinishBlock;
@property (nonatomic,strong) SGDownloadFailBlock progressFailBlock;

@end

@implementation SGdownloader
@synthesize receiveData = _receiveData;
@synthesize request = _request;
@synthesize connection = _connection;
@synthesize downloadedPercentage = _downloadedPercentage;
@synthesize receiveBytes;
@synthesize exceptedBytes;
@synthesize progress = _progress;
@synthesize progressFailBlock = _progressFailBlock;
@synthesize progressDownloadBlock = _progressDownloadBlock;
@synthesize progressFinishBlock = _progressFinishBlock;

-(id)initWithURL:(NSURL *)fileURL timeout:(NSInteger)timeout onDownloading:(SGDownloadProgressBlock)progressBlock onFinished:(SGDowloadFinished)finishedBlock onFial:(SGDownloadFailBlock)failBlock {
    
    
    self = [super init];
    
    if(self)
    {
        self.receiveBytes = 0;
        self.exceptedBytes = 0;
        _receiveData = [[NSMutableData alloc] initWithLength:0];
        _downloadedPercentage = 0.0f;
        self.request = [[NSURLRequest alloc] initWithURL:fileURL cachePolicy:NSURLRequestReturnCacheDataElseLoad timeoutInterval:timeout];
    
        
        self.connection = [[NSURLConnection alloc] initWithRequest:self.request delegate:self startImmediately:NO];
        
        _progressDownloadBlock = [progressBlock copy];
        _progressFinishBlock = [finishedBlock copy];
        _progressFailBlock = [failBlock copy];
        
    }
    
    return self;
}

#pragma mark - NSURLConnectionDataDelegate

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    [_receiveData appendData:data];
    
    NSInteger len = [data length];
    receiveBytes = receiveBytes + len;
    
    if(exceptedBytes != NSURLResponseUnknownLength) {
        _progress = ((receiveBytes/(float)exceptedBytes) * 100)/100;
        _downloadedPercentage = _progress * 100;
        
        _progressDownloadBlock(_progress,_downloadedPercentage);
    }
    
}

-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    //return back error
    _progressFailBlock(error);
}

-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    exceptedBytes = [response expectedContentLength];
}

-(void)connectionDidFinishLoading:(NSURLConnection *)connection {
    self.connection = nil;
    _progressFinishBlock(_receiveData);
}

#pragma mark - properties
-(void)start {
    if(self.connection) {
        [self.connection start];
    }
    
}
-(void)cancel {
    if(self.connection) {
        [self.connection cancel];
    }
}
@end
