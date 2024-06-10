//
//  HistoryView.swift
//  HealthBuddy
//
//  Created by Manuel Meraz on 6/9/24.
//

import SwiftUI

struct HistoryView: View {
    @EnvironmentObject var userManager: UserProfileManager
    @State var currObj: DailyNutritionLog?

    var body: some View {
        VStack{
            HStack{
                Image(systemName: "arrow.left")
                    .padding()
                    .onTapGesture {
                        print("left")
                    }
                
                Spacer()
                
                Text("History")
                
                Spacer()
                
                Image(systemName: "arrow.right")
                    .padding()
                    .onTapGesture {
                        print("right")
                    }
            }
            .padding()
        }
        
        Text(currObj?.dateToString() ?? "")
            .padding()
        
        
    }
}

#Preview {
    HistoryView()
}
