//
//  OnboardingBirthDateInputView.swift
//  Wemmy-iOS
//
//  Created by 이예빈 on 5/21/24.
//

import SwiftUI

struct OnboardingBirthDateInputView: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        VStack {
            Text("생년월일")
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
    OnboardingBirthDateInputView()
}
