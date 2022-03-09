//
//  CovidDetailViewController.swift
//  Covid-19
//
//  Created by Junghun Park on 2022/03/09.
//

import UIKit

class CovidDetailViewController: UITableViewController {

    @IBOutlet var newCaseCell: UITableViewCell!
    @IBOutlet var totalCaseCell: UITableViewCell!
    @IBOutlet var recoveredCell: UITableViewCell!
    @IBOutlet var deathCell: UITableViewCell!
    @IBOutlet var percentageCell: UITableViewCell!
    @IBOutlet var overseasInflowCell: UITableViewCell!
    @IBOutlet var regionalOutbreakCell: UITableViewCell!
    
    var covidOverview: CovidOverview?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureView()

    }
    
    func configureView() {
        guard let covidOverview = self.covidOverview else {return}
        self.title = covidOverview.countryName
        self.newCaseCell.detailTextLabel?.text = "\(covidOverview.newCase)명"
        self.totalCaseCell.detailTextLabel?.text = "\(covidOverview.totalCase)명"
        self.recoveredCell.detailTextLabel?.text = "\(covidOverview.recovered)명"
        self.deathCell.detailTextLabel?.text = "\(covidOverview.death)명"
        self.percentageCell.detailTextLabel?.text = "\(covidOverview.percentage)%"
        self.overseasInflowCell.detailTextLabel?.text = "\(covidOverview.newFcase)명"
        self.regionalOutbreakCell.detailTextLabel?.text = "\(covidOverview.newCcase)명"
    }

}
