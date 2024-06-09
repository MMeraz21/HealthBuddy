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
    @State private var toAddFoodItemView: Bool = false
    @State private var selectedFoodItem: FoodItem?
    
    @EnvironmentObject var userManager: UserProfileManager
    
    var feed: String {
        return "https://us.openfoodfacts.org/cgi/search.pl?search_terms=\(searchText)&search_simple=1&action=process&json=1"
    }
    
    func parseFoodList(){
        print(userManager.username)
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
                    let name = product["product_name"] as? String ?? "Unknown"
                    //print(name)
                    let nutriments = product["nutriments"] as? [String:Any]
                    let brandName = product["brands"] as? String ?? "Unknown"
                    //print(brandName)
                    let sugar = nutriments?["sugars_100g"] as? Double ?? 0.0
                    //print(sugar)
                    let calories = nutriments?["energy-kcal_100g"] as? Double ?? 0.0
                    //print(calories)
                    let fat = nutriments?["fat_100g"] as? Double ?? 0.0
                    //print(fat)
                    let protein = nutriments?["proteins_100g"] as? Double ?? 0.0
                    //print(protein)
                    let carbohydrates = nutriments?["carbohydrates_100g"] as? Double ?? 0.0
                    //print(carbohydrates)
                    //print(nutriments)
                    let foodItem = FoodItem(productName: name, brandName: brandName, protein: protein, sugar: sugar, calories: calories, carbs: carbohydrates, fat: fat, servingGrams: 100.0)
                    foodItems.append(foodItem)
                }

                //print(foodItems)
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
                .padding()
                
                NavigationLink(
                    destination: ScannerView().environmentObject(userManager),
                    isActive: $toScannerView,
                    label: {
                        EmptyView()
                    }
                )
                
                //add search items here
                if let searchResults = searchResults {
                    List(searchResults) { foodItem in
                        HStack {
                            VStack(alignment: .leading) {
                                Text(foodItem.productName)
                                    .font(.headline)
                                Text(foodItem.brandName)
                                    .font(.subheadline)
                            }
                            
                            Spacer()
                            
                            Image(systemName: "plus.circle")
                                .foregroundColor(.blue)
                                .onTapGesture {
                                    selectedFoodItem = foodItem
                                    toAddFoodItemView = true
                                }
                        }
                        .padding()
                        .cornerRadius(8)
                        //.shadow(radius: 1)
                    }
                    .listStyle(.insetGrouped)


                } else {
                    Text("No search results found")
                        .foregroundColor(.gray)
                    Spacer()
                }

            }

            .background(
                NavigationLink(
                    destination: AddFoodItemView(upc: "", foodItem: selectedFoodItem)
                        .environmentObject(userManager),
                    isActive: $toAddFoodItemView,
                    label: {
                        EmptyView()
                    }
                )
            )
        //} //navigation bracket
    }
}

//#Preview {
//    let userManager = UserProfileManager(username: "Johnny")
//    userManager.setUpUserProfile()
//    SearchView()
//        .environmentObject(userManager)
//}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        let userManager = UserProfileManager(username: "Johnny")
        userManager.setUpUserProfile()

        return SearchView()
            .environmentObject(userManager)
    }
}
