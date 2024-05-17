//
//  LaunchScreenView.swift
//  Wemmy-iOS
//
//  Created by 이예빈 on 5/17/24.
//

import SwiftUI

struct LaunchScreenView: View {
        
    var body: some View {
        ZStack {
            Color.white
            
            VStack {
                Image("Logo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 80, height: 80)
            }
        }
        .ignoresSafeArea()
    }
}

#Preview {
    LaunchScreenView()
}
