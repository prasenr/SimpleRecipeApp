//
//  RecipeBookViewController.h
//  SimpleRecipe
//
//  Created by FT on 18/11/13.
//  Copyright (c) 2013 FT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RecipeDetailViewController.h"
#import "Recipe.h"

@interface RecipeBookViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UISearchDisplayDelegate,UISearchBarDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end
