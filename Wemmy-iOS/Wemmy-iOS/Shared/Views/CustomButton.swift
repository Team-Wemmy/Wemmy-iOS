//
//  CustomButton.swift
//  Wemmy-iOS
//
//  Created by 이예빈 on 5/17/24.
//

import SwiftUI

struct CustomButton: View {
    
    let title: String
    let action: () -> Void
    var isEnabled: Bool
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.Medium20)
                .foregroundColor(.white)
                .environment(\.sizeCategory, .large)
                .frame(maxWidth: .infinity, minHeight: 55, maxHeight: 55)
                .background(isEnabled ? Color.Pink600 : Color.Gray300)
                .cornerRadius(10)
        }
        .disabled(!isEnabled)
    }
}
