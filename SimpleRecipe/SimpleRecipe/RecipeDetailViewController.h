//
//  RecipeDetailViewController.h
//  SimpleRecipe
//
//  Created by FT on 18/11/13.
//  Copyright (c) 2013 FT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Recipe.h"
@interface RecipeDetailViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *prepTimeLabel;
@property (weak, nonatomic) IBOutlet UIImageView *recipePhoto;
@property (weak, nonatomic) IBOutlet UITextView *ingredientTextView;

@property (nonatomic, strong) Recipe *recipe;

@end
