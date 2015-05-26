//
//  ViewController.m
//  SuperHeroes
//
//  Created by David Seitz Jr on 5/26/15.
//  Copyright (c) 2015 DavidSights. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property NSArray *heroes;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

//    NSDictionary *hero1 = [NSDictionary dictionaryWithObjectsAndKeys:
//                           @"Superman", @"name",
//                           [NSNumber numberWithInt:32], @"age", nil];
//
//    NSDictionary *hero2 = [NSDictionary dictionaryWithObjectsAndKeys:
//                           @"Batman", @"name",
//                           [NSNumber numberWithInt:28], @"age", nil];
//    self.heroes = [NSArray arrayWithObjects:hero1, hero2, nil];

    self.heroes = [NSArray new];

    NSURL *url = [NSURL URLWithString:@"http://s3.amazonaws.com/mobile-makers-lib/superheroes.json"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        self.heroes = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&connectionError];
        [self.tableView reloadData];
    }];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.heroes.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellID"];
    NSDictionary *hero = [self.heroes objectAtIndex:indexPath.row];
    cell.textLabel.text = [hero objectForKey:@"name"];
    cell.detailTextLabel.text = [hero objectForKey:@"description"];

    return cell;
}
@end
