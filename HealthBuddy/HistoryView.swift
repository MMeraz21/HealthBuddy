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
    @State var currIndex: Int?

    var body: some View {
        VStack{
            HStack{
                Image(systemName: "arrow.left")
                    .padding()
                    .onTapGesture {
                        print("left")
//                        currIndex! -= 1
//                        if let leftObj = userManager.userProfile?.history[currIndex ?? -1]{
//                            currObj = leftObj
//                        }
                        if let currIndex = currIndex, currIndex >= 0{
                            self.currIndex! -= 1
                            if let leftObj = userManager.userProfile?.history[currIndex]{
                                currObj = leftObj
                            }
                        }else{
                            print("cant go further left")
                        }
                        
                    }
                
                Spacer()
                
                Text("History")
                
                Spacer()
                
                Image(systemName: "arrow.right")
                    .padding()
                    .onTapGesture {
                        print("right")
//                        currIndex! += 1
//                        if let rightObj = userManager.userProfile?.history[currIndex ?? -1]{
//                            currObj = rightObj
//                        }
                        if let currObjDate = currObj?.date, Calendar.current.isDateInToday(currObjDate){
                            print("this is todays log, cant go into the future")
                            print(currIndex)
                        }else{
                            currIndex! += 1
                            if let rightObj  = userManager.userProfile?.history[currIndex ?? -1]{
                                currObj = rightObj
                            }
                        }
                    }
            }
            .padding()
            
            Text(currObj?.dateToString() ?? "")
                .padding()
            List {
                ForEach(currObj?.foodItems ?? []) { foodItem in
                    VStack(alignment: .leading) {
                        Text(foodItem.productName)
                            .font(.headline)
                        Text(foodItem.brandName)
                            .font(.subheadline)
                    }
                    .padding(.vertical, 8)
                }
            }
            .listStyle(InsetGroupedListStyle())
        }
        .onAppear{
            currObj = userManager.dailyLog
            currIndex = (userManager.userProfile?.history.count ?? 0) - 1
        }
        
        
    }
        
}
    

//#Preview {
//    HistoryView()
//}

struct HistoryViewPreviews: PreviewProvider {
    struct HistoryViewPreviewWrapper: View {

        var body: some View {
            let userManager = UserProfileManager(username: "Johnny")
            userManager.setUpUserProfile()

            return HistoryView()
                .environmentObject(userManager)
        }
    }

    static var previews: some View {
        HistoryViewPreviewWrapper()
    }
}
