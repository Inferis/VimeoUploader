//
//  AccountViewController.m
//  VimeoUploader
//
//  Created by Tom Adriaenssen on 28/01/11.
//  Copyright 2011 Adriaenssen BVBA. All rights reserved.
//

#import "AccountViewController.h"
#import "Account.h"
#import "LabeledInputTableViewCell.h"

@interface AccountViewController ()

- (void)setSaveButtonEnabled;

@end

@implementation AccountViewController 

@synthesize delegate;

- (void)enableSave:(id)sender {
	[self setSaveButtonEnabled];
}


- (void)setSaveButtonEnabled {
	LabeledInputTableViewCell* emailCell = (LabeledInputTableViewCell*)[self.tableView viewWithTag:11];
	LabeledInputTableViewCell* passwordCell = (LabeledInputTableViewCell*)[self.tableView viewWithTag:22];
	
	self.navigationItem.rightBarButtonItem.enabled = (emailCell.field.text.length > 0) && (passwordCell.field.text.length > 0);
}

#pragma mark -
#pragma mark Initialization

-(id) initWithAccount:(Account*)_account nibName:(NSString *)nibNameOrNil bundle:(NSBundle *)bundleOrNil {
	if ((self = [self initWithNibName:nibNameOrNil bundle:bundleOrNil])) {
		account = [_account retain];
	}
	
	return self;
}

#pragma mark -
#pragma mark View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
	
    self.title = @"Add account";	

    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(saveButtonPressed)];
	[self setSaveButtonEnabled];
}

-(void)saveButtonPressed {
	SEL method = @selector(accountWasSaved:);
	if ([self.delegate respondsToSelector:method]) {
		[self.delegate performSelector:method
							withObject:account];
	}
	
	[self.navigationController popViewControllerAnimated:YES];
}

/*
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}
*/
/*
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}
*/
/*
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}
*/
/*
- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
}
*/
/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/


#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return 2;
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"LabeledInputTableViewCell";
    
    LabeledInputTableViewCell *cell = (LabeledInputTableViewCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[LabeledInputTableViewCell alloc] initWithReuseIdentifier:CellIdentifier] autorelease];
    }
	
	cell.selectionStyle = UITableViewCellSelectionStyleNone;
	if (indexPath.row == 0) {
		cell.textLabel.text = @"Email";
		cell.tag = 11;
		[cell becomeFirstResponder];
	}
	else {
		cell.textLabel.text = @"Password";
		cell.field.secureTextEntry = YES;
		cell.tag = 22;
	}
    
	[cell.field addTarget:self action:@selector(enableSave:) forControlEvents:UIControlEventEditingChanged];
    
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/


/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source.
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }   
}
*/


/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/


/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark -
#pragma mark Table view delegate
- (NSIndexPath*)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Navigation logic may go here. Create and push another view controller.
    /*
    <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
    // ...
    // Pass the selected object to the new view controller.
    [self.navigationController pushViewController:detailViewController animated:YES];
    [detailViewController release];
    */
}


#pragma mark -
#pragma mark Memory management

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Relinquish ownership any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    // Relinquish ownership of anything that can be recreated in viewDidLoad or on demand.
    // For example: self.myOutlet = nil;
	[account release]; account = nil;
}


- (void)dealloc {
    [super dealloc];
}


@end

