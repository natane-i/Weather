//
//  LaunchViewController.swift
//  Weather
//
//  Created by spark-01 on 2024/05/23.
//

import UIKit

class LaunchViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()


    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        performSegue(withIdentifier: "NextPage", sender: nil)
        
    }

}
