//
//  Recipe.h
//  SimpleRecipe
//
//  Created by FT on 19/11/13.
//  Copyright (c) 2013 FT. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Recipe : NSObject

@property (nonatomic, strong) NSString *name; //name of recipe
@property (nonatomic, strong) NSString *prepTime; //preparation time
@property (nonatomic, strong) NSString *imageFile; //image filename of recipe
@property (nonatomic, strong) NSArray *ingredients; //ingredients

@end
