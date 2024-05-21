//
//  OnboardingDistrictSelectionView.swift
//  Wemmy-iOS
//
//  Created by 이예빈 on 5/21/24.
//

import SwiftUI

struct OnboardingDistrictSelectionView: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @State private var selectedDistrict: String = "자치구"
    
    var body: some View {
        VStack(alignment: .leading) {
            DistrictSelectionProgressBarSection()
            
            VStack(alignment: .leading) {
                VStack {
                    Text("혜택 정보를 받아볼\n자치구를 선택해주세요.")
                        .font(.SemiBold24)
                        .foregroundColor(Color.Gray700)
                        .multilineTextAlignment(.leading)
                }
                .padding(.top, 80)
                
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
                .padding(.top, 80)
                
                Spacer()
                
                CustomButton(title: "완료", action: {
                    
                }, isEnabled: selectedDistrict != "자치구")
                .padding(.vertical, 20)
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

#Preview {
    OnboardingDistrictSelectionView()
}
