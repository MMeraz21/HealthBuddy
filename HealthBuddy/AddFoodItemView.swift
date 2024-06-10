//
//  AddFoodItemView.swift
//  HealthBuddy
//
//  Created by Manuel Meraz on 5/31/24.
//

import SwiftUI

struct AddFoodItemView: View {
    var upc: String?
    var foodItem: FoodItem?
    var feed: String {
        return "https://us.openfoodfacts.org/api/v0/product/\(upc).json"
    }
    @State private var currObj = FoodItem()
    @State private var pname: String = ""
    @State private var viewCalories: Double = 0.0
    @State private var viewFat: Double = 0.0
    @State private var viewProtein: Double = 0.0
    @State private var viewCarbs: Double = 0.0
    @State private var viewSugar: Double = 0.0
    
    @State private var servingSize: Double = 100.0
    
    @State private var isHomeViewActive: Bool = false
    @State private var isNavigatingToHomeView = false

    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var userManager: UserProfileManager

    
    enum SerializationError: Error{
        case missing(String)
        case invalid(String, Any)
    }
    var formatter: NumberFormatter{
        let form = NumberFormatter()
        form.numberStyle = .decimal
        return form
    }
    
    var cals: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 0
        return formatter.string(from: NSNumber(value: currObj.calories)) ?? "N/A"
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
                    currObj = FoodItem(productName: name, brandName: brandName, protein: protein, sugar: sugar, calories: calories, carbs: carbohydrates, fat: fat, servingGrams: 100.0)
                    pname = currObj.productName
                    viewCalories  = currObj.calories
                    viewFat = currObj.fat
                    viewProtein = currObj.protein
                    viewCarbs = currObj.carbs
                    viewSugar = currObj.sugar
                }

                
            }catch{
                print("JSON Serialization Error:", error)
            }
            
            
        }.resume()
        

    }
    
    func updateNutriments(){
        viewCalories = (servingSize/100.0) * currObj.calories
        viewFat = (servingSize/100.0) * currObj.fat
        viewProtein = (servingSize/100.0) * currObj.protein
        viewCarbs = (servingSize/100.0) * currObj.carbs
        viewSugar = (servingSize/100.0) * currObj.sugar
    }
    
    var body: some View {
        ScrollView{
            Spacer().frame(height:40)
        VStack {
            VStack(alignment: .leading){
                Text(currObj.productName)
                    .foregroundColor(.black)
                    .padding(.bottom, 4)
                    .frame(maxWidth: .infinity, alignment: .leading)
                Text(currObj.brandName)
                    .foregroundColor(.black)
                    .padding(.bottom, 4)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
            }
            .frame(alignment: .topLeading)
            .padding([.top, .leading, .trailing])
            .alignmentGuide(.top) { d in d[.top] }
            .padding(.horizontal)
            //.padding()
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.gray, lineWidth: 1)
            )
            .padding(.horizontal)
            
            Spacer().frame(height: 40)
            
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
                Text("Calories")
                    .foregroundColor(.black)
                    .padding()
                
                Spacer()
                
                Text("\(Int(viewCalories)) kcal")
                    .foregroundColor(.black)
                    .padding()
            }
            HStack{
                Text("Fat")
                    .foregroundColor(.black)
                    .padding()
                
                Spacer()
                
                Text("\(Int(viewFat)) g")
                    .foregroundColor(.black)
                    .padding()
                
            }
            HStack{
                Text("Protein")
                    .foregroundColor(.black)
                    .padding()
                
                Spacer()
                
                Text("\(Int(viewProtein)) g")
                    .foregroundColor(.black)
                    .padding()
                
            }
            HStack{
                Text("Carbohydrates")
                    .foregroundColor(.black)
                    .padding()
                
                Spacer()
                
                Text("\(Int(viewCarbs)) g")
                    .foregroundColor(.black)
                    .padding()
                
            }
            HStack{
                Text("Sugar")
                    .foregroundColor(.black)
                    .padding()
                
                Spacer()
                
                Text("\(Int(viewSugar)) g")
                    .foregroundColor(.black)
                    .padding()
            }
            Spacer().frame(height: 100)
            
            Button(action: {
                //presentationMode.wrappedValue.dismiss()
                isNavigatingToHomeView = true
                userManager.dailyLog?.foodItems.append(currObj)
                userManager.saveProfile()
                isNavigatingToHomeView = true
            }) {
                Text("Blue Button")
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(8)
            }
            .padding()
            
            Spacer().frame(height: 5)
            
            NavigationLink(
                destination: HomeView(username: userManager.username),
                isActive: $isNavigatingToHomeView,
                label: {
                    EmptyView()
                }
            )
            
        }}.onTapGesture() {
            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity) //needed to not inherit bg from parent view
        .background(Color.white)
        .edgesIgnoringSafeArea(.all)
        .navigationBarHidden(true)
        .onAppear{
            print(userManager.username)
            if let foodItem = foodItem{
                currObj = foodItem
                pname = foodItem.productName
                viewCalories = foodItem.calories
                viewFat = foodItem.fat
                viewProtein = foodItem.protein
                viewCarbs = foodItem.carbs
                viewSugar = foodItem.sugar
                
            }else{
                parseSingleObj()
            }
        }
        .onChange(of: servingSize){ newvalue in
            updateNutriments()
            
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

//#Preview {
//    AddFoodItemView(upc: "043000208120")
//}
