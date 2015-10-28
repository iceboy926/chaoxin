//
//  FindViewController.m
//  Hello
//
//  Created by 111 on 15-8-27.
//  Copyright (c) 2015年 mit. All rights reserved.
//

#import "FindViewController.h"
#import "QRViewController.h"
#import "QRResultViewController.h"
#import "ShakeViewController.h"
#import "InformationViewController.h"

@interface FindViewController ()

@end

@implementation FindViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.title = @"发现";
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:20/255.0 green:155/255.0 blue:213/255.0 alpha:1.0]];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    // Return the number of sections.
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    // Return the number of rows in the section.
    NSInteger Count = 0;
    if(section == 0)
    {
        Count = 1;
    }
    else
    {
        Count = 2;
    }
    return Count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    NSInteger section = [indexPath section];
    NSInteger rows = [indexPath row];
    
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    
    cell.userInteractionEnabled = YES;
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    if(section == 0)
    {
        cell.textLabel.text = @"朋友圈";
        cell.imageView.image = [UIImage imageNamed:@"ff_IconShowAlbum"];
    }
    else if(section == 1)
    {
        if(rows == 0)
        {
            cell.textLabel.text = @"扫一扫";
            cell.imageView.image = [UIImage imageNamed:@"ff_IconQRCode"];
        }
        else
        {
            cell.textLabel.text = @"摇一摇";
            cell.imageView.image = [UIImage imageNamed:@"ff_IconShake"];
        }
        
    }
    else if(section == 2)
    {
        if(rows == 0)
        {
            cell.textLabel.text = @"附近的人";
            cell.imageView.image = [UIImage imageNamed:@"ff_IconLocationService"];
        }
        else
        {
            cell.textLabel.text = @"当前位置";
            cell.imageView.image = [UIImage imageNamed:@"CardPack"];
        }

    }

    
    
    
    // Configure the cell...
    
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
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
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark - Table view delegate

// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here, for example:
    // Create the next view controller.
    if([indexPath section] == 0)
    {
        InformationViewController *inforView = [[InformationViewController alloc] init];
        [self.navigationController pushViewController:inforView animated:YES];
        
    }
    else if([indexPath section] == 1)
    {
        
        if([indexPath row] == 0)
        {
            QRViewController *QRView = [[QRViewController alloc] initWithNibName:@"QRViewController" bundle:nil];
            
            
            [self.navigationController pushViewController:QRView animated:YES];
            
            QRView.QRCodeSuncessBlock = ^(QRViewController *qrview, NSString *str){
                
                //[self.navigationController popViewControllerAnimated:YES];
                
            };
            
            QRView.QRCodeFailBlock = ^(QRViewController *qrview){
                
                //[qrview dismissViewControllerAnimated:YES completion:nil];
            };
        }
        else if([indexPath row] == 1)
        {
            ShakeViewController *ShakeView = [[ShakeViewController alloc] init];
            
            [self.navigationController pushViewController:ShakeView animated:YES];
            
        }
        
    }

}


@end
