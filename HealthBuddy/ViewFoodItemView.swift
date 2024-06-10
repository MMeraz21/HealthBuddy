//
//  ViewFoodItemView.swift
//  HealthBuddy
//
//  Created by Manuel Meraz on 6/10/24.
//
//funny name
import SwiftUI

struct ViewFoodItemView: View {
    @State var currObj: FoodItem?
    
    var body: some View {
        VStack{
            VStack(alignment: .leading) {
                HStack{
                    Text(currObj?.productName ?? "product name")
                        .padding(.leading, 8)
                    
                    Spacer()
                    
                }
                
                //Spacer()
                
                HStack{
                    Text(currObj?.brandName ?? "brand name")
                        .padding(.leading, 8)
                    Spacer()
                }
            }
            .padding([.top, .leading, .trailing])
        
            
            Spacer().frame(height: 40)
            
            
            HStack{
                Text("Serving Size:")
                    .padding()
                
                Spacer()
                
                Text("\(Int(currObj?.servingGrams ?? 0))")
                    .padding(.leading, 4)

                //.padding()
                
                Text("g")
                    .padding()
                
            }
            
            HStack{
                Text("Calories:")
                    .padding()
                
                Spacer()
                
                Text("\(Int(currObj?.calories ?? 0))")
                    .padding(.leading, 4)
                //.padding()
                
                Text("kcal")
                    .padding()
                
            }
            HStack{
                Text("Fat:")
                    .padding()
                
                Spacer()
                
                Text("\(Int(currObj?.fat ?? 0))")
                    .padding(.leading, 4)

                //.padding()
                
                Text("g")
                    .padding()
                
            }
            HStack{
                Text("Protein:")
                    .padding()
                
                Spacer()
                
                Text("\(Int(currObj?.protein ?? 0))")
                    .padding(.leading, 4)

                //.padding()
                
                Text("g")
                    .padding()
                
            }
            HStack{
                Text("Carbohydrates:")
                    .padding()
                
                Spacer()
                
                Text("\(Int(currObj?.carbs ?? 0))")
                    .padding(.leading, 4)

                //.padding()
                
                Text("g")
                    .padding()
                
            }
            HStack{
                Text("Sugar:")
                    .padding()
                
                Spacer()
                
                Text("\(Int(currObj?.sugar ?? 0))")
                    .padding(.leading, 4)

                //.padding()
                
                Text("g")
                    .padding()
                
            }
            
            Spacer()
        }
        .navigationBarTitle("Food Item Details", displayMode: .inline)
    }
}

#Preview {
    ViewFoodItemView()
}
