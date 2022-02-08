//
//  DataService.swift
//  recipe-list-app
//
//  Created by 홍성범 on 2022/02/07.
//

import Foundation

class DataService {
    
    static func getLocalData() -> [Recipe] {
        
        // Parse local json file
        
        
        // Get a url path to the json file
        let pathString = Bundle.main.path(forResource: "recipes", ofType: "json")
        guard let pathString = pathString else {
            return [Recipe]()
        }
        
        // Create a url object
        let url = URL(fileURLWithPath: pathString)
        
        // Create a data object
        do {
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            
            do {
                // Decode the data with a JSON decoder
                let recipeData = try decoder.decode([Recipe].self, from: data)
                
                // Add the unique IDs
                for r in recipeData {
                    r.id = UUID()
                }
                
                // Return the recipes
                return recipeData
                
            } catch {
                print("Couldn't decode data")
            }
            
        } catch {
            print("Couldn't get data")
        }
        
        return [Recipe]()
    }
}
