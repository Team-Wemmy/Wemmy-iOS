//
//  LaunchScreenCoordinator.swift
//  Wemmy-iOS
//
//  Created by 이예빈 on 5/17/24.
//

import SwiftUI

struct LaunchScreenCoordinator: View {
    
    @State var isLaunching: Bool = true
    
    var body: some View {
        VStack {
            if isLaunching {
                LaunchScreenView()
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                            isLaunching = false
                        }
                    }
            } else {
                LoginView()
            }
        }
    }
}

#Preview {
    LaunchScreenCoordinator()
}
