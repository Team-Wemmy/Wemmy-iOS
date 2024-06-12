//
//  FacilityView.swift
//  Wemmy-iOS
//
//  Created by 이예빈 on 5/22/24.
//

import SwiftUI

import MapKit
import CoreLocation

import BottomSheet

struct FacilityView: View {
    
    @State private var isFacilityDetailViewPresented: Bool = false
    
    @StateObject var viewModel = FacilityViewModel()
    
    var previewCoordinate: CLLocationCoordinate2D?
    
    var body: some View {
        ZStack {
            VStack{
                Map(coordinateRegion: $viewModel.region, showsUserLocation: true, annotationItems: viewModel.annotations.filter { place in
                    if let selectedType = viewModel.selectedType {
                        return place.type.toButtonType() == selectedType
                    }
                    return false
                }) { place in
                    MapAnnotation(coordinate: place.coordinate) {
                        FacilityAnnotationView(place: place) {
                            viewModel.selectedFacility = place
                            isFacilityDetailViewPresented = true
                        }
                    }
                }
                .onAppear {
                    if let previewCoordinate = previewCoordinate {
                        viewModel.region = MKCoordinateRegion(center: previewCoordinate, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
                    } else {
                        viewModel.checkIfLocationServicesIsEnabled()
                    }
                }
                .ignoresSafeArea()
            }
            
            VStack(alignment: .leading) {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 12) {
                        ForEach(ButtonType.allCases, id: \.self) { type in
                            FacilityButtonView(viewModel: viewModel, type: type)
                        }
                    }
                    .padding(20)
                }
                Spacer()
            }
            .bottomSheet(
                isPresented: $isFacilityDetailViewPresented,
                height: 200,
                topBarCornerRadius: 20,
                showTopIndicator: true
            ) {
                if let facility = viewModel.selectedFacility {
                    FacilityDetailView(facility: facility)
                }
            }
        }
    }
}

struct FacilityAnnotationView: View {
    let place: Facility
    let onTap: () -> Void
    
    var body: some View {
        VStack {
            facilityImage(for: place.type)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 40, height: 40)
                .onTapGesture {
                    onTap()
                }
            
            Text(place.name)
                .font(.SemiBold12)
                .foregroundColor(Color.black)
        }
    }
    
    private func facilityImage(for type: FacilityType) -> Image {
        switch type {
        case .hospital:
            return Image("Hospital")
        case .communityServiceCenter:
            return Image("CommunityServiceCenter")
        case .childcare:
            return Image("ChildcareFacility")
        case .postpartumCare:
            return Image("PostpartumcareCenter")
        }
    }
}

struct FacilityButtonView: View {
    
    @ObservedObject var viewModel: FacilityViewModel
    
    let type: ButtonType
    
    var body: some View {
        Button(action: {
            if viewModel.selectedType == type {
                viewModel.selectedType = nil
            } else {
                viewModel.selectedType = type
            }
        }) {
            HStack {
                Image(viewModel.selectedType == type ? type.selectedImageName : type.imageName)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 20, height: 20)
                
                Text(type.title)
                    .font(.Medium14)
                    .foregroundColor(viewModel.selectedType == type ? Color.white : Color.Gray700)
            }
            .padding(.horizontal, 12)
            .padding(.vertical, 8)
            .background(viewModel.selectedType == type ? Color.Pink600 : Color.white)
            .cornerRadius(100)
            .shadow(color: Color.black.opacity(0.2), radius: 4, x: 0, y: 0)
        }
    }
}

#Preview {
    FacilityView(previewCoordinate: CLLocationCoordinate2D(latitude: 37.5004, longitude: 126.8678))
}
