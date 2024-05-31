//
//  ContentView.swift
//  HealthBuddy
//
//  Created by Manuel Meraz on 5/30/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            VStack {
                Text("Scan a document")
                    .font(.title)
                    .padding()
                DocumentScannerView()
                    .navigationBarTitle("")
                    .navigationBarHidden(true)
            }
        }
    }
}

#Preview {
    ContentView()
}

