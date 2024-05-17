//
//  LoginView.swift
//  Wemmy-iOS
//
//  Created by 이예빈 on 5/17/24.
//

import SwiftUI

struct LoginView: View {
    
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var isLoginButtonActive = true
    
    var body: some View {
        VStack() {
            GreetingSection()
            
            LoginSection(email: $email, password: $password, isLoginButtonActive: $isLoginButtonActive)
            
            ActionSection()
            
            Spacer()
            
            BrowseWithoutSignUpButton()
        }
        .padding(.horizontal, 20)
    }
}

// MARK: - 인사말 세션
struct GreetingSection: View {
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("안녕하세요 :)")
                .font(.Bold30)
                .foregroundColor(Color.Gray700)
            
            Text("위미입니다.")
                .font(.Bold30)
                .foregroundColor(Color.Gray700)
        }
        .padding(.top, 80)
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

// MARK: - 로그인 세션
struct LoginSection: View {
    
    @Binding var email: String
    @Binding var password: String
    @Binding var isLoginButtonActive: Bool
    
    var body: some View {
        VStack {
            TextField("이메일 입력", text: $email)
                .padding(.horizontal, 20)
                .padding(.vertical, 16)
                .font(.Medium18)
                .foregroundColor(Color.black)
                .background(Color.white)
                .cornerRadius(5)
                .overlay(
                    RoundedRectangle(cornerRadius: 5)
                        .stroke(Color.Gray300, lineWidth: 1)
                )
                .padding(.bottom, 12)
            
            SecureField("비밀번호 입력", text: $password)
                .padding(.horizontal, 20)
                .padding(.vertical, 16)
                .font(.Medium18)
                .foregroundColor(Color.black)
                .background(Color.white)
                .cornerRadius(5)
                .overlay(
                    RoundedRectangle(cornerRadius: 5)
                        .stroke(Color.Gray300, lineWidth: 1)
                )
                .padding(.bottom, 16)
            
            CustomButton(title: "로그인", action: {
                
            }, isEnabled: isLoginButtonActive)
        }
        .padding(.top, 75)
    }
}

// MARK: - 비밀번호 찾기 및 회원가입 액션 세션
struct ActionSection: View {
    
    var body: some View {
        HStack(alignment: .center, spacing: 16){
            Button(action: {
                
            }) {
                Text("비밀번호 찾기")
                    .font(.SemiBold14)
                    .foregroundColor(Color.Gray700)
            }
            
            Rectangle()
                .frame(width: 1, height: 12)
                .foregroundColor(Color.Gray300)
            
            Button(action: {
                
            }) {
                Text("회원가입")
                    .font(.SemiBold14)
                    .foregroundColor(Color.Gray700)
            }
        }
        .padding(.top, 28)
    }
}

// MARK: - 회원가입 없이 둘러보기 버튼
struct BrowseWithoutSignUpButton: View {
    
    var body: some View {
        Button(action: {
            
        }) {
            Text("회원가입 없이 둘러보기")
                .font(.Medium14)
                .foregroundColor(Color.Gray500)
                .underline()
        }
        .padding(.bottom, 20)
    }
}

#Preview {
    LoginView()
}
