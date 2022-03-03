//
//  SeguePresentViewController.swift
//  ScrenTransactionExample
//
//  Created by Junghun Park on 2022/03/03.
//

import UIKit

class SeguePresentViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func backButton(_ sender: UIButton) {
        self.presentingViewController?.dismiss(animated: true, completion: nil)
//        self.navigationController?.popViewController(animated: true)
    }
    

}
