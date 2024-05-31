//
//  HomeView.swift
//  Wemmy-iOS
//
//  Created by 이예빈 on 5/22/24.
//

import SwiftUI

struct HomeView: View {
    @ObservedObject var userSettings = UserSettings()
    
    var body: some View {
        VStack(alignment: .leading) {
            
            // MARK: 홈 화면 타이틀바
            HStack {
                Image("Logo")
                    .resizable()
                    .frame(width: 24, height: 24)
                
                Spacer()
            }
            .frame(height: 44)
            
            VStack(alignment: .leading, spacing: 4) {
                Text("\(getGreetingName())맘 님:)")
                    .font(.Bold24)
                
                Text("위미에서 맞춤형 혜택을 누려보세요!")
                    .font(.Bold20)
            }
            .padding(.vertical, 20)
            
            // MARK: 혜택 관련 내부 메뉴 버튼
            HStack {
                HomeInternalMenuButton(buttonName: "전체 혜택", imageName: "fullBenefit")
                HomeInternalMenuButton(buttonName: "추천 혜택", imageName: "recommandBenefit")
                HomeInternalMenuButton(buttonName: "혜택 스크랩", imageName: "bookmark")
                HomeInternalMenuButton(buttonName: "신청 현황", imageName: "applicationStatus")
            }
            .frame(height: 98)
            .background(Color.Pink100)
            .cornerRadius(10)
            
            Spacer()
        }
        .padding(20)
    }
}

struct HomeInternalMenuButton: View {
    var buttonName: String
    var imageName: String
    
    var body: some View {
        VStack(spacing: 10) {
            Image(imageName)
                .resizable()
                .frame(width: 44, height: 44)
            Text(buttonName)
                .font(.Medium12)
                .foregroundColor(Color.black)
        }
        .frame(maxWidth: .infinity)
    }
}

// MARK: - 확장 함수들
private extension HomeView {
    func getGreetingName() -> String {
        if userSettings.selectedRole == "임산부" {
            return userSettings.fetusNames.first ?? ""
        } else if userSettings.selectedRole == "양육자" {
            return userSettings.children.first?.name ?? ""
        } else {
            return "위미"
        }
    }
}

#Preview {
    HomeView()
}
