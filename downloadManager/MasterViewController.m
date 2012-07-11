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

#define DELETE_DONE 0

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

    
    toDownloadFiles = [[NSMutableArray alloc] initWithObjects:@"http://www.hollywooddesktop.com/w/actresses/1920x1200/jennifer_aniston-010-1920x1200-hollywooddesktop.jpg",@"http://www.hollywooddesktop.com/w/actresses/1920x1200/jennifer_aniston-009-1920x1200-hollywooddesktop.jpg",@"http://www.hollywooddesktop.com/w/musicians/2560x1600/katy_perry-009-2560x1600-hollywooddesktop.jpg",@"http://www.hollywooddesktop.com/w/musicians/2560x1600/katy_perry-008-2560x1600-hollywooddesktop.jpg",@"http://www.hollywooddesktop.com/w/musicians/2560x1600/katy_perry-007-2560x1600-hollywooddesktop.jpg",@"http://www.hollywooddesktop.com/wallpaper/musicians/1920x1200/katy_perry-001-1920x1200-hollywooddesktop.jpg",@"http://www.hollywooddesktop.com/w/actresses/2560x1600/kristen_stewart-009-2560x1600-hollywooddesktop.jpg",@"http://www.hollywooddesktop.com/w/musicians/1920x1200/taylor_swift-014-1920x1200-hollywooddesktop.jpg",@"http://www.hollywooddesktop.com/w/musicians/2560x1600/taylor_swift-011-2560x1600-hollywooddesktop.jpg",@"http://www.hollywooddesktop.com/wallpaper/musicians/2560x1600/taylor_swift-006-2560x1600-hollywooddesktop.jpg",nil];
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
    static NSString *CellIdentifier = @"Cell";
    
    progressCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[progressCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier downloadURL:[NSURL URLWithString:[toDownloadFiles objectAtIndex:indexPath.row]]];

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
}


#pragma mark - progressCell
-(void)progressCellDownloadProgress:(float)progress Percentage:(NSInteger)percentage ProgressCell:(progressCell *)cell{
    
    cell.textLabel.text = [NSString stringWithFormat:@"%d %%",percentage];
    
}
-(void)progressCellDownloadFinished:(NSData*)fileData ProgressCell:(progressCell *)cell{
    
    if(DELETE_DONE) {
        NSIndexPath* indexPath = [self.tableView indexPathForCell:cell];
        [toDownloadFiles removeObjectAtIndex:indexPath.row];

        [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationRight];
    }
    else {
        cell.textLabel.text = @"Finished";
    }
}
-(void)progressCellDownloadFail:(NSError*)error ProgressCell:(progressCell *)cell{
    
}
@end
