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

            }
        //}
    }
}

#Preview {
    SearchView()
}
