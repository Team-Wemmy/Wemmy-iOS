//
//  HomeView.swift
//  Wemmy-iOS
//
//  Created by 이예빈 on 5/22/24.
//

import SwiftUI

import BottomSheet

struct HomeView: View {
    
    @ObservedObject var userSettings = UserSettings()
    
    @State private var isDistrictSelectionSheetPresented = false
    @State private var isNavigationToAllBenefitsView = false
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: 20) {
                
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
                
                // MARK: 혜택 관련 내부 메뉴 버튼
                HStack {
                    HomeInternalMenuButton(buttonName: "전체 혜택", imageName: "fullBenefit"){
                        self.isNavigationToAllBenefitsView.toggle()
                    }
                    HomeInternalMenuButton(buttonName: "추천 혜택", imageName: "recommandBenefit"){}
                    HomeInternalMenuButton(buttonName: "혜택 스크랩", imageName: "bookmark"){}
                    HomeInternalMenuButton(buttonName: "신청 현황", imageName: "applicationStatus"){}
                }
                .frame(height: 98)
                .background(Color.Pink100)
                .cornerRadius(10)
                
                // MARK: 자치구 선택 및 전체보기 버튼
                HStack(spacing: 12) {
                    Button(action: {
                        isDistrictSelectionSheetPresented = true
                    }) {
                        HStack(spacing: 8) {
                            Text(userSettings.selectedDistrict)
                                .font(.SemiBold16)
                                .foregroundColor(Color.black)
                            
                            Image(systemName: "chevron.down")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 16, height: 16)
                                .foregroundColor(Color.black)
                        }
                    }
                    
                    Text("이런 혜택 신청해보면 어때요?")
                        .font(.SemiBold12)
                        .foregroundColor(Color.Gray600)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Button(action: {
                        
                    }) {
                        Text("전체보기")
                            .font(.SemiBold12)
                            .foregroundColor(Color.black)
                    }
                }
                
                HomeBenefitGridView(benefits: Benefits)
                    .environmentObject(userSettings)
                
                Spacer()
            }
            .padding(20)
            .bottomSheet(
                isPresented: $isDistrictSelectionSheetPresented,
                height: 690,
                topBarCornerRadius: 20,
                showTopIndicator: true
            ) {
                DistrictSelectionView(isPresented: $isDistrictSelectionSheetPresented)
                    .environmentObject(userSettings)
            }
            .navigationDestination(isPresented: $isNavigationToAllBenefitsView){
                AllBenefitsView()
            }
        }
    }
}

struct HomeInternalMenuButton: View {
    
    var buttonName: String
    var imageName: String
    var action: () -> Void
    
    var body: some View {
        Button(action: action){
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
}

//MARK: 혜택 아이템 뷰
struct BenefitItem: View {
    
    @State private var isBookmarked: Bool = false
    
    var benefit: Benefit
    
    var body: some View {
        NavigationLink(destination: BenefitDetailView(benefit: benefit)){
            VStack(alignment: .leading) {
                ZStack(alignment: .topTrailing) {
                    Image(benefit.representativeImage)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 170, height: 120)
                        .cornerRadius(10)
                        .shadow(color: .black.opacity(0.2), radius: 1, x: 0, y: 0)
                    
                    Button(action: {
                        // 북마크 버튼 액션
                        isBookmarked.toggle()
                    }) {
                        Image(systemName: isBookmarked ? "bookmark.fill" : "bookmark")
                            .padding(2)
                            .background(Color.white.opacity(0.7))
                            .foregroundColor(isBookmarked ? Color.Pink600 : Color.Gray500)
                            .clipShape(Circle())
                            .padding(.top, 8)
                            .padding(.trailing, 6)
                    }
                }
                
                Text(benefit.title)
                    .font(.Bold14)
                    .foregroundColor(Color.black)
                    .padding(.top, 8)
                    .padding(.bottom,2)
                
                Text(benefit.organization)
                    .font(.Regular12)
                    .foregroundColor(Color.black)
            }
            .frame(width: 170)
        }
    }
}

//MARK: 혜택 그리드 뷰
struct HomeBenefitGridView: View {
    
    @EnvironmentObject var userSettings: UserSettings
    
    var benefits: [Benefit]
    
    var filteredBenefits: [Benefit] {
            benefits.filter { benefit in
                // 선택된 역할에 따라 필터링
                let roleMatch = benefit.role.rawValue == userSettings.selectedRole
                
                // 선택된 지역구에 따라 필터링
                let districtMatch = userSettings.selectedDistrict == benefit.organization || benefit.organization == "국가"
                
                return roleMatch && districtMatch
            }
        }
    
    var body: some View {
        LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 16) {
            ForEach(filteredBenefits.prefix(4), id: \.id) { benefit in
                BenefitItem(benefit: benefit)
            }
        }
    }
}

// MARK: - 확장 함수들
private extension HomeView {
    func getGreetingName() -> String {
        if userSettings.selectedRole == "Pregnant" {
            return userSettings.fetusNames.first ?? ""
        } else if userSettings.selectedRole == "Caregiver" {
            return userSettings.children.first?.name ?? ""
        } else {
            return "위미"
        }
    }
}

#Preview {
    HomeView()
}
