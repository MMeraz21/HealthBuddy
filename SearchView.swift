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
    
    var body: some View {
        NavigationView{
            VStack{
                HStack{
                    Image(systemName: "magnifyingglass")
                    TextField("Search...", text: $searchText)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(8)
                        .background(Color(.systemGray6))
                        .cornerRadius(8)
                    Image(systemName: "barcode.viewfinder")
                        .onTapGesture {
                            toScannerView = true
                        }
                }
            }
        }
    }
}

#Preview {
    SearchView()
}
