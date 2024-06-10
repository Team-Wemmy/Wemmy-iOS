//
//  Facility.swift
//  Wemmy-iOS
//
//  Created by 이예빈 on 6/10/24.
//

import Foundation

import MapKit

enum FacilityType: String, CaseIterable {
    case hospital = "의료시설"
    case communityServiceCenter = "행정시설"
    case childcare = "육아시설"
    case postpartumCare = "산후조리원"
}

enum ButtonType: CaseIterable {
    case postpartumCare, childcare, hospital, communityServiceCenter
    
    var title: String {
        switch self {
        case .postpartumCare: return "산후조리원"
        case .childcare: return "육아시설"
        case .hospital: return "의료시설"
        case .communityServiceCenter: return "행정시설"
        }
    }
    
    var imageName: String {
        switch self {
        case .postpartumCare: return "ecg-heart"
        case .childcare: return "baby-fill"
        case .hospital: return "hospital-box"
        case .communityServiceCenter: return "community-fill"
        }
    }
    
    var selectedImageName: String {
        switch self {
        case .postpartumCare: return "ecg-heart-white"
        case .childcare: return "baby-fill-white"
        case .hospital: return "hospital-box-white"
        case .communityServiceCenter: return "community-fill-white"
        }
    }
}

extension FacilityType {
    func toButtonType() -> ButtonType {
        switch self {
        case .postpartumCare:
            return .postpartumCare
        case .childcare:
            return .childcare
        case .hospital:
            return .hospital
        case .communityServiceCenter:
            return .communityServiceCenter
        }
    }
}

struct Facility: Identifiable {
    let id = UUID()
    let name: String
    let coordinate: CLLocationCoordinate2D
    let type: FacilityType
    let address: String
    let hours: String
    let contact: String
}

let Facilities = [
    Facility(name: "구로성심병원", coordinate: CLLocationCoordinate2D(latitude: 37.4996, longitude: 126.8664), type: .hospital, address: "서울 구로구 경인로 427", hours: "08:30 - 17:30", contact: "02-2067-1500"),
    Facility(name: "송미영가정의학과의원", coordinate: CLLocationCoordinate2D(latitude: 37.5015, longitude: 126.8653), type: .hospital, address: "서울 구로구 경인로47길 54", hours: "09:00 - 18:30", contact: "02-2683-5752"),
    Facility(name: "구로연세소아과의원", coordinate: CLLocationCoordinate2D(latitude: 37.4969, longitude: 126.8614), type: .hospital, address: "서울 구로구 경인로 373 2층", hours: "09:00 - 18:00", contact: "02-2611-3200"),
    Facility(name: "고척1동 주민센터", coordinate: CLLocationCoordinate2D(latitude: 37.5004, longitude: 126.8628), type: .communityServiceCenter, address: "서울 구로구 중앙로3길 18-8 고척제1동주민센터", hours: "09:00 - 18:00", contact: "02-2620-7800"),
]
