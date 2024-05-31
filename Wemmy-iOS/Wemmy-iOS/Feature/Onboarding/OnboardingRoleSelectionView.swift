//
//  OnboardingRoleSelectionView.swift
//  Wemmy-iOS
//
//  Created by 이예빈 on 5/21/24.
//

import SwiftUI

struct OnboardingRoleSelectionView: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @EnvironmentObject var userSettings: UserSettings
    
    @State private var isNavigationToOnboardingDueDateView: Bool = false
    @State private var isNavigationToOnboardingBirthDateView: Bool = false
    
    var body: some View {
        VStack(alignment: .leading) {
            RoleSelectionProgressBarSection()
            
            RoleSelectionSection(selectedRole: $userSettings.selectedRole, isNavigationToOnboardingDueDateView: $isNavigationToOnboardingDueDateView, isNavigationToOnboardingBirthDateView: $isNavigationToOnboardingBirthDateView)
            
            Spacer()
        }
        .navigationDestination(isPresented: $isNavigationToOnboardingDueDateView) {
            OnboardingDueDateInputView()
                .environmentObject(userSettings)
        }
        .navigationDestination(isPresented: $isNavigationToOnboardingBirthDateView) {
            OnboardingBirthDateInputView()
                .environmentObject(userSettings)
        }
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: {
                    self.presentationMode.wrappedValue.dismiss()
                }) {
                    Image(systemName: "chevron.left ")
                        .foregroundColor(Color.black)
                }
            }
        }
    }
}

// MARK: - 프로그레스바
struct RoleSelectionProgressBarSection: View {
    var body: some View {
        ProgressView(value: 0.2)
            .progressViewStyle(LinearProgressViewStyle(tint: Color.Pink500))
    }
}

// MARK: - 임신 또는 육아 여정 선택 관련 뷰
struct RoleSelectionSection: View {
    
    @Binding var selectedRole: String
    @Binding var isNavigationToOnboardingDueDateView: Bool
    @Binding var isNavigationToOnboardingBirthDateView: Bool
    
    var body: some View {
        VStack(alignment: .leading) {
            VStack(alignment: .leading){
                Text("임신부터 육아 여정의 모든 혜택\n위미와 함께 해요!")
                    .font(.SemiBold24)
                    .foregroundColor(Color.Gray700)
                    .multilineTextAlignment(.leading)
            }
            .padding(.top, 80)
            
            // 여정 선택
            HStack(spacing: 20) {
                SingleSelectionBoxSection(
                    emoji: "🤰🏻",
                    role: "임신",
                    text: "여정을 떠나요",
                    isSelected: selectedRole == "Pregnant",
                    roleMainColor: Color.Pink500,
                    selectedBackgroundColor: Color.Pink200,
                    action: {
                        selectedRole = "Pregnant"
                        isNavigationToOnboardingDueDateView = true
                        print("Navigating to OnboardingDueDateInputView with role: \(selectedRole)")
                    }
                )
                
                SingleSelectionBoxSection(
                    emoji: "👩🏻‍🍼",
                    role: "육아",
                    text: "여정을 떠나요",
                    isSelected: selectedRole == "Caregiver",
                    roleMainColor: Color.Yellow500,
                    selectedBackgroundColor: Color.Yellow100,
                    action: {
                        selectedRole = "Caregiver"
                        isNavigationToOnboardingBirthDateView = true
                        print("Navigating to OnboardingBirthDateInputView with role: \(selectedRole)")
                    }
                )
            }
            .padding(.top, 80)
            
        }
        .padding(.horizontal, 20)
    }
}

// MARK: - 선택 박스 뷰
struct SingleSelectionBoxSection: View {
    let emoji: String
    let role: String
    let text: String
    let isSelected: Bool
    let roleMainColor: Color
    let selectedBackgroundColor: Color
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            VStack(spacing: 20) {
                Text(emoji)
                    .font(.system(size: 80))
                
                HStack(spacing: 4) {
                    Text(role)
                        .font(.Medium18)
                        .foregroundColor(roleMainColor)
                    
                    Text(text)
                        .font(.Medium18)
                        .foregroundColor(Color.Gray600)
                }
            }
            .frame(width: 165, height: 200)
            .background(isSelected ? selectedBackgroundColor : Color.white)
            .cornerRadius(20)
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(roleMainColor, lineWidth: 2)
            )
        }
    }
}

#Preview {
    OnboardingRoleSelectionView()
        .environmentObject(UserSettings())
}
