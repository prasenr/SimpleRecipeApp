//
//  RecipeDetailViewController.m
//  SimpleRecipe
//
//  Created by FT on 18/11/13.
//  Copyright (c) 2013 FT. All rights reserved.
//

#import "RecipeDetailViewController.h"

@interface RecipeDetailViewController ()

@end

@implementation RecipeDetailViewController
@synthesize ingredientTextView,prepTimeLabel,recipePhoto,recipe;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    self.title = recipe.name;
    self.prepTimeLabel.text = recipe.prepTime;
    self.recipePhoto.image = [UIImage imageNamed:recipe.imageFile];
    
    NSMutableString *ingredientText = [NSMutableString string];
    for (NSString* ingredient in recipe.ingredients) {
        [ingredientText appendFormat:@"%@\n",ingredient];
    }
    self.ingredientTextView.text = ingredientText;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
