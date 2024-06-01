//
//  ContentView.swift
//  HealthBuddy
//
//  Created by Manuel Meraz on 5/30/24.
//

import SwiftUI

struct ContentView: View {
    @State private var upcString: String?
    @State private var isNavigating: Bool = false
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Scan a document")
                    .font(.title)
                    .padding()
                DocumentScannerView(upcString: $upcString, isNavigating: $isNavigating)
                    .navigationBarTitle("")
                    .navigationBarHidden(true)
                
                NavigationLink(destination: AddFoodItemView(upc: upcString ?? ""), isActive: $isNavigating) {
                    EmptyView()
                }
            }
        }
    }
}

#Preview {
    ContentView()
}

