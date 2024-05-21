//
//  OnboardingDistrictSelectionView.swift
//  Wemmy-iOS
//
//  Created by 이예빈 on 5/21/24.
//

import SwiftUI

struct OnboardingDistrictSelectionView: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        VStack {
            Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: Button(action: {
            self.presentationMode.wrappedValue.dismiss()
        }) {
            HStack {
                Image(systemName: "chevron.left")
                    .foregroundColor(Color.black)
            }
        })
    }
}

#Preview {
    OnboardingDistrictSelectionView()
}
