//
//  OnboardingDuedateInputView.swift
//  Wemmy-iOS
//
//  Created by 이예빈 on 5/21/24.
//

import SwiftUI

struct OnboardingDueDateInputView: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @State private var dueDate: String = ""
    @State private var fetusNames: [String] = [""]
    @State private var isNavigationToOnboardingDistrictSelectionView: Bool = false
    
    @FocusState private var isDueDateFocused: Bool
    @FocusState private var isFetusNamesFocused: Int?
    
    private var isNextButtonEnabled: Bool {
        dueDate.count == 10 && !fetusNames.contains(where: { $0.isEmpty} )
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            DueDateInputProgressBarSection()
            
            VStack(alignment: .leading){
                Text("출산 예정일과 태명을\n입력해주세요.")
                    .font(.SemiBold24)
                    .foregroundColor(Color.Gray700)
                    .multilineTextAlignment(.leading)
                    .padding(.vertical, 80)
                
                ScrollView {
                    VStack(alignment: .leading, spacing: 20) {
                        //MARK: 출산 예정일 입력 필드
                        TextField("출산 예정일", text: $dueDate)
                            .padding(20)
                            .font(.Medium16)
                            .foregroundColor(Color.Pink600)
                            .background(Color.white)
                            .cornerRadius(10)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(isDueDateFocused ? Color.Pink600 : Color.Gray500, lineWidth: 1)
                            )
                            .keyboardType(.numberPad)
                            .focused($isDueDateFocused)
                            .onChange(of: dueDate, perform: adjustDueDateInput)
                        
                        //MARK: 태명 입력 필드
                        ForEach(0..<fetusNames.count, id: \.self) { index in
                            HStack {
                                TextField("태명", text: $fetusNames[index])
                                    .padding(20)
                                    .font(.Medium16)
                                    .foregroundColor(Color.Pink600)
                                    .background(Color.white)
                                    .cornerRadius(10)
                                    .focused($isFetusNamesFocused, equals: index)
                                
                                if fetusNames.count > 1 {
                                    Button(action: {
                                        removeFetusNameField(at: index)
                                    }) {
                                        Image(systemName: "minus.circle.fill")
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(width: 17, height: 17)
                                            .foregroundColor(Color.Gray500)
                                    }
                                    .padding(.horizontal, 16)
                                }
                            }
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(isFetusNamesFocused == index ? Color.Pink600 : Color.Gray500, lineWidth: 1)
                            )
                        }
                        
                        // MARK: 다둥이 추가 버튼
                        Button(action: addFetusNameField) {
                            HStack {
                                Image(systemName: "plus.circle.fill")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width:20, height: 20)
                                    .foregroundColor(Color.Lightblue400)
                                
                                Text("다둥이 추가")
                                    .font(.Regular14)
                                    .foregroundColor(Color.Gray600)
                            }
                        }
                        .padding(.top, 12)
                    }
                    .padding(.horizontal, 1)
                    .padding(.vertical, 1)
                }
                
                Spacer()
                
                CustomButton(title: "다음", action: {
                    self.isNavigationToOnboardingDistrictSelectionView = true
                }, isEnabled: isNextButtonEnabled)
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
        .navigationDestination(isPresented: $isNavigationToOnboardingDistrictSelectionView) {
            OnboardingDistrictSelectionView()
        }
    }
}

// MARK: - 프로그레스바
struct DueDateInputProgressBarSection: View {
    var body: some View {
        ProgressView(value: 0.6)
            .progressViewStyle(LinearProgressViewStyle(tint: Color.Pink500))
    }
}

// MARK: - 확장 함수들
private extension OnboardingDueDateInputView {
    func addFetusNameField() {
        fetusNames.append("")
    }
    
    func removeFetusNameField(at index: Int) {
        fetusNames.remove(at: index)
    }
    
    func adjustDueDateInput(to newValue: String) {
        let filtered = newValue.filter { "0123456789".contains($0) }
        if filtered != newValue {
            dueDate = filtered
        }
        
        if filtered.count > 8 {
            dueDate = String(filtered.prefix(8))
        }
        
        if filtered.count > 4 {
            dueDate.insert(".", at: filtered.index(filtered.startIndex, offsetBy: 4))
        }
        if filtered.count > 6 {
            dueDate.insert(".", at: filtered.index(filtered.startIndex, offsetBy: 7))
        }
    }
}

#Preview {
    OnboardingDueDateInputView()
}
