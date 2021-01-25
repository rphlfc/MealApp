//
//  HomeView.swift
//  MealApp
//
//  Created by Raphael Cerqueira on 24/01/21.
//

import SwiftUI
import SDWebImageSwiftUI

struct HomeView: View {
    @State var search: String = ""
    var menuOptions = ["For You", "Vegetable", "Fruit", "Meat", "Noodle"]
    @State var selectedIndex = 0
    @Namespace var animation
    @State var showSearchResult = false
    
    var body: some View {
        NavigationView {
            ScrollView(.vertical, showsIndicators: /*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/, content: {
                VStack(alignment: .leading) {
                    ZStack {
                        HStack {
                            Button(action: {}, label: {
                                VStack(alignment: .leading, spacing: 3) {
                                    ForEach(0..<3) { i in
                                        Capsule()
                                            .frame(width: i == 1 ? 14 : 20, height: 4)
                                            .foregroundColor(i == 1 ? Color.green : Color.black)
                                    }
                                }
                                .frame(width: 50, height: 50)
                                .clipShape(Circle())
                                .background(Circle().strokeBorder(Color.gray.opacity(0.3), lineWidth: 1))
                            })
                            
                            Spacer()
                            
                            Button(action: {}, label: {
                                Image(systemName: "bookmark")
                                    .font(.system(size: 19, weight: .bold))
                                    .foregroundColor(Color.black)
                                    .frame(width: 50, height: 50)
                                    .clipShape(Circle())
                                    .background(Circle().strokeBorder(Color.gray.opacity(0.3), lineWidth: 1))
                            })
                        }
                        .padding(.horizontal)
                        
                        HStack(spacing: 0) {
                            Text("Meal")
                                .font(.system(size: 27, weight: .bold))
                            
                            Text("App")
                                .font(.system(size: 27))
                        }
                    }
                    
                    Divider()
                        .padding(.top, 8)
                    
                    Text("What do you want to\ncook today?")
                        .font(.system(size: 27, weight: .bold))
                        .padding(.top, 30)
                        .padding(.leading)
                    
                    HStack(spacing: 15) {
                        Image(systemName: "magnifyingglass")
                            .font(.system(size: 27, weight: .bold))
                            .foregroundColor(.gray)
                        
                        TextField("Try 'Salad'",
                                  text: $search,
                                  onEditingChanged: { edit in
                                    print("edit = \(edit)")
                                  },
                                  onCommit: {
                                    showSearchResult = true
                                  })
                            .font(.system(size: 21))
                    }
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 10).strokeBorder(Color.gray.opacity(0.3), lineWidth: 1))
                    .padding(.top)
                    .padding(.horizontal)
                    
                    NavigationLink(destination: SearchView(search: $search), isActive: $showSearchResult) {
                        EmptyView()
                    }
                    .hidden()
                    
                    VStack(spacing: 0) {
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 25) {
                                ForEach(0..<menuOptions.count) { index in
                                    Button(action: {
                                        withAnimation {
                                            selectedIndex = index
                                        }
                                    }, label: {
                                        VStack {
                                            Text(menuOptions[index])
                                                .font(.system(size: index == selectedIndex ? 19 : 17, weight:  index == selectedIndex ? .bold : .regular))
                                                .foregroundColor(index == selectedIndex ? .black : .gray)
                                            
                                            ZStack {
                                                //                                        Capsule()
                                                //                                            .fill(Color.clear)
                                                //                                            .frame(height: 4)
                                                
                                                if selectedIndex == index {
                                                    Capsule()
                                                        .fill(Color(#colorLiteral(red: 0.02946649678, green: 0.6407182813, blue: 0.3381308317, alpha: 1)))
                                                        .frame(height: 4)
                                                        .matchedGeometryEffect(id: "category", in: animation)
                                                }
                                            }
                                        }
                                    })
                                }
                            }
                            .padding(.horizontal)
                        }
                        .padding(.top)
                        
                        Divider()
                    }
                    
                    PopularRecipesView()
                        .padding(.top)
                    
                    NewRecipesView()
                        .padding(.top)
                    
                    Spacer()
                }
            })
            .navigationBarHidden(true)
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
