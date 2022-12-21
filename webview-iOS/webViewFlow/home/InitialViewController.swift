//
//  InitialViewController.swift
//  webview-iOS
//
//  Created by Millfford Robert Lima Bradshaw on 14/12/22.
//

import UIKit

class InitialViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        DefaultNavBar.buildNavBar(controller: self, title: "Welcome", disableBackButton: true)
    }


}
