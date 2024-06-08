//
//  AllBenefitsView.swift
//  Wemmy-iOS
//
//  Created by 이예빈 on 6/8/24.
//

import SwiftUI

struct AllBenefitsView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading){
                    AllBenefitButtonBar()
                    
                    Divider()
                        .frame(height: 7)
                        .overlay(Color.Gray200)
                    
                    BenefitFilterButton()
                    
                    AllBenefitGridView(benefits: Benefits)
                }
                .navigationBarBackButtonHidden(true)
                .navigationBarTitle("전체 혜택", displayMode: .inline)
                .navigationBarItems(leading: backButton)
            }
        }
    }
    
    var backButton: some View {
            Button(action: {
                self.presentationMode.wrappedValue.dismiss()
            }){
                Image(systemName: "chevron.backward")
                    .foregroundColor(Color.black)
            }
        }

}



struct AllBenefitButtonBar: View {
    
    var body: some View {
        HStack(spacing: 12) {
            Button(action: {
                // 전체 버튼 클릭 처리
            }) {
                Text("전체")
                    .font(.Regular14)
                    .foregroundColor(Color.Gray700)
                    .padding(10)
                    .overlay(
                        RoundedRectangle(cornerRadius: 5)
                            .stroke(Color.Gray500, lineWidth: 0.5)
                    )
                
            }
            
            Button(action: {
                // 혜택 여정 버튼 클릭 처리
            }) {
                HStack(spacing: 4){
                    Text("혜택 여정")
                        .font(.Regular14)
                        .foregroundColor(Color.Gray700)
                        .padding(.trailing, 4)
                    
                    Text("선택")
                        .font(.Medium14)
                        .foregroundColor(Color.Pink600)
                    
                    Image(systemName: "arrowtriangle.down.fill")
                        .resizable()
                        .frame(width: 12, height: 8)
                        .foregroundColor(Color.Gray700)
                }
                .padding(10)
                .overlay(
                    RoundedRectangle(cornerRadius: 5)
                        .stroke(Color.Gray500, lineWidth: 0.5)
                )
            }
            
            Button(action: {
                // 자치구 버튼 클릭 처리
            }) {
                HStack(spacing: 4){
                    Text("자치구")
                        .font(.Regular14)
                        .foregroundColor(Color.Gray700)
                        .padding(.trailing, 4)
                    
                    Text("선택")
                        .font(.Medium14)
                        .foregroundColor(Color.Pink600)
                    
                    Image(systemName: "arrowtriangle.down.fill")
                        .resizable()
                        .frame(width: 12, height: 8)
                        .foregroundColor(Color.Gray700)
                }
                .padding(10)
                .overlay(
                    RoundedRectangle(cornerRadius: 5)
                        .stroke(Color.Gray500, lineWidth: 0.5)
                )
            }
            
            Button(action: {
                // 돋보기 버튼 클릭 처리
            }) {
                Image(systemName: "magnifyingglass")
                    .resizable()
                    .frame(width: 17, height: 17)
                    .foregroundColor(Color.Gray700)
                    .padding(10)
                    .overlay(
                        RoundedRectangle(cornerRadius: 5)
                            .stroke(Color.Gray500, lineWidth: 0.5)
                    )
            }
        }
        .padding(20)
    }
}

struct BenefitFilterButton: View {
    
    var body: some View {
        HStack {
            Spacer()
            
            Button(action: {
                // 필터링
            }) {
                HStack(spacing: 4){
                    Text("추천순")
                        .font(.Regular14)
                        .foregroundColor(Color.Gray700)
                        .padding(.trailing, 4)
                    
                    Image(systemName: "arrowtriangle.down.fill")
                        .resizable()
                        .frame(width: 12, height: 8)
                        .foregroundColor(Color.Gray700)
                }
                .padding(10)
                .overlay(
                    RoundedRectangle(cornerRadius: 5)
                        .stroke(Color.Gray500, lineWidth: 0.5)
                )
            }
        }
        .padding(.horizontal, 20)
        .padding(.top, 16)
    }
}

struct AllBenefitGridView: View {
    
    var benefits: [Benefit]
    
    var body: some View {
        LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 16) {
            ForEach(benefits, id: \.id) { benefit in
                BenefitItem(benefit: benefit)
            }
        }
        .padding(.vertical, 20)
        .padding(.horizontal, 20)
    }
}

#Preview {
    AllBenefitsView()
}
