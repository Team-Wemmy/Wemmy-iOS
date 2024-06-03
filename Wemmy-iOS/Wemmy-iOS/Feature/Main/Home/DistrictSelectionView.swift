//
//  DistrictSelectionView.swift
//  Wemmy-iOS
//
//  Created by 이예빈 on 5/31/24.
//

import SwiftUI

struct DistrictSelectionView: View {
    
    @Binding var isPresented: Bool
    
    @EnvironmentObject var userSettings: UserSettings
    
    @State private var tempSelectedDistrict: String?
    
    let columns: [GridItem] = Array(repeating: .init(.flexible()), count: 3)
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("추천받을 자치구를 선택해 주세요.")
                .font(.SemiBold20)
                .foregroundColor(Color.black)
            
            LazyVGrid(columns: columns, spacing: 16) {
                ForEach(districts, id: \.id) { district in
                    Button(action: {
                        self.tempSelectedDistrict = district.name
                    }) {
                        Text(district.name)
                            .padding(.vertical, 10)
                            .frame(width: 101)
                            .font(.Regular16)
                            .foregroundColor(self.tempSelectedDistrict == district.name ? Color.white : Color.Gray700)
                            .background(self.tempSelectedDistrict == district.name ? Color.Pink600 : Color.clear)
                            .cornerRadius(5)
                            .overlay(
                                RoundedRectangle(cornerRadius: 5)
                                    .stroke(self.tempSelectedDistrict == district.name ? Color.clear : Color.Gray200, lineWidth: 1)
                            )
                    }
                }
            }
            
            CustomButton(title: "선택 완료", action: {
                if let selectedDistrict = self.tempSelectedDistrict {
                    self.userSettings.selectedDistrict = selectedDistrict
                }
                self.isPresented = false
            }, isEnabled: self.tempSelectedDistrict != nil && self.tempSelectedDistrict != self.userSettings.selectedDistrict)
            
            Spacer()
        }
        .padding(20)
        .onAppear {
            self.tempSelectedDistrict = self.userSettings.selectedDistrict
        }
        .onChange(of: isPresented) { newValue in
            if !newValue {
                self.tempSelectedDistrict = self.userSettings.selectedDistrict
            }
        }
    }
}

#Preview {
    DistrictSelectionView(isPresented: .constant(true))
        .environmentObject(UserSettings())
}
