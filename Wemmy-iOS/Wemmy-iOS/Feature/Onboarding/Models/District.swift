//
//  District.swift
//  Wemmy-iOS
//
//  Created by 이예빈 on 5/21/24.
//

import Foundation

struct District: Identifiable {
    let id = UUID()
    let name: String
}

let districts = [
    District(name: "강남구"), District(name: "강동구"), District(name: "강북구"), District(name: "강서구"),
    District(name: "관악구"), District(name: "광진구"), District(name: "구로구"), District(name: "금천구"),
    District(name: "노원구"), District(name: "도봉구"), District(name: "동대문구"), District(name: "동작구"),
    District(name: "마포구"), District(name: "서대문구"), District(name: "서초구"), District(name: "성동구"),
    District(name: "성북구"), District(name: "송파구"), District(name: "양천구"), District(name: "영등포구"),
    District(name: "용산구"), District(name: "은평구"), District(name: "종로구"), District(name: "중구"),
    District(name: "중랑구")
]
