//
//  Benefit.swift
//  Wemmy-iOS
//
//  Created by 이예빈 on 6/3/24.
//

import Foundation

enum BenefitRoleType: String {
    case Pregnant
    case Caregiver
}

struct Benefit: Identifiable {
    let id = UUID()
    let role: BenefitRoleType
    let title: String
    let organization: String
    let representativeImage: String
    let targetAudience: String
    let content: String
    let applicationMethod: String
    let additionalInformation: String
    let link: URL
}

let benefits = [
    Benefit(role: .Pregnant, title: "임산부 교통비 지원", organization: "금천구", representativeImage: "GeumcheonBenefit", targetAudience: "서비스 대상\n\n서울시 6개월 이상 거주하고 있는 임신 · 출산한 임산부 ※ 2022.7.1. 이전 출산자, 외국인 임산부는 지원대상에서 제외", content: "서비스 내용\n\n- 지원내용 : 임산부 1인당 교통비 70만원(바우처) 지원\n- 지급방식 : 임산부 본인 명의 신용(체크)카드에 70만원 교통비 지급\n   ※ 신한, 삼성, KB국민, 우리, 하나, BC(하나BC, IBK기업) 카드 중 택1\n(카드사 별 신청 가능 카드 종류 상이하므로 별도 확인)\n- 사 용 처 : 대중교통비(버스,지하철,택시), 자가용 유류비\n- 신청기한 : 임신3개월~출산후 3개월 (※ 22.7.1.이전 출산자 지원 제외)\n- 사용기한 : 자녀출생일(분만예정일)로부터 12개월", applicationMethod: "서비스 신청방법\n\n• (온라인)서울시 임산부 교통비 지원 홈페이지 • (www.seoulmomcare.com)※ 임신기간 중 신청하는 경우, 정부24 ‘맘편한임신(지자체서비스-서울시임산부교통비지원 )’ 사전 신청 필수", additionalInformation: "서비스 문의처\n\n가족정책과(☎2627-1417)", link: URL(string: "https://www.naver.com/")!),
    Benefit(role: .Pregnant, title: "첫만남이용권지급", organization: "국가", representativeImage: "GovernmentBenefit", targetAudience: "-", content: "-", applicationMethod: "-", additionalInformation: "-", link: URL(string: "https://www.naver.com/")!),
    Benefit(role: .Pregnant, title: "맘편한임신 원스톱 서비스", organization: "국가", representativeImage: "GovernmentBenefit", targetAudience: "-", content: "-", applicationMethod: "-", additionalInformation: "-", link: URL(string: "https://www.naver.com/")!),
    Benefit(role: .Pregnant, title: "기본증명서 수수료 면제", organization: "금천구", representativeImage: "GeumcheonBenefit", targetAudience: "-", content: "-", applicationMethod: "-", additionalInformation: "-", link: URL(string: "https://www.naver.com/")!),
    Benefit(role: .Pregnant, title: "출산가구 전기요금 할인", organization: "국가", representativeImage: "GovernmentBenefit", targetAudience: "-", content: "-", applicationMethod: "-", additionalInformation: "-", link: URL(string: "https://www.naver.com/")!),
    Benefit(role: .Pregnant, title: "기본증명서 수수료 면제", organization: "금천구", representativeImage: "GeumcheonBenefit", targetAudience: "-", content: "-", applicationMethod: "-", additionalInformation: "-", link: URL(string: "https://www.naver.com/")!),
]
