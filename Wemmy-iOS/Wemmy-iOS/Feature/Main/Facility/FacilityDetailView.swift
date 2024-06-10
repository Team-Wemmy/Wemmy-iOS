//
//  FacilityDetailView.swift
//  Wemmy-iOS
//
//  Created by 이예빈 on 6/10/24.
//

import SwiftUI

import MapKit

struct FacilityDetailView: View {
    
    let facility: Facility
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack(alignment: .bottom) {
                Text(facility.name)
                    .font(.SemiBold20)
                    .foregroundColor(Color.Pink600)
                
                Text(facility.type.rawValue)
                    .font(.Medium12)
                    .foregroundColor(Color.Gray500)
            }
            .padding(.bottom, 12)
            
            HStack(spacing: 6) {
                Image(systemName: "mappin")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 12, height: 12)
                    .foregroundColor(Color.Gray700)
                
                Text(facility.address)
                    .font(.Regular16)
                    .foregroundColor(Color.Gray700)
            }
            .padding(.bottom, 4)
            
            HStack(spacing: 6) {
                Image(systemName: "clock.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 12, height: 12)
                    .foregroundColor(Color.Gray700)
                
                Text(facility.hours)
                    .font(.Regular16)
                    .foregroundColor(Color.Gray700)
            }
            .padding(.bottom, 4)
            
            HStack {
                Image(systemName: "phone.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 12, height: 12)
                    .foregroundColor(Color.Gray700)
                
                Text(facility.contact)
                    .font(.Regular16)
                    .foregroundColor(Color.Gray700)
            }
        }
        .padding(20)
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

#Preview {
    FacilityDetailView(facility: Facility(name: "구로성심병원", coordinate: CLLocationCoordinate2D(latitude: 37.4996, longitude: 126.8664), type: .hospital, address: "서울 구로구 경인로 427", hours: "08:30 - 17:30", contact: "02-2067-1500"))
}
