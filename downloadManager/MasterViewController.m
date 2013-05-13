//
//  MasterViewController.m
//  downloadManager
//
//  Created by Htain Lin Shwe on 11/7/12.
//  Copyright (c) 2012 Edenpod. All rights reserved.
//

#import "MasterViewController.h"

#import "DetailViewController.h"
#import "progressCell.h"


@interface MasterViewController () {
    NSMutableArray *toDownloadFiles;
}
@end

@implementation MasterViewController

@synthesize detailViewController = _detailViewController;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"Master", @"Master");
    }
    return self;
}
							
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.

    
    toDownloadFiles = [[NSMutableArray alloc] initWithObjects:@"http://localhost/img/Slice 1.png",@"http://localhost/img/Slice 2.png",@"http://localhost/img/Slice 3.png",@"http://localhost/img/Slice 4.png",@"http://localhost/img/Slice 5.png",@"http://localhost/img/Slice 6.png",@"http://localhost/img/Slice 7.png",@"http://localhost/img/Slice 8.png",@"http://localhost/img/Slice 9.png",@"http://localhost/img/Slice 10.png",@"http://localhost/img/Slice 11.png",@"http://localhost/img/Slice 12.png",nil];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}



#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [toDownloadFiles count];
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *CellIdentifier = [NSString stringWithFormat:@"Cell %d",indexPath.row];
    
    progressCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[progressCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier downloadURL:[NSURL URLWithString:[[toDownloadFiles objectAtIndex:indexPath.row] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]];

        [cell startWithDelegate:self];
    }

    
    
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (!self.detailViewController) {
        self.detailViewController = [[DetailViewController alloc] initWithNibName:@"DetailViewController" bundle:nil];
    }
    progressCell* cell = (progressCell*)[tableView cellForRowAtIndexPath:indexPath];
    
    if(cell.downloadedData!=nil) {
        self.detailViewController.imageData = cell.downloadedData;
        [self.navigationController pushViewController:self.detailViewController animated:YES];
    }
    else
    {
        if(cell.pause)
        {
            [cell downloadResume];
        }
        else
        {
            if([cell isAllowResume]) {
                [cell downloadPause];
            }
            
        }
    }
}


#pragma mark - progressCell
-(void)progressCellDownloadProgress:(float)progress Percentage:(NSInteger)percentage ProgressCell:(progressCell *)cell{
    
    cell.textLabel.text = [NSString stringWithFormat:@"%d %%",percentage];
    [cell setNeedsLayout];
    
}
-(void)progressCellDownloadFinished:(NSData*)fileData ProgressCell:(progressCell *)cell{
    
    cell.textLabel.text = @"Finished";
    
    [cell setNeedsLayout];
}
-(void)progressCellDownloadFail:(NSError*)error ProgressCell:(progressCell *)cell{
    NSLog(@"%@",[error localizedDescription]);
}
@end
