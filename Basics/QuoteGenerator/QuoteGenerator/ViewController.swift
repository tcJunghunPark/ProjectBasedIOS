//
//  ViewController.swift
//  QuoteGenerator
//
//  Created by Junghun Park on 2022/03/02.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var quoteLabel: UILabel!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    let quotes = [
        Quote(contents: "죽음을 ...", name: "벤다이크"),
        Quote(contents: "나는 나 ...", name: "비용"),
        Quote(contents: "편견이란 ...", name: "암브로스 빌")
        
    ]
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func tapQuoteGeneratorButton(_ sender: UIButton) {
        let random = Int(arc4random_uniform(3))
        let quote = quotes[random]
        self.quoteLabel.text = quote.contents
        self.nameLabel.text = quote.name
    }
    
}

