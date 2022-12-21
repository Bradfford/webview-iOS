//
//  DefaultNavBar.swift
//  webview-iOS
//
//  Created by Millfford Robert Lima Bradshaw on 15/12/22.
//

import Foundation
import UIKit

class DefaultNavBar {
    
    static var origin = UIViewController()
    static var moveToRoot = false
    static var disableBackGround = false
    static var sendBackAnalyticEvents: (() -> Void)?

    public static func setBackAnalyticEvents(sendBackAnalyticEvents: @escaping (() -> Void)) {
        self.sendBackAnalyticEvents = sendBackAnalyticEvents
    }
    
    public static func resetProperties() {
        moveToRoot = false
        disableBackGround = false
        sendBackAnalyticEvents = nil
    }
    
    public static func buildNavBar(controller: UIViewController, title: String = "", isFirstController: Bool = false, disableBackButton: Bool = false, disableBackGround: Bool = false) {
        
        self.resetProperties()
        
        self.origin = controller
        self.moveToRoot = isFirstController
        self.disableBackGround = disableBackGround
        
        let attrs = [
                    NSAttributedString.Key.foregroundColor: UIColor.white,
                    //NSAttributedString.Key.fontSize: 18 //UIFont(name: "ProximaNova-Medium", size: 18)
                ]

        if disableBackGround {
            if #available(iOS 15.0, *) {
                let appearance = UINavigationBarAppearance()
                appearance.configureWithTransparentBackground()
                self.origin.navigationController?.navigationBar.standardAppearance = appearance
                self.origin.navigationController?.navigationBar.scrollEdgeAppearance = appearance
            } else {
                self.origin.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
                self.origin.navigationController?.navigationBar.shadowImage = UIImage()
            }

        } else {
            if #available(iOS 15.0, *) {
                let appearance = UINavigationBarAppearance()
                appearance.configureWithOpaqueBackground()
                appearance.backgroundColor = UIColor(hexString: "01874D")
                appearance.titleTextAttributes = attrs as [NSAttributedString.Key : Any]
                self.origin.navigationController?.navigationBar.standardAppearance = appearance
                self.origin.navigationController?.navigationBar.scrollEdgeAppearance = appearance
            } else {
                self.origin.navigationController?.navigationBar.isTranslucent = false
                self.origin.navigationController?.navigationBar.barTintColor = UIColor(hexString: "01874D")
                self.origin.navigationController?.navigationBar.titleTextAttributes = attrs as [NSAttributedString.Key : Any]
            }
        }
        
        self.origin.navigationItem.hidesBackButton = disableBackButton
        self.origin.title = title
        self.origin.navigationController?.navigationBar.sizeToFit()
        if !disableBackButton {
            self.origin.navigationItem.setLeftBarButton(self.makeBackButton(), animated: true)
        }
        
    }
    
    private static func makeBackButton() -> UIBarButtonItem {
        let backImage = UIImage(named: "icnArrowLeftWhite")
        let backButton = UIBarButtonItem(image: backImage, style: .plain, target: self, action: #selector(backButtonPressed))
        backButton.tintColor = .white
        backButton.accessibilityLabel = "Voltar"
        return backButton
    }
    
    @objc static func backButtonPressed() {
        
        if let sendBackAnalyticEvents = self.sendBackAnalyticEvents {
            sendBackAnalyticEvents()
            
        }

        if self.moveToRoot {
            self.origin.dismiss(animated: true, completion: {})
        } else {
            self.origin.navigationController?.popViewController(animated: true)
        }
    }
    
}

