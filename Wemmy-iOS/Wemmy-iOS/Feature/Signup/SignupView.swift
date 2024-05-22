//
//  SignupView.swift
//  Wemmy-iOS
//
//  Created by 이예빈 on 5/17/24.
//

import SwiftUI

struct SignupView: View {
    
    @State private var email: String = ""
    @State private var isEmailVaild: Bool = false
    @State private var isEmailChecked: Bool = false
    
    @State private var password: String = ""
    @State private var confirmPassword: String = ""
    @State private var isPasswordVaild: Bool = false
    @State private var doPasswordsMatch: Bool = false
    
    @State private var isAgreed: Bool = false
    
    @Binding var isNavigationToSignupView: Bool
    
    @State private var isNavigationToWelcomeView: Bool = false
    
    var body: some View {
        VStack() {
            
            SignupTopBarSection(isNavigatingToSingupView: $isNavigationToSignupView)
            
            EmailSection(email: $email, isEmailVaild: $isEmailVaild, isEmailChecked: $isEmailChecked)
            
            PasswordSection(password: $password, confirmPassword: $confirmPassword, isPasswordVaild: $isPasswordVaild, doPasswordsMatch: $doPasswordsMatch)
            
            TermsAgreementSection(isAgreed: $isAgreed)
            
            Spacer()
            
            CustomButton(title: "가입하기", action: {
                self.isNavigationToWelcomeView.toggle()
            }, isEnabled: isEmailChecked && isPasswordVaild && doPasswordsMatch && isAgreed)
            .padding(.bottom, 20)
            .fullScreenCover(isPresented: $isNavigationToWelcomeView){
                WelcomeView()
            }
        }
        .padding(.horizontal, 20)
        .gesture(
            TapGesture()
                .onEnded { _ in
                    self.hideKeyboard()
                }
        )
    }
}

// MARK: - 회원가입 상단바
struct SignupTopBarSection: View {
    
    @Binding var isNavigatingToSingupView: Bool
    
    var body: some View {
        HStack(alignment: .center) {
            Button(action: {
                isNavigatingToSingupView = false
            }) {
                Image(systemName: "xmark")
                    .resizable()
                    .frame(width: 20, height: 20)
                    .foregroundColor(Color.black)
            }
            
            Spacer()
            
            Text("회원가입")
                .font(.Medium18)
                .foregroundColor(Color.black)
            
            Spacer()
            
            Button(action: {}) {
                Image(systemName: "xmark").hidden()
            }
            .disabled(true)
        }
        .frame(height: 40)
    }
}

// MARK: - 이메일 주소
struct EmailSection: View {
    
    @Binding var email: String
    @Binding var isEmailVaild: Bool
    @Binding var isEmailChecked: Bool
    
    @State private var isFocused: Bool = false
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("이메일 주소")
                    .font(.SemiBold16)
                    .foregroundColor(Color.Gray600)
                    .padding(.bottom, 20)
                
                Spacer()
                
                if !isEmailVaild && isFocused {
                    Text("이메일 형식을 정확히 입력해주세요.")
                        .font(.SemiBold12)
                        .foregroundColor(Color.Pink400)
                        .padding(.bottom, 17)
                }
                
                if isEmailChecked {
                    Text("사용 가능한 이메일이에요.")
                        .font(.SemiBold12)
                        .foregroundColor(Color.Lightblue400)
                        .padding(.bottom, 17)
                }
            }
            
            HStack(spacing: 9) {
                TextField("이메일 주소", text: $email, onEditingChanged: { focused in
                    isFocused = focused
                    if !focused {

                    }
                })
                    .onChange(of: email) { _ in
                        self.isEmailVaild = validateEmail(email: email)
                        if isEmailChecked {
                            isEmailChecked = false
                        }
                    }
                    .padding(.horizontal, 16)
                    .padding(.vertical, 14)
                    .font(.Medium14)
                    .foregroundColor(Color.black)
                    .background(Color.Gray100)
                    .cornerRadius(4)
                    
                Button(action: {
                    self.isEmailChecked = true
                }) {
                    Text("중복확인")
                        .font(.SemiBold14)
                        .foregroundColor(!(!isEmailVaild || isEmailChecked) ? Color.white : Color.Gray400)
                        .padding(.horizontal, 27)
                        .padding(.vertical, 14)
                }
                .background(!(!isEmailVaild || isEmailChecked) ? Color.Gray600 : Color.Gray200)
                .cornerRadius(4)
                .disabled(!isEmailVaild || isEmailChecked)
            }
            .padding(.bottom, 13)
            
            Text("*  이메일 주소 인증을 통해 비밀번호를 찾을 수 있으니 실제 사용하는 이메일로 입력해주세요.")
                .font(.Medium12)
                .foregroundColor(Color.Gray500)
        }
        .padding(.top, 40)
    }
}

// MARK: - 비밀번호
struct PasswordSection: View {
    
    @Binding var password: String
    @Binding var confirmPassword: String
    @Binding var isPasswordVaild: Bool
    @Binding var doPasswordsMatch: Bool
    
    @FocusState private var isFocusedPassword: Bool
    @FocusState private var isFocusedPasswordMatch: Bool
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("비밀번호")
                    .font(.SemiBold16)
                    .foregroundColor(Color.Gray600)
                    .padding(.bottom, 20)
                
                Spacer()
                
                if isFocusedPassword && !isPasswordVaild {
                    Text("비밀번호 형식을 정확히 입력해주세요.")
                        .font(.SemiBold12)
                        .foregroundColor(Color.Pink400)
                        .padding(.bottom, 17)
                }
                if isPasswordVaild{
                    Text("사용 가능한 비밀번호에요.")
                        .font(.SemiBold12)
                        .foregroundColor(Color.Lightblue400)
                        .padding(.bottom, 17)
                }
            }
            
            SecureField("비밀번호", text: $password)
                .onChange(of: password) { _ in
                    isPasswordVaild = validatePassword(password)
                }
                .focused($isFocusedPassword)
                .padding(.horizontal, 16)
                .padding(.vertical, 14)
                .font(.Medium14)
                .foregroundColor(Color.black)
                .background(Color.Gray100)
                .cornerRadius(4)
                .padding(.bottom, 8)
            
            Text("*  영문 대문자와 소문자, 숫자, 특수문자 중 2가지 이상을 조합하여 8~20 자로 입력해주세요.")
                .font(.Medium12)
                .foregroundColor(Color.Gray500)
                .padding(.bottom, 8)
            
            HStack {
                Spacer()
                
                if isFocusedPasswordMatch && !doPasswordsMatch {
                    Text("비밀번호가 일치하지 않습니다.")
                        .font(.SemiBold12)
                        .foregroundColor(Color.Pink400)
                        .padding(.bottom, 12)
                }
                if doPasswordsMatch {
                    Text("비밀번호가 일치해요.")
                        .font(.SemiBold12)
                        .foregroundColor(Color.Lightblue400)
                        .padding(.bottom, 12)
                }
            }
            .frame(height: 14)
            
            SecureField("비밀번호 확인", text: $confirmPassword)
                .onChange(of: confirmPassword) { _ in
                    doPasswordsMatch = (password == confirmPassword)
                }
                .focused($isFocusedPasswordMatch)
                .padding(.horizontal, 16)
                .padding(.vertical, 14)
                .font(.Medium14)
                .foregroundColor(Color.black)
                .background(Color.Gray100)
                .cornerRadius(4)
        }
        .padding(.top, 40)
    }
}

// MARK: - 개인정보 수집 약관 동의
struct TermsAgreementSection: View {
    
    @Binding var isAgreed: Bool
    
    var body: some View {
        HStack(alignment: .center) {
            Button(action: {
                isAgreed.toggle()
            }) {
                Image(systemName: isAgreed ? "checkmark.circle.fill" : "circle")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width:30, height: 30)
                    .foregroundColor(isAgreed ? Color.Gray600 : Color.Gray200)
            }
            
            Spacer()
            
            Text("서비스 이용 및 개인정보 수집 약관에 동의합니다.")
                .font(.Medium14)
                .foregroundColor(Color.Gray500)
                .lineLimit(1)
            
            Spacer()
            
            Button(action: {
                // 화살표 버튼 액션
            }) {
                Image(systemName: "chevron.right")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 17, height: 17)
                    .foregroundColor(Color.Gray500)
            }
            .frame(width: 24, height: 24)
        }
        .padding(.top, 40)
    }
}

// MARK: - 이메일 형식 확인
extension EmailSection {
    func validateEmail(email: String) -> Bool {
        let emailPattern = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailPattern)
        return emailPred.evaluate(with: email)
    }
}

// MARK: - 비밀번호 형식 확인
extension PasswordSection {
    func validatePassword(_ password: String) -> Bool {
        // 최소 8자 이상 20자 이하
        guard password.count >= 8 && password.count <= 20 else { return false }
        
        // 영문 대문자, 소문자, 숫자, 특수문자 중 2가지 이상 조합
        let uppercase = CharacterSet.uppercaseLetters
        let lowercase = CharacterSet.lowercaseLetters
        let digits = CharacterSet.decimalDigits
        let specialCharacters = CharacterSet.punctuationCharacters.union(.symbols)
        
        var criteriaMet = 0
        if password.rangeOfCharacter(from: uppercase) != nil { criteriaMet += 1 }
        if password.rangeOfCharacter(from: lowercase) != nil { criteriaMet += 1 }
        if password.rangeOfCharacter(from: digits) != nil { criteriaMet += 1 }
        if password.rangeOfCharacter(from: specialCharacters) != nil { criteriaMet += 1 }
        
        return criteriaMet >= 2
    }
}

// MARK: - 키보드 숨기기
extension SignupView {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

#Preview {
    SignupView(isNavigationToSignupView: .constant(true))
}
