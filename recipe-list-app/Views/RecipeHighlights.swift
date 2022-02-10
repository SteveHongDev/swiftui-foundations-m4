//
//  RecipeHighlights.swift
//  recipe-list-app
//
//  Created by 홍성범 on 2022/02/10.
//

import SwiftUI

struct RecipeHighlights: View {
    
    var allHighlights = ""
    
    init(highlights: [String]) {
        
        for i in 0..<highlights.count {
            if i == highlights.count - 1 {
                allHighlights += highlights[i]
            } else {
                allHighlights += highlights[i] + ", "
            }
        }
    }
    
    var body: some View {
        Text(allHighlights)
    }
}

struct RecipeHighlights_Previews: PreviewProvider {
    static var previews: some View {
        RecipeHighlights(highlights: ["123", "456"])
    }
}
