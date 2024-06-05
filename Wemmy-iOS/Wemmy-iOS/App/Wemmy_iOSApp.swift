//
//  Wemmy_iOSApp.swift
//  Wemmy-iOS
//
//  Created by 이예빈 on 5/17/24.
//

import SwiftUI

@main
struct Wemmy_iOSApp: App {
    
    init() {
        
        let image = UIImage.gradientImageWithBounds(
            bounds: CGRect( x: 0, y: 0, width: UIScreen.main.scale, height: 6),
            colors: [
                UIColor.clear.cgColor,
                UIColor.black.withAlphaComponent(0.05).cgColor
            ]
        )
        
        //MARK: 탭바 투명도 제거
        let appearanceTabBar = UITabBarAppearance()
        
        appearanceTabBar.configureWithOpaqueBackground()
        
        appearanceTabBar.backgroundImage = UIImage()
        appearanceTabBar.shadowImage = image
        UITabBar.appearance().barTintColor = UIColor.white
        UITabBar.appearance().backgroundColor = UIColor.white
        UITabBar.appearance().isTranslucent = false
        UITabBar.appearance().standardAppearance = appearanceTabBar
    }
    
    var body: some Scene {
        WindowGroup {
            LaunchScreenCoordinator()
        }
    }
}

extension UIImage {
    static func gradientImageWithBounds(bounds: CGRect, colors: [CGColor]) -> UIImage {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
        gradientLayer.colors = colors

        UIGraphicsBeginImageContext(gradientLayer.bounds.size)
        gradientLayer.render(in: UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
}
