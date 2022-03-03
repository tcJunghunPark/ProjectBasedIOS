//
//  CodePresentViewController.swift
//  ScrenTransactionExample
//
//  Created by Junghun Park on 2022/03/03.
//

import UIKit
protocol SendDataDelegate: AnyObject {
    func sendData(name: String)
}

class CodePresentViewController: UIViewController {

    @IBOutlet weak var nameLabel: UILabel!
    var name : String?
    weak var delegate: SendDataDelegate? //weak keyword는 weak 키워드 붙여야함 아니면 메모리 누수
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let name = name {
            self.nameLabel.text = name
            self.nameLabel.sizeToFit()
        }
    }
    
    @IBAction func backButton(_ sender: UIButton) {
        self.delegate?.sendData(name: "Taco")
        self.presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
}
