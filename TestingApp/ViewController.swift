//
//  ViewController.swift
//  TestingApp
//
//  Created by Haider Khan on 2/3/18.
//  Copyright © 2018 moco. All rights reserved.
//

import UIKit
import MocoSDK
import CoreLocation

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // This will call our permissions service you can handle services passively here and test it out
        let manager = CLLocationManager()
        manager.requestWhenInUseAuthorization()
    }

}

