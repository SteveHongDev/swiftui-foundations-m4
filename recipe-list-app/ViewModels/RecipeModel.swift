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
}
