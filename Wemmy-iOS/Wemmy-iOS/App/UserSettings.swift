//
//  UserSettings.swift
//  Wemmy-iOS
//
//  Created by 이예빈 on 5/31/24.
//

import Combine

import Foundation

struct ChildInfo: Codable {
    var birthDate: String = ""
    var name: String = ""
}

class UserSettings: ObservableObject {
    @Published var selectedRole: String {
        didSet {
            UserDefaults.standard.set(selectedRole, forKey: "selectedRole")
        }
    }
    
    @Published var dueDate: String {
        didSet {
            UserDefaults.standard.set(dueDate, forKey: "dueDate")
        }
    }
    @Published var fetusNames: [String] {
        didSet {
            UserDefaults.standard.set(fetusNames, forKey: "fetusNames")
        }
    }
    
    @Published var children: [ChildInfo] {
        didSet {
            if let encoded = try? JSONEncoder().encode(children) {
                UserDefaults.standard.set(encoded, forKey: "children")
            }
        }
    }
    
    @Published var selectedDistrict: String {
        didSet {
            UserDefaults.standard.set(selectedDistrict, forKey: "selectedDistrict")
        }
    }
    
    init() {
        self.selectedRole = UserDefaults.standard.object(forKey: "selectedRole") as? String ?? ""
        
        self.dueDate = UserDefaults.standard.object(forKey: "dueDate") as? String ?? ""
        self.fetusNames = UserDefaults.standard.object(forKey: "fetusNames") as? [String] ?? [""]
        
        if let childrenData = UserDefaults.standard.data(forKey: "children"),
           let decoded = try? JSONDecoder().decode([ChildInfo].self, from: childrenData) {
            self.children = decoded
        } else {
            self.children = [ChildInfo()]
        }
        
        self.selectedDistrict = UserDefaults.standard.object(forKey: "selectedDistrict") as? String ?? "자치구"
    }
}
