//
//  BenefitDetailView.swift
//  Wemmy-iOS
//
//  Created by 이예빈 on 6/5/24.
//

import SwiftUI

enum SelectedTab: CaseIterable {
    case targetAudience, content, applicationMethod, additionalInformation
    
    var title: String {
        switch self {
        case .targetAudience: return "지원 대상"
        case .content: return "내용"
        case .applicationMethod: return "신청 방법"
        case .additionalInformation: return "기타"
        }
    }
}

struct BenefitDetailView: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @State private var selectedTab: SelectedTab = .targetAudience
    
    let benefit: Benefit
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            BenefitImageView(benefit: benefit)
            
            BenefitTitleView(benefit: benefit)
            
            BenefitTabView(selectedTab: $selectedTab, benefit: benefit)
            
            BenefitContentView(benefit: benefit, selectedTab: selectedTab)
            
            Spacer()
            
            BenefitApplyButton()
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(
            leading: BackButton { self.presentationMode.wrappedValue.dismiss() },
            trailing: ShareButton { /* share action */ }
        )
    }
}

//MARK: -혜택 기관 이미지
struct BenefitImageView: View {
    
    let benefit: Benefit
    
    var body: some View {
        Image(benefit.representativeImage)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(maxWidth: .infinity, maxHeight: 200)
    }
}

//MARK: -혜택 제목 및 기관
struct BenefitTitleView: View {
    
    let benefit: Benefit
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(benefit.title)
                .font(.SemiBold20)
                .foregroundColor(Color.black)
                .padding(.bottom, 4)
            Text(benefit.organization)
                .font(.Regular16)
                .foregroundColor(Color.Gray500)
        }
        .frame(maxWidth: .infinity, maxHeight: 92, alignment: .leading)
        .padding(.horizontal, 20)
    }
}

//MARK: -혜택 정보 탭
struct BenefitTabView: View {
    
    @Binding var selectedTab: SelectedTab
    
    let benefit: Benefit
    
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Divider()
                .frame(height: 4)
                .background(Color.Gray200)
                .padding(.bottom, 10)
            
            HStack(spacing: 0) {
                ForEach(SelectedTab.allCases, id: \.self) { t in
                    TabButton(title: t.title, isSelected: t == selectedTab) {
                        selectedTab = t
                    }
                }
            }
            .frame(maxWidth: .infinity, alignment: .center)
            .padding(.horizontal, 20)
        }
    }
}

struct TabButton: View {
    
    let title: String
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            VStack {
                Text(title)
                    .font(.Bold14)
                    .foregroundColor(isSelected ? Color.Pink600 : Color.Gray400)
                Rectangle()
                    .fill(isSelected ? Color.Pink600 : Color.clear)
                    .frame(height: 2)
            }
        }
    }
}

struct BenefitContentView: View {
    
    let benefit: Benefit
    let selectedTab: SelectedTab
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                switch selectedTab {
                case .targetAudience:
                    Text(benefit.targetAudience)
                        .font(.SemiBold18)
                        .foregroundColor(Color.Gray700)
                case .content:
                    Text(benefit.content)
                        .font(.SemiBold18)
                        .foregroundColor(Color.Gray700)
                case .applicationMethod:
                    Text(benefit.applicationMethod)
                        .font(.SemiBold18)
                        .foregroundColor(Color.Gray700)
                case .additionalInformation:
                    Text(benefit.additionalInformation)
                        .font(.SemiBold18)
                        .foregroundColor(Color.Gray700)
                }
            }
            .padding(.vertical, 20)
            .padding(.horizontal, 20)
        }
    }
}

//MARK: -상단 네비게이션바 커스텀
struct BackButton: View {
    
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Image(systemName: "chevron.left")
                .foregroundColor(Color.black)
        }
    }
}

struct ShareButton: View {
    
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Image(systemName: "square.and.arrow.up")
                .foregroundColor(Color.black)
        }
    }
}

//MARK: -신청하기 버튼
struct BenefitApplyButton: View {
    
    var body: some View {
        CustomButton(title: "신청하기", action: {
            // 신청하기 버튼 클릭 시 동작
        }, isEnabled: true)
        .padding(20)
    }
}

#Preview {
    BenefitDetailView(benefit: benefits[0])
}
