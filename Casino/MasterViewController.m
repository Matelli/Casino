//
//  MasterViewController.m
//  Casino
//
//  Created by Jonathan Schmidt on 10/06/2014.
//  Copyright (c) 2014 Matelli. All rights reserved.
//

#import "MasterViewController.h"
#import "DetailViewController.h"
#import "ComingSoonViewController.h"

@interface MasterViewController ()

@end

@implementation MasterViewController
            
- (void)awakeFromNib {
    [super awakeFromNib];
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        self.clearsSelectionOnViewWillAppear = NO;
        self.preferredContentSize = CGSizeMake(320.0, 600.0);
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table View

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row != 0)
    {
        ComingSoonViewController * viewController = [[ComingSoonViewController alloc] init];
        [self.navigationController pushViewController:viewController animated:YES];
    }
}

@end
