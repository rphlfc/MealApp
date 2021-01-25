//
//  RecipeDetailsView.swift
//  MealApp
//
//  Created by Raphael Cerqueira on 24/01/21.
//

import SwiftUI
import SDWebImageSwiftUI

struct RecipeDetailsView: View {
    var item: Meal
    @Environment(\.presentationMode) var presentation
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false, content: {
            VStack {
                ZStack {
                    WebImage(url: URL(string: item.strMealThumb ?? "Loading..."))
                        .resizable()
                        .foregroundColor(.gray)
                        .redacted(reason: item.strMealThumb == nil ? .placeholder : .init())
                        .frame(width: UIScreen.main.bounds.width, height:  UIScreen.main.bounds.width)
                        .overlay(
                            ZStack {
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
                                        })
                                        
                                        Spacer()
                                        
                                        Button(action: {}, label: {
                                            Image(systemName: "bookmark.fill")
                                                .foregroundColor(Color.green)
                                                .padding()
                                                .background(Color.white)
                                                .clipShape(Circle())
                                        })
                                    }
                                    .padding(.horizontal)
                                    
                                    Spacer()
                                }
                                .padding(.top, UIApplication.shared.windows.first?.safeAreaInsets.top)
                                
                                Button(action: {}, label: {
                                    Image(systemName: "play.circle.fill")
                                        .resizable()
                                        .foregroundColor(.green)
                                        .background(Color.white)
                                        .clipShape(Circle())
                                })
                                .frame(width: 80, height: 80)
                            }
                        )
                }
                
                VStack {
                    VStack {
                        Capsule()
                            .frame(width: 80, height: 4)
                            .foregroundColor(Color.gray.opacity(0.3))
                            .padding(.top)
                        
                        HStack {
                            Text(item.strCategory ?? "Loading...")
                                .font(.system(size: 15))
                                .fontWeight(.bold)
                                .textCase(.uppercase)
                                .foregroundColor(.green)
                                .padding(.horizontal, 8)
                                .padding(.vertical, 4)
                                .background(Color.green.opacity(0.15))
                            
                            Spacer()
                        }
                        .padding(.horizontal)
                        
                        HStack {
                            Text(item.strMeal ?? "Loading...")
                                .font(.system(size: 29, weight: .bold))
                            
                            Spacer()
                        }
                        .padding(.horizontal)
                        
                        HStack(spacing: 8) {
                            Text("by")
                                
                            Text("Raphael Cerqueira")
                                .fontWeight(.bold)
                            
                            Spacer()
                            
                            Text("12 ingredients")
                        }
                        .foregroundColor(.gray)
                        .padding(.top, 4)
                        .padding(.horizontal)
                        
                        Divider()
                        
                        HStack {
                            Image(systemName: "star.fill")
                                .foregroundColor(.yellow)
                            
                            Text("4.7")
                                .foregroundColor(.black)
                                .fontWeight(.bold)
                            
                            Text("(422 reviews)")
                                .foregroundColor(.gray)
                            
                            Image(systemName: "clock")
                                .foregroundColor(.gray)
                                .padding(.leading)
                            
                            Text("14 minutes")
                                .foregroundColor(.gray)
                            
                            Spacer()
                        }
                        .padding(.vertical)
                        .padding(.horizontal)
                    }
                    .background(Color.white)
                    
                    VStack {
                        HStack {
                            Text("Ingredients")
                                .font(.system(size: 23, weight: .bold))
                            
                            Spacer()
                            
                            Text("1 serving")
                                .fontWeight(.bold)
                                .foregroundColor(Color.green)
                        }
                        .padding(.vertical)
                        .padding(.horizontal)
                        
                        ForEach(0..<10) { i in
                            if item["strIngredient\(i)"] != nil && item["strIngredient\(i)"] != "" {
                                VStack {
                                    HStack {
                                        Text(item["strIngredient\(i)"] ?? "Loading...")
                                        
                                        Spacer()
                                        
                                        Text(item["strMeasure\(i)"] ?? "Loading...")
                                            .fontWeight(.bold)
                                    }
                                    .padding(.vertical)
                                    
                                    Divider()
                                }
                                .padding(.horizontal)
                            }
                        }
                        
                        Button(action: {}, label: {
                            Text("Start Cooking")
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                        })
                        .frame(width: UIScreen.main.bounds.width - 30, height: 70)
                        .background(Color.green)
                        .cornerRadius(5)
                        .padding(.horizontal)
                    }
                    .background(Color.white)
                }
                .background(Color.gray.opacity(0.3))
                .cornerRadius(30)
                .offset(y: -30)
            }
        })
        .navigationBarHidden(true)
        .ignoresSafeArea(.all, edges: .all)
    }
}

struct RecipeDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeDetailsView(item: items[0])
    }
}
