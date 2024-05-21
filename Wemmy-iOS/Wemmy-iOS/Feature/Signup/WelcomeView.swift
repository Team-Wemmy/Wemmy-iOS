//
//  WelcomeView.swift
//  Wemmy-iOS
//
//  Created by 이예빈 on 5/17/24.
//

import SwiftUI

struct WelcomeView: View {
    var body: some View {
        VStack() {
            Text("환영합니다!")
                .font(.Bold36)
                .foregroundColor(Color.Gray700)
                .padding(.top, 80)
            
            Text("간단한 설정을 통해\n위미와 모든 혜택을 누려보세요!")
                .font(.SemiBold20)
                .foregroundColor(Color.Pink500)
                .multilineTextAlignment(.center)
                .padding(.top, 20)
            
            Image("WelcomeLogo")
                .padding(.top, 80)
            
            Spacer()
            
            CustomButton(title: "시작하기", action: {
                
            }, isEnabled: true)
            .padding(.bottom, 20)
        }
        .padding(.horizontal, 20)
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    WelcomeView()
}
