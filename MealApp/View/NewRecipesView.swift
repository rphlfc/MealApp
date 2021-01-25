//
//  NewRecipesView.swift
//  MealApp
//
//  Created by Raphael Cerqueira on 24/01/21.
//

import SwiftUI
import SDWebImageSwiftUI

struct NewRecipesView: View {
    @ObservedObject private var viewModel = NewRecipesViewModel()
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("New Recipes")
                .font(.system(size: 27, weight: .bold))
            
            VStack {
                ForEach(viewModel.items ?? viewModel.placeholders, id: \.idMeal) { item in
                    NavigationLink(
                        destination: RecipeDetailsView(item: item),
                        label: {
                            NewRecipeView(item: item)
                        })
                }
            }
        }
        .padding(.horizontal)
        .onAppear {
            viewModel.fetchData()
        }
    }
}

struct NewRecipeView: View {
    var item: Meal
    
    var body: some View {
        HStack(alignment: .top) {
            VStack(alignment: .leading, spacing: 8) {
                Text(item.strMeal ?? "Loading...")
                    .font(.system(size: 19, weight: .bold))
                    .foregroundColor(Color.black)
                    .redacted(reason: item.strMeal == nil ? .placeholder : .init())
                
                Text(item.strCategory ?? "Loading...")
                    .font(.system(size: 19, weight: .bold))
                    .foregroundColor(.gray)
                    .redacted(reason: item.strCategory == nil ? .placeholder : .init())
                
                HStack(spacing: 4) {
                    Image(systemName: "clock")
                        .font(.system(size: 13))
                        .foregroundColor(.gray)
                    
                    Text("10 minutes")
                        .font(.system(size: 13, weight: .semibold))
                        .foregroundColor(.gray)
                        .redacted(reason: item.strCategory == nil ? .placeholder : .init())
                }
            }
            .padding(.top)
            .padding(.leading)
            
            Spacer()
            
            ZStack(alignment: .topTrailing) {
                WebImage(url: URL(string: item.strMealThumb ?? "Loading..."))
                    .resizable()
                    .foregroundColor(.gray)
                    .redacted(reason: item.strMealThumb == nil ? .placeholder : .init())
                    .frame(width: 100, height: 100)
                
                HStack {
                    Image(systemName: "star.fill")
                        .foregroundColor(.yellow)
                    
                    Text("4.7")
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .redacted(reason: item.strMeal == nil ? .placeholder : .init())
                }
                .padding(6)
                .background(Color.white.opacity(0.4))
                .padding(6)
            }
        }
        .frame(width: UIScreen.main.bounds.width - 30)
        .background(RoundedRectangle(cornerRadius: 10).strokeBorder(Color.gray.opacity(0.3), lineWidth: 1))
    }
}

struct NewRecipesView_Previews: PreviewProvider {
    static var previews: some View {
        NewRecipesView()
    }
}
