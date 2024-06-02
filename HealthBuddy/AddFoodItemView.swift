//
//  AddFoodItemView.swift
//  HealthBuddy
//
//  Created by Manuel Meraz on 5/31/24.
//

import SwiftUI

struct AddFoodItemView: View {
    var upc: String
    var feed: String {
        return "https://us.openfoodfacts.org/api/v0/product/\(upc).json"
    }
    @State private var currObj = FoodItem()
    @State private var pname: String = ""
    @State private var viewCalories: Int = 0
    @State private var servingSize: Double = 100.0
    
    enum SerializationError: Error{
        case missing(String)
        case invalid(String, Any)
    }
    var formatter: NumberFormatter{
        let form = NumberFormatter()
        form.numberStyle = .decimal
        return form
    }
    
    func parseSingleObj(){
        print("parsing obj")
        guard let feedUrl = URL(string: feed) else {return}
        
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
            do{
                let jsonObj = try JSONSerialization.jsonObject(with: jsonData, options: [])
                guard let jsonDict = jsonObj as? [String: Any],
                      let product = jsonDict["product"] as? [String: Any],
                      let nutriments = product["nutriments"] as? [String:Any]
                else {
                    print("Invalid JSON")
                    return
                }
                print(nutriments)
                
                let name = product["product_name"] as? String ?? "Unknown"
                print(name)
                let brandName = product["brands"] as? String ?? "Unknown"
                print(brandName)
                let sugar = nutriments["sugars_100g"] as? Double ?? 0.0
                print(sugar)
                let calories = nutriments["energy-kcal_100g"] as? Double ?? 0.0
                print(calories)
                let fat = nutriments["fat_100g"] as? Double ?? 0.0
                print(fat)
                let protein = nutriments["proteins_100g"] as? Double ?? 0.0
                print(protein)
                let carbohydrates = nutriments["carbohydrates_100g"] as? Double ?? 0.0
                print(carbohydrates)
                DispatchQueue.main.async{
                    currObj = FoodItem(productName: name, brandName: brandName, protein: protein, sugar: sugar, calories: calories, carbs: carbohydrates, fat: fat)
                    pname = currObj.productName
                    //viewCalories  = currObj.calories
                }

                
            }catch{
                print("JSON Serialization Error:", error)
            }
            
            
        }.resume()
    }
    
    var body: some View {
        VStack {
            VStack{
                Text(currObj.productName)
                    .foregroundColor(.black)
                    .padding(.bottom, 2)
                    .frame(maxWidth: .infinity, alignment: .leading)
                Text(currObj.brandName)
                    .foregroundColor(.black)
                    .padding(.bottom, 2)
                    .frame(maxWidth: .infinity, alignment: .leading)

            }
            HStack{
                Text("Serving Size")
                    .foregroundColor(.black)
                    .padding()
                
                Spacer()
                
                TextField("100.0", value: $servingSize, formatter: formatter)
                    .textFieldStyle(WhiteBGStyle())
                    .keyboardType(.decimalPad)
                    .frame(minWidth: 30)
                    .fixedSize(horizontal: true, vertical: false)
                    .padding(.leading, 8)
                    //.padding(.bottom, 2)
                    //.foregroundColor(.black)
                    .background(Color.white)


                
                Text("g")
                    .foregroundColor(.black)
                    .padding()

            }
            HStack{
                Text("Calories: \(currObj.calories)")
                    .foregroundColor(.black)
                    .padding()
            }
            Text("Fat: \(currObj.fat)")
                .foregroundColor(.black)
                .padding()
            Text("Protein: \(currObj.protein)")
                .foregroundColor(.black)
                .padding()
            Text("Carbohydrates: \(currObj.carbs)")
                .foregroundColor(.black)
                .padding()
            Button(action: {
                print("Blue button pressed")
            }) {
                Text("Blue Button")
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(8)
            }
            .padding()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity) //needed to not inherit bg from parent view
        .background(Color.white)
        .edgesIgnoringSafeArea(.all)
        .navigationBarHidden(true)
        .onAppear{
            parseSingleObj()
        }
    }
}

struct WhiteBGStyle: TextFieldStyle {
    func _body(configuration: TextField<_Label>) -> some View {
        configuration
            .padding(5)
            .background(Color.white)
            .cornerRadius(5)
            .overlay(
                RoundedRectangle(cornerRadius: 5)
                    .stroke(Color.gray, lineWidth: 1)
            )
            .foregroundColor(.black)
    }
}

#Preview {
    AddFoodItemView(upc: "043000208120")
}
