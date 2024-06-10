//
//  CreateFoodItemView.swift
//  HealthBuddy
//
//  Created by Manuel Meraz on 6/8/24.
//

import SwiftUI

struct CreateFoodItemView: View {
    @EnvironmentObject var userManager: UserProfileManager
    
    @State private var pname: String = ""
    @State private var bName: String = ""
    @State private var viewCalories: Double = 0.0
    @State private var viewFat: Double = 0.0
    @State private var viewProtein: Double = 0.0
    @State private var viewCarbs: Double = 0.0
    @State private var viewSugar: Double = 0.0
    @State private var servingSize: Double = 0.0
    
    @State private var toHomeView = false
    
    var formatter: NumberFormatter{
        let form = NumberFormatter()
        form.numberStyle = .decimal
        return form
    }
    
    
    var body: some View {
        ScrollView{
            VStack(alignment: .leading){
                TextField("Product Name", text: $pname)
                    //.fixedSize(horizontal: true, vertical: false)
                    .padding(.leading, 8)
                
                //Spacer()
                
                TextField("Brand Name", text: $bName)
                    //.fixedSize(horizontal: true, vertical: false)
                    .padding(.leading, 8)
            }
            //.frame(alignment: .topLeading)
            .padding([.top, .leading, .trailing])
            //.alignmentGuide(.top) { d in d[.top] }
            //.padding(.horizontal)
            
            Spacer().frame(height: 40)
            
            
            HStack{
                Text("Serving Size:")
                    .padding()
                
                Spacer()
                
                TextField("0.0", value: $servingSize, formatter: formatter)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .keyboardType(.decimalPad)
                    .frame(minWidth: 30)
                    .fixedSize(horizontal: true, vertical: false)
                    .padding(.leading, 4)
                //.padding()
                
                Text("g")
                    .padding()
                
            }
            
            HStack{
                Text("Calories:")
                    .padding()
                
                Spacer()
                
                TextField("0.0", value: $viewCalories, formatter: formatter)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .keyboardType(.decimalPad)
                    .frame(minWidth: 30)
                    .fixedSize(horizontal: true, vertical: false)
                    .padding(.leading, 4)
                //.padding()
                
                Text("kcal")
                    .padding()
                
            }
            HStack{
                Text("Fat:")
                    .padding()
                
                Spacer()
                
                TextField("0.0", value: $viewFat, formatter: formatter)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .keyboardType(.decimalPad)
                    .frame(minWidth: 30)
                    .fixedSize(horizontal: true, vertical: false)
                    .padding(.leading, 4)
                //.padding()
                
                Text("g")
                    .padding()
                
            }
            HStack{
                Text("Protein:")
                    .padding()
                
                Spacer()
                
                TextField("0.0", value: $viewProtein, formatter: formatter)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .keyboardType(.decimalPad)
                    .frame(minWidth: 30)
                    .fixedSize(horizontal: true, vertical: false)
                    .padding(.leading, 4)
                //.padding()
                
                Text("g")
                    .padding()
                
            }
            HStack{
                Text("Carbohydrates:")
                    .padding()
                
                Spacer()
                
                TextField("0.0", value: $viewCarbs, formatter: formatter)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .keyboardType(.decimalPad)
                    .frame(minWidth: 30)
                    .fixedSize(horizontal: true, vertical: false)
                    .padding(.leading, 4)
                //.padding()
                
                Text("g")
                    .padding()
                
            }
            HStack{
                Text("Sugar:")
                    .padding()
                
                Spacer()
                
                TextField("0.0", value: $viewSugar, formatter: formatter)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .keyboardType(.decimalPad)
                    .frame(minWidth: 30)
                    .fixedSize(horizontal: true, vertical: false)
                    .padding(.leading, 4)
                //.padding()
                
                Text("g")
                    .padding()
                
            }
            
            Spacer().frame(height: 100)
            
            Button(action: {
                //presentationMode.wrappedValue.dismiss()
                let newItem = FoodItem(productName: pname, brandName: bName, protein: viewProtein, sugar: viewSugar, calories: viewCalories, carbs: viewCarbs, fat: viewFat, servingGrams: servingSize)
                userManager.dailyLog?.foodItems.append(newItem)
                userManager.userProfile?.addedFoodItems.append(newItem)
                userManager.saveProfile()
                toHomeView = true
            }) {
                Text("Create Item")
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(8)
            }
            .padding()
            
            Spacer().frame(height: 5)
            
            NavigationLink(
                destination: HomeView(username: userManager.username),
                isActive: $toHomeView,
                label: {
                    EmptyView()
                }
            )
        }.onTapGesture() {
            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        }
    }
}

//#Preview {
//    CreateFoodItemView()
//}

struct CreateView_Previews: PreviewProvider {
    struct CreateViewPreviewWrapper: View {
        //@State var isInSearchView = true

        var body: some View {
            let userManager = UserProfileManager(username: "Johnny")
            userManager.setUpUserProfile()

            return CreateFoodItemView()
                .environmentObject(userManager)
        }
    }

    static var previews: some View {
        CreateViewPreviewWrapper()
    }
}
