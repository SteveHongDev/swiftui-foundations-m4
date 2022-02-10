//
//  RecipeFeaturedView.swift
//  recipe-list-app
//
//  Created by 홍성범 on 2022/02/08.
//

import SwiftUI

struct RecipeFeaturedView: View {
    
    @EnvironmentObject var model: RecipeModel
    @State var isDetailViewShowing = false
    @State var tabSelectionIndex = 0
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 0) {
            
            Text("Featured Recipes")
                .fontWeight(.bold)
                .padding(.leading)
                .padding(.top, 40)
                .font(Font.custom("Avenir Heavy", size: 30))
            
            GeometryReader { geo in
            
                TabView (selection: $tabSelectionIndex) {
                
                // loop through each recipe
                ForEach (0..<model.recipes.count) { index in
                    
                    // Only show those that should be featured
                    if model.recipes[index].featured {
                        
                        // Recipe card Button
                        Button {
                            // show recipe detail view sheet
                            self.isDetailViewShowing = true
                            
                        } label: {
                            // Recipe card
                            ZStack {
                                Rectangle()
                                    .foregroundColor(.white)
                                
                                VStack {
                                    Image(model.recipes[index].image)
                                        .resizable()
                                        .scaledToFill()
                                        .clipped()
                                    Text(model.recipes[index].name)
                                        .padding(5)
                                        .font(Font.custom("Avenir", size: 16))
                                }
                            }
                        }
                        .tag(index)
                        .sheet(isPresented: $isDetailViewShowing) {
                            // Show the RecipeDetailView
                            RecipeDetailView(recipe: model.recipes[index])
                        }
                        .buttonStyle(PlainButtonStyle())
                        .frame(width: geo.size.width - 40, height: geo.size.height - 100, alignment: .center)
                        .cornerRadius(15)
                        .shadow(color: Color(.sRGB, red: 0, green: 0, blue: 0, opacity: 0.5), radius: 10, x: -5, y: 5)
                        
                        
                        
                            
                    }
                }
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .automatic))
            .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
        }
            
            VStack(alignment: .leading, spacing: 10) {
                Text("Preparation Time")
                    .font(Font.custom("Avenir Heavy", size: 18))
                Text(model.recipes[tabSelectionIndex].prepTime)
                    .foregroundColor(Color.white)
                    .padding(4)
                    .background(.gray)
                    .cornerRadius(7)
                    .font(Font.custom("Avenir", size: 16))
                    
                    
                Text("Highlights")
                    .font(Font.custom("Avenir Heavy", size: 18))
                HStack {
                    ForEach (model.recipes[tabSelectionIndex].highlights, id: \.self) { item in
                        
                            Text(item)
                                .foregroundColor(Color.white)
                                .padding(4)
                                .background(.gray)
                                .cornerRadius(7)
                                .font(Font.custom("Avenir", size: 16))
                        
                    }
                }
            }
            .padding([.leading, .bottom])
        }
        .onAppear {
            setFeaturedIndex()
        }
    }
    
    func setFeaturedIndex() {
        var index = model.recipes.firstIndex { recipe in
            return recipe.featured
        }
        
        tabSelectionIndex = index ?? 0
    }
}

struct RecipeFeaturedView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeFeaturedView()
            .environmentObject(RecipeModel())
    }
}
