//
//  RecipeModel.swift
//  recipe-list-app
//
//  Created by 홍성범 on 2022/02/07.
//

import Foundation

class RecipeModel: ObservableObject {
    
    @Published var recipes = [Recipe]()
    
    init() {
        
        // Create an instance of data service and get the data
        self.recipes = DataService.getLocalData()
        
        // Set the recipes property
    }
    
    static func getPortion(ingredient: Ingredient, recipeServings: Int, targetServings: Int) -> String {
        
        var portion = ""
        var numerator = ingredient.num ?? 1
        var denominator = ingredient.denom ?? 1
        var whole = 0
        
        if ingredient.num != nil {
            
            // Get a single serving size by multiplying denominator by the recipe servings
            denominator *= recipeServings
            
            // Get target portion by multiplying numerator by target servings
            numerator *= targetServings
            
            // Reduce fraction by GCD
            let divisor = Rational.greatestCommonDivisor(numerator, denominator)
            numerator /= divisor
            denominator /= divisor
            
            
            // Express the remainder as a fraction
            if numerator >= denominator {
                // Get the whole portion
                whole = numerator / denominator
                // Get the remainder
                numerator %= denominator
                
                // Add whole portion in the string
                portion += String(whole)
            }
            
            // Add the remainder in the string if it exists
            if (numerator > 0) {
                portion += whole > 0 ? " " : ""
                portion += "\(numerator)/\(denominator)"
            }
            
        }
        
        if var unit = ingredient.unit {
            
            // Add the unit in the string
            portion += ingredient.num == nil && ingredient.denom == nil ? "" : " "
            
            // suffix (check singular or plural)
            if whole > 1 {
                if unit.suffix(2) == "ch" {
                    unit += "es"
                } else if unit.suffix(1) == "f" {
                    unit = String(unit.dropLast())
                    unit += "ves"
                } else {
                    unit += "s"
                }
            }
            
            return portion + unit
        }
        
        return portion
    }
}
