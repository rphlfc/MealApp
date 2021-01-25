//
//  SearchView.swift
//  MealApp
//
//  Created by Raphael Cerqueira on 25/01/21.
//

import SwiftUI

struct SearchView: View {
    @Environment(\.presentationMode) var presentation
    @ObservedObject private var viewModel = SearchViewModel()
    @Binding var search: String
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false, content: {
            VStack {
                HStack {
                    Button(action: {
                        presentation.wrappedValue.dismiss()
                    }, label: {
                        Image(systemName: "chevron.left")
                            .foregroundColor(Color.gray)
                            .padding()
                            .background(Color.white)
                            .clipShape(Circle())
                            .shadow(radius: 5)
                    })
                    
                    Spacer()
                }
                .padding(.horizontal)
                
                HStack {
                    Text("Search result")
                        .font(.system(size: 29, weight: .bold))
                    
                    Spacer()
                }
                .padding(.horizontal)
                .padding(.top)
                
                if viewModel.items != nil {
                    VStack {
                        ForEach(viewModel.items ?? viewModel.placeholders, id: \.idMeal) { item in
                            NavigationLink(
                                destination: RecipeDetailsView(item: item),
                                label: {
                                    NewRecipeView(item: item)
                                })
                        }
                    }
                } else {
                    Text("No results")
                        .font(.system(size: 21, weight: .semibold))
                        .foregroundColor(Color.gray)
                        .padding(.top)
                }
                
                Spacer()
            }
        })
        .navigationBarHidden(true)
        .onAppear {
            viewModel.fetchData(query: self.search)
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView(search: .constant("Salad"))
    }
}
