//
//  OnboardingBirthDateInputView.swift
//  Wemmy-iOS
//
//  Created by 이예빈 on 5/21/24.
//

import SwiftUI

struct ChildInfo {
    var birthDate: String = ""
    var name: String = ""
}

struct OnboardingBirthDateInputView: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @State private var birthDate: String = ""
    @State private var children: [ChildInfo] = [ChildInfo()]
    @State private var isNavigationToOnboardingDistrictSelectionView: Bool = false
    
    @FocusState private var focusedChildBirthDateIndex: Int?
    @FocusState private var focusedChildNameIndex: Int?
    
    var body: some View {
        VStack(alignment: .leading) {
            BirthDateInputProgressBarSection()
            
            VStack(alignment: .leading){
                Text("아이 생년월일과 이름을\n입력해주세요.")
                    .font(.SemiBold24)
                    .foregroundColor(Color.Gray700)
                    .multilineTextAlignment(.leading)
                    .padding(.vertical, 80)
                
                ScrollView {
                    VStack(alignment: .leading, spacing: 20) {
                        ForEach(0..<children.count, id: \.self) { index in
                            VStack(alignment: .leading, spacing: 8) {
                                //MARK: 생년월일 입력 필드
                                TextField("생년월일", text: $children[index].birthDate)
                                    .padding(20)
                                    .font(.Medium16)
                                    .foregroundColor(Color.Pink600)
                                    .background(Color.white)
                                    .cornerRadius(10)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 10)
                                            .stroke(focusedChildBirthDateIndex == index ? Color.Pink600 : Color.Gray500, lineWidth: 1)
                                    )
                                    .focused($focusedChildBirthDateIndex, equals: index)
                                    .onChange(of: children[index].birthDate, perform: { newValue in
                                        adjustChildBirthDateInput(to: newValue, at: index)
                                    })
                                
                                //MARK: 이름 입력 필드
                                HStack {
                                    TextField("이름", text: $children[index].name)
                                        .padding(20)
                                        .font(.Medium16)
                                        .foregroundColor(Color.Pink600)
                                        .background(Color.white)
                                        .cornerRadius(10)
                                        .focused($focusedChildNameIndex, equals: index)
                                    
                                    if children.count > 1 {
                                        Button(action: {
                                            removeChild(at: index)
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
                                        .stroke(focusedChildNameIndex == index ? Color.Pink600 : Color.Gray500, lineWidth: 1)
                                )
                            }
                        }
                        
                        //MARK: 자녀 추가 버튼
                        Button(action: addChild) {
                            HStack {
                                Image(systemName: "plus.circle.fill")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 20, height: 20)
                                    .foregroundColor(Color.Lightblue400)
                                
                                Text("자녀 추가")
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
                }, isEnabled: isNextButtonEnabled())
                .padding(.vertical, 20)
                
            }
            .padding(.horizontal, 20)
            
            Spacer()
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
struct BirthDateInputProgressBarSection: View {
    var body: some View {
        ProgressView(value: 0.6)
            .progressViewStyle(LinearProgressViewStyle(tint: Color.Pink500))
    }
}

// MARK: - 확장함수들
private extension OnboardingBirthDateInputView {
    func addChild() {
        children.append(ChildInfo())
    }
    
    func removeChild(at index: Int) {
        children.remove(at: index)
    }
    
    func adjustChildBirthDateInput(to newValue: String, at index: Int) {
        let filtered = newValue.filter { "0123456789".contains($0) }
        if filtered != newValue {
            children[index].birthDate = filtered
        }
        
        if filtered.count > 8 {
            children[index].birthDate = String(filtered.prefix(8))
        }
        
        if filtered.count > 4 {
            children[index].birthDate.insert(".", at: filtered.index(filtered.startIndex, offsetBy: 4))
        }
        if filtered.count > 6 {
            children[index].birthDate.insert(".", at: filtered.index(filtered.startIndex, offsetBy: 7))
        }
    }
    
    func isNextButtonEnabled() -> Bool {
            for child in children {
                if child.birthDate.isEmpty || child.name.isEmpty {
                    return false
                }
            }
            return true
        }
}

#Preview {
    OnboardingBirthDateInputView()
}
