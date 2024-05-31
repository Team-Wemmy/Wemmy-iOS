//
//  UserSettings.swift
//  Wemmy-iOS
//
//  Created by 이예빈 on 5/31/24.
//

import Combine

import Foundation

class UserSettings: ObservableObject {
    @Published var selectedRole: String {
        didSet {
            UserDefaults.standard.set(selectedRole, forKey: "selectedRole")
        }
    }
    
    init() {
        self.selectedRole = UserDefaults.standard.object(forKey: "selectedRole") as? String ?? ""
    }
}
