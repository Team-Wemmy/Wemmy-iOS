//
//  OnboardingDistrictSelectionView.swift
//  Wemmy-iOS
//
//  Created by 이예빈 on 5/21/24.
//

import SwiftUI

struct OnboardingDistrictSelectionView: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @EnvironmentObject var userSettings: UserSettings

    @State private var isNavigationToHomeView: Bool = false
    
    var body: some View {
        VStack(alignment: .leading) {
            DistrictSelectionProgressBarSection()
            
            VStack(alignment: .leading) {
                DistrictSelectionTitleSection()
                DistrictSelectionFormSection(selectedDistrict: $userSettings.selectedDistrict)
                Spacer()
                CustomButton(title: "완료", action: {
                    self.isNavigationToHomeView.toggle()
                }, isEnabled: userSettings.selectedDistrict != "자치구")
                .padding(.vertical, 20)
                .fullScreenCover(isPresented: $isNavigationToHomeView){
                    TabBarView(viewModel: TabBarViewModel())
                }
            }
            .padding(.horizontal, 20)
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

// MARK: - 프로그레스바
struct DistrictSelectionProgressBarSection: View {
    var body: some View {
        ProgressView(value: 1.0)
            .progressViewStyle(LinearProgressViewStyle(tint: Color.Pink500))
    }
}

// MARK: - 타이틀 섹션
struct DistrictSelectionTitleSection: View {
    var body: some View {
        VStack(alignment: .leading) {
            Text("혜택 정보를 받아볼\n자치구를 선택해주세요.")
                .font(.SemiBold24)
                .foregroundColor(Color.Gray700)
                .multilineTextAlignment(.leading)
                .padding(.top, 80)
        }
    }
}

// MARK: - 폼 섹션
struct DistrictSelectionFormSection: View {
    @Binding var selectedDistrict: String
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("지역 정보")
                .font(.SemiBold12)
                .foregroundColor(Color.Gray500)
            HStack(spacing: 16) {
                Text("서울특별시")
                    .font(.Medium18)
                    .foregroundColor(Color.Gray500)
                    .padding(.vertical, 16)
                    .padding(.horizontal, 40)
                    .background(Color.Gray100)
                    .cornerRadius(10)
                
                DistrictMenu(selectedDistrict: $selectedDistrict)
            }
        }
        .padding(.top, 80)
    }
}

// MARK: - 구 선택 메뉴
struct DistrictMenu: View {
    @Binding var selectedDistrict: String
    
    var body: some View {
        Menu {
            ForEach(districts) { district in
                Button(district.name) {
                    selectedDistrict = district.name
                }
            }
        } label: {
            HStack(spacing: 20) {
                Text(selectedDistrict)
                    .font(.Medium18)
                    .foregroundColor(Color.Gray700)
                Image(systemName: "chevron.down")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 17, height: 17)
                    .foregroundColor(Color.Gray700)
            }
            .padding(.vertical, 16)
            .padding(.horizontal, 32)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.Gray500, lineWidth: 1)
            )
        }
    }
}

#Preview {
    OnboardingDistrictSelectionView()
        .environmentObject(UserSettings())
}
