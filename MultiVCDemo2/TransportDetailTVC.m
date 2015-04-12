//
//  TransportDetailTVC.m
//  MultiVCDemo2
//
//  Created by Mario Abruzzi on 4/12/15.
//  Copyright (c) 2015 FWS. All rights reserved.
//

#import "TransportDetailTVC.h"
#import "TransportDetailItem.h"

@interface TransportDetailTVC ()

@property NSMutableArray *fakeDetails;

@end

@implementation TransportDetailTVC

- (void)viewDidLoad {
    NSLog(@"%%TransportDetailTVC-I-TRACE, -viewDidLoad called.");
    [super viewDidLoad];
    self.fakeDetails = [[NSMutableArray alloc] init];
    [self loadFakeDetailData];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    NSLog(@"%%TransportDetailTVC-I-TRACE, -numberOfSectionsInTableView: called.");
    
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    NSLog(@"%%TransportDetailTVC-I-TRACE, -tableView:numberOfRowsInSection: called.");
    // Return the number of rows in the section.
    return [self.fakeDetails count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"%%TransportDetailTVC-I-TRACE, -tableView:cellForRowAtIndexPath: called.");
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TransportDetailCell"];
    
    if (nil == cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier:@"TransportDetailCell"];
    }
    
    // Configure the cell...
    
    TransportDetailItem *transDetailObj = [self.fakeDetails objectAtIndex:indexPath.row];
    cell.textLabel.text = transDetailObj.flightTag;
    
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
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - Table Data

- (void)loadFakeDetailData {
    TransportDetailItem *item1 = [[TransportDetailItem alloc] init];
    item1.flightTag = @"999AAA";
    item1.sendingHospital = @"Little Community Hospital";
    item1.receivingHospital = @"Children's Hospital Oakland";
    [self.fakeDetails addObject:item1];
}

@end
