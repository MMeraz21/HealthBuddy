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
    
    var feed: String {
        return "https://us.openfoodfacts.org/cgi/search.pl?search_terms=\(searchText)search_simple=1&action=process&json=1"
    }
    
    func parseFoodList(){
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
                
                //add search items here

            }
        //}
    }
}

#Preview {
    SearchView()
}
