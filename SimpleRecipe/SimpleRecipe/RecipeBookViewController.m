//
//  RecipeBookViewController.m
//  SimpleRecipe
//
//  Created by FT on 18/11/13.
//  Copyright (c) 2013 FT. All rights reserved.
//

#import "RecipeBookViewController.h"

@interface RecipeBookViewController ()

@end

@implementation RecipeBookViewController{
    NSMutableArray *recipes,*searchResults;
}

@synthesize tableView = _tableView;

- (void)viewDidLoad{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.

    // Find out the path of Recipes.plist
    NSString *path = [[NSBundle mainBundle] pathForResource:@"Recipes" ofType:@"plist"];
    // Load the file content and read the data into arrays
    NSDictionary *dict = [[NSDictionary alloc] initWithContentsOfFile:path];
    
    recipes = [[NSMutableArray alloc]init];
    searchResults = [[NSMutableArray alloc]init];
    for (int i = 0; i < 16; i++)
    {
        Recipe *recipe = [Recipe new];
        recipe.name         = [[dict objectForKey:@"RecipeName"] objectAtIndex:i];
        recipe.prepTime     = [[dict objectForKey:@"PrepTime"] objectAtIndex:i];
        recipe.ingredients  = [[dict objectForKey:@"Ingredients"] objectAtIndex:i];
        recipe.imageFile    = [[dict objectForKey:@"Thumbnail"] objectAtIndex:i];
        [recipes addObject:recipe];
    }
    searchResults = [NSMutableArray arrayWithCapacity:[recipes count]];
    
    //TableView Styling
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    self.parentViewController.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"common_bg"]];
    self.tableView.backgroundColor = [UIColor clearColor];
    UIEdgeInsets inset = UIEdgeInsetsMake(5, 0, 0, 0);
    self.tableView.contentInset = inset;

}

- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table View DataSource Methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(tableView == self.searchDisplayController.searchResultsTableView){
        return [searchResults count];
    }
    else{
        return [recipes count];
    }
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 71;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *simpleTableIdentifier = @"RecipeCell";
    
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    Recipe *recipe = [Recipe new];
    if(tableView == self.searchDisplayController.searchResultsTableView){
        recipe = [searchResults objectAtIndex:indexPath.row];
    }
    else{
        recipe = [recipes objectAtIndex:indexPath.row];
    }

    // Assign our own background image for the cell
    UIImage *background = [self cellBackgroundForRowAtIndexPath:indexPath];
    
    UIImageView *cellBackgroundView = [[UIImageView alloc] initWithImage:background];
    cellBackgroundView.image = background;
    cell.backgroundView = cellBackgroundView;
    
    // Assign Recipe Object values to Cell components 
    UIImageView *recipeImageView = (UIImageView *)[cell viewWithTag:100];
    recipeImageView.image = [UIImage imageNamed:recipe.imageFile];
    
    UILabel *recipeNameLabel = (UILabel *)[cell viewWithTag:101];
    recipeNameLabel.text = recipe.name;
    
    UILabel *recipeDetailLabel = (UILabel *)[cell viewWithTag:102];
    recipeDetailLabel.text = recipe.prepTime;
    
    return cell;
}

- (UIImage *)cellBackgroundForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger rowCount = [self tableView:[self tableView] numberOfRowsInSection:0];
    NSInteger rowIndex = indexPath.row;
    UIImage *background = nil;
    
    if (rowIndex == 0) {
        background = [UIImage imageNamed:@"cell_top.png"];
    } else if (rowIndex == rowCount - 1) {
        background = [UIImage imageNamed:@"cell_bottom.png"];
    } else {
        background = [UIImage imageNamed:@"cell_middle.png"];
    }
    
    return background;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:@"showRecipeDetail"]){
        RecipeDetailViewController *destViewController = segue.destinationViewController;
        
        NSIndexPath *indexPath = nil;
        if(sender == self.searchDisplayController.searchResultsTableView) {
//        if([self.searchDisplayController isActive]){
            indexPath = [self.searchDisplayController.searchResultsTableView indexPathForSelectedRow];
            destViewController.recipe = [recipes objectAtIndex:indexPath.row];
        }
        else{
            indexPath = [self.tableView indexPathForSelectedRow];
            destViewController.recipe = [recipes objectAtIndex:indexPath.row];
        }
        
    }
    
}

-(void)filteredContentForSearchText:(NSString *)searchText  scope:(NSString*)scope{
    [searchResults removeAllObjects];
    NSPredicate *resultPredicate = [NSPredicate
                                    predicateWithFormat:@"SELF.name Contains[cd] %@",searchText];
    searchResults = [NSMutableArray arrayWithArray:[recipes filteredArrayUsingPredicate:resultPredicate]];
}

#pragma mark - UISearchDisplayController Delegate Methods

-(BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString{
    [self filteredContentForSearchText:searchString
                                 scope:[[self.searchDisplayController.searchBar scopeButtonTitles]
                                        objectAtIndex:[self.searchDisplayController.searchBar
                                                       selectedScopeButtonIndex]]];
    return YES;
}



@end
