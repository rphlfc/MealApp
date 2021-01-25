//
//  PopularRecipesView.swift
//  MealApp
//
//  Created by Raphael Cerqueira on 24/01/21.
//

import SwiftUI
import SDWebImageSwiftUI

struct PopularRecipesView: View {
    @ObservedObject private var viewModel = PopularRecipesViewModel()
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Popular Recipes")
                .font(.system(size: 27, weight: .bold))
                .padding(.leading)
            
            ScrollView(.horizontal, showsIndicators: false, content: {
                HStack {
                    ForEach(viewModel.items ?? viewModel.placeholders, id: \.idMeal) { item in
                        NavigationLink(
                            destination: RecipeDetailsView(item: item),
                            label: {
                                RecipeThumbView(recipe: item)
                            })
                    }
                }
                .padding(.horizontal)
            })
        }
        .onAppear {
            viewModel.fetchData()
        }
    }
}

struct RecipeThumbView: View {
    var recipe: Meal
    
    var body: some View {
        WebImage(url: URL(string: recipe.strMealThumb ?? "Loading..."))
            .resizable()
            .foregroundColor(.gray)
            .redacted(reason: recipe.strMealThumb == nil ? .placeholder : .init())
            .frame(width: 200, height: 200)
            .overlay(
                VStack {
                    HStack {
                        HStack {
                            Image(systemName: "star.fill")
                                .foregroundColor(.yellow)
                            
                            Text("4.7")
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                                .redacted(reason: recipe.strMeal == nil ? .placeholder : .init())
                        }
                        .padding(6)
                        .background(Color.white.opacity(0.4))
                        
                        Spacer()
                        
                        HStack {
                            Image(systemName: "clock.fill")
                                .foregroundColor(.yellow)
                            
                            Text("10 min")
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                                .redacted(reason: recipe.strMeal == nil ? .placeholder : .init())
                        }
                        .padding(6)
                        .background(Color.white.opacity(0.4))
                    }
                    
                    Spacer()
                    
                    HStack {
                        VStack(alignment: .leading, spacing: 4) {
                            Text(recipe.strMeal ?? "Loading...")
                                .font(.system(size: 25, weight: .bold))
                                .foregroundColor(.white)
                                .redacted(reason: recipe.strMeal == nil ? .placeholder : .init())
                            
                            Text(recipe.strCategory ?? "Loading...")
                                .font(.system(size: 17, weight: .bold))
                                .foregroundColor(.white)
                                .redacted(reason: recipe.strCategory == nil ? .placeholder : .init())
                        }
                        
                        Spacer()
                    }
                }
                .padding(8)
                .background(LinearGradient(gradient: Gradient(colors: [Color.black, Color.clear]), startPoint: .bottom, endPoint: .top))
            )
            .cornerRadius(5)
    }
}

struct PopularRecipesView_Previews: PreviewProvider {
    static var previews: some View {
        PopularRecipesView()
    }
}
