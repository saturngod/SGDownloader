SGdownloader is a small library for downloading file. It supported

* Block
* Delegate
* Arc

You can use Block or Delegate for downloading the file. If you are using with TableView, you should use Delegate instead of Block.

## Demo

I put downloadManager demo with tableview cell. It's using delegate method for delete the tableviewcell.

##How to use

Put 

* SGdownloader.h
* SGdownloader.m

to your project.

###for using Block

	SGdownloader *downloader = [[SGdownloader alloc] initWithURL:[NSURL URLWithString:@"http://myfile.com/file.jpg"] timeout:60];

	[downloader startWithDownloading:(float progress,NSInteger percentage) {
		
		//progress for progress bar
		//percentage for download percentage
		
	} onFinished:(NSData* fileData){
		
		//use NSData to write a file or image
		
	}onFail (NSError* error){
	
		//on fail
	
	}];
	
##for using Delegate
put SGdownloader delegate at .h file

	@interface progressCell : UITableViewCell <SGdownloaderDelegate>
	
inb .m file
	
	SGdownloader *downloader = [[SGdownloader alloc] initWithURL:[NSURL URLWithString:@"http://myfile.com/file.jpg"] timeout:60];
	
	[downloader startWithDelegate:self];
	
Delegate Methods are required

	-(void)SGDownloadProgress:(float)progress Percentage:(NSInteger)percentage;
	-(void)SGDownloadFinished:(NSData*)fileData;
	-(void)SGDownloadFail:(NSError*)error;
	
	


##Todo

* pause and resume