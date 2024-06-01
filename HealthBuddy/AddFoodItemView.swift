//
//  AddFoodItemView.swift
//  HealthBuddy
//
//  Created by Manuel Meraz on 5/31/24.
//

import SwiftUI

struct AddFoodItemView: View {
    var upc: String
    
    var body: some View {
        VStack {
            Text("UPC: \(upc)")
                .foregroundColor(.black) // Explicitly setting text color
                .padding()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity) // Ensure the view takes up the entire space
        .background(Color.white) // Explicitly setting background color
        .edgesIgnoringSafeArea(.all) // Ensure the background color covers the entire view
        .navigationBarHidden(true)
    }}

#Preview {
    AddFoodItemView(upc: "123456789012")
}
