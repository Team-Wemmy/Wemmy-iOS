//
//  TabBarView.swift
//  Wemmy-iOS
//
//  Created by 이예빈 on 5/22/24.
//

import SwiftUI

// MARK: - 탭 목록
enum Tab: String {
    
    case Home, Facility, Community, Mypage
}

// MARK: - 탭바 ViewModel
class TabBarViewModel: ObservableObject {
    
    @Published var selectedTab: Tab = .Home
}

// MARK: - 메인화면 탭 뷰
struct TabBarView: View {
    
    @ObservedObject var viewModel: TabBarViewModel
    
    var body: some View {
        NavigationStack {
            TabView(selection: $viewModel.selectedTab) {
                
                // MARK: 혜택 정보 화면(홈 화면)
                HomeView()
                    .tabItem {
                        Image(systemName: "heart.fill")
                            .resizable()
                            .frame(width: 24, height: 24)
                            .foregroundColor(Color.Gray400)
                        
                        Text("홈")
                            .font(.Medium12)
                            .foregroundColor(Color.Gray400)
                    }
                    .tag(Tab.Home)
                
                // MARK: 복지시설 화면
                FacilityView()
                    .tabItem {
                        Image(systemName: "map")
                            .resizable()
                            .frame(width: 24, height: 24)
                            .foregroundColor(Color.Gray400)
                            .environment(\.symbolVariants, .none)
                        
                        Text("복지시설")
                            .font(.Medium12)
                            .foregroundColor(Color.Gray400)
                    }
                    .tag(Tab.Facility)
                
                // MARK: 커뮤니티 화면
                CommunityView()
                    .tabItem {
                        Image(systemName: "heart.text.square")
                            .resizable()
                            .frame(width: 24, height: 24)
                            .foregroundColor(Color.Gray400)
                            .environment(\.symbolVariants, .none)
                        
                        Text("커뮤니티")
                            .font(.Medium12)
                            .foregroundColor(Color.Gray400)
                    }
                    .tag(Tab.Community)
                
                // MARK: 마이페이지 화면
                MypageView()
                    .tabItem {
                        Image(systemName: "person")
                            .resizable()
                            .frame(width: 24, height: 24)
                            .foregroundColor(Color.Gray400)
                            .environment(\.symbolVariants, .none)
                        
                        Text("MY")
                            .font(.Medium12)
                            .foregroundColor(Color.Gray400)
                    }
                    .tag(Tab.Mypage)
            }
            .accentColor(Color.Pink600)
            
            Spacer()
        }
        .ignoresSafeArea()
    }
}

#Preview {
    TabBarView(viewModel: TabBarViewModel())
}
