//
//  RecipeListView.swift
//  recipe-list-app
//
//  Created by 홍성범 on 2022/02/07.
//

import SwiftUI

struct RecipeListView: View {
    
    @EnvironmentObject var model: RecipeModel
    
    var body: some View {
        
        NavigationView {
            
            VStack (alignment: .leading) {
                Text("All Recipes")
                    .fontWeight(.bold)
                    .padding(.top, 40)
                    .font(Font.custom("Avenir Heavy", size: 30))
                
                ScrollView {
                    LazyVStack (alignment: .leading) {
                        ForEach (model.recipes) { r in
                            
                            NavigationLink {
                                RecipeDetailView(recipe: r)
                            } label: {
                                HStack(spacing: 20.0) {
                                    Image(r.image)
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 50, height: 50, alignment: .center)
                                        .clipped()
                                        .cornerRadius(5.0)
                                    VStack(alignment: .leading) {
                                        Text(r.name)
                                            .font(Font.custom("Avenir Heavy", size: 18))
                                            .foregroundColor(.black)
                                            
                                            
                                        RecipeHighlights(highlights: r.highlights)
                                            .foregroundColor(.black)
                                            .font(Font.custom("Avenir", size: 16))
                                    }
                                }
                            }
                        }
                    }
                    
                }
            }
            .padding(.leading)
            .navigationBarHidden(true)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeListView()
            .environmentObject(RecipeModel())
    }
}
