//
//  SearchView.swift
//  HealthBuddy
//
//  Created by Manuel Meraz on 6/5/24.
//

import SwiftUI

struct SearchView: View {
    @State private var searchText: String = ""
    @State private var searchResults: [FoodItem]?
    @State private var toScannerView: Bool = false
    
    var feed: String {
        return "https://us.openfoodfacts.org/cgi/search.pl?search_terms=\(searchText)&search_simple=1&action=process&json=1"
    }
    
    func parseFoodList(){
        guard let feedUrl = URL(string: feed) else {return}
        print(feed)
        
        
        let request = URLRequest(url: feedUrl)
        let session = URLSession.shared
        
        session.dataTask(with: request){ data, response, error in
            
            guard error == nil else{
                print("error")
                print(error!.localizedDescription)
                return
            }
            guard let jsonData = data else {
                print("error with jsonData")
                return
            }
            
            do {
                let jsonObj = try JSONSerialization.jsonObject(with: jsonData, options: [])
                //print(jsonObj)
                guard let jsonDict = jsonObj as? [String: Any],
                      let products = jsonDict["products"] as? [[String: Any]] else {
                    print("Invalid JSON")
                    return
                }

                var foodItems: [FoodItem] = []

                for product in products {
                    print(product)
                    guard let productDict = product["product"] as? [String: Any],
                          let nutriments = productDict["nutriments"] as? [String: Any],
                          let name = productDict["product_name"] as? String,
                          let brandName = productDict["brands"] as? String,
                          let sugar = nutriments["sugars_100g"] as? Double,
                          let calories = nutriments["energy-kcal_100g"] as? Double,
                          let fat = nutriments["fat_100g"] as? Double,
                          let protein = nutriments["proteins_100g"] as? Double,
                          let carbohydrates = nutriments["carbohydrates_100g"] as? Double else {
                        print("Invalid product data")
                        continue
                    }

                    let foodItem = FoodItem(productName: name, brandName: brandName, protein: protein, sugar: sugar, calories: calories, carbs: carbohydrates, fat: fat)
                    foodItems.append(foodItem)
                }

                print(foodItems)
                DispatchQueue.main.async{
                    searchResults = foodItems
                }
                
            } catch {
                print("Error parsing JSON:", error)
            }

            
        }.resume()
    }
    
    var body: some View {
        //NavigationView{
            VStack{
                HStack {
                    TextField("Search...", text: $searchText)
                        .padding(7)
                        .padding(.horizontal, 25)
                        .background(Color(.systemGray6))
                        .cornerRadius(8)
                        .overlay(
                            HStack {
                                Image(systemName: "magnifyingglass")
                                    .foregroundColor(.gray)
                                    .padding(.leading, 8)
                                    .onTapGesture {
                                        parseFoodList()
                                    }
                                Spacer()
                                Image(systemName: "barcode.viewfinder")
                                    .foregroundColor(.gray)
                                    .padding(.trailing, 8)
                                    .onTapGesture {
                                        toScannerView = true
                                    }
                            }
                        )
                        .padding(.horizontal, 10)
                }
                NavigationLink(
                    destination: ScannerView(),
                    isActive: $toScannerView,
                    label: {
                        EmptyView()
                    }
                )
                
                //add search items here
                if let searchResults = searchResults {
                    List(searchResults) { foodItem in
                        VStack(alignment: .leading) {
                            Text(foodItem.productName)
                                .font(.headline)
                            Text(foodItem.brandName)
                                .font(.subheadline)
                            // Add more details as needed
                        }
                        .padding(.vertical, 8)
                    }
                } else {
                    Text("No search results found")
                        .foregroundColor(.gray)
                }

            }
        //}
    }
}

#Preview {
    SearchView()
}
