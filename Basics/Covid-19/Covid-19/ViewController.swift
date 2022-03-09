//
//  ViewController.swift
//  Covid-19
//
//  Created by Junghun Park on 2022/03/09.
//

import UIKit
import Alamofire //completion handler 가 main 에서 작동되기 때문에 dispatchqueue 필요 없음
import Charts

class ViewController: UIViewController {

    @IBOutlet var totalCaseLabel: UILabel!
    @IBOutlet var newCaseLabel: UILabel!
    
    @IBOutlet var pieChartView: PieChartView!
    
    @IBOutlet var labelStackView: UIStackView!
    @IBOutlet var indicatorView: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.indicatorView.startAnimating()
        self.fetchcovidOverview(completionHandelr: {
            [weak self] result in //순환참조 방지 weak
            guard let self = self else {return} //일시적으로 self strong 만듦
            self.indicatorView.stopAnimating()
            self.indicatorView.isHidden = true
            self.labelStackView.isHidden = false
            self.pieChartView.isHidden = false
            
            switch result {
            case let .success(result):
                self.configureStackView(koreaCovidOverview: result.korea)
                let covidOverViewList = self.makeCovidOverviewList(cityCovidOverview: result)
                self.configureChartView(covidOverviewList: covidOverViewList)
                
            case let .failure(error):
                debugPrint("error \(error)")
            }
        })
    }
    
    func makeCovidOverviewList(cityCovidOverview: CityCovidOverview) -> [CovidOverview]{
        print(cityCovidOverview)
        return [
            cityCovidOverview.seoul,
            cityCovidOverview.busan,
            cityCovidOverview.daegu,
            cityCovidOverview.incheon,
            cityCovidOverview.gwangju,
            cityCovidOverview.daejeon,
            cityCovidOverview.ulsan,
            cityCovidOverview.sejong,
            cityCovidOverview.gyeonggi,
            cityCovidOverview.chungbuk,
            cityCovidOverview.chungnam,
            cityCovidOverview.gyeongbuk,
            cityCovidOverview.gyeongnam,
            cityCovidOverview.jeju
        ]
    }
    
    func configureChartView(covidOverviewList : [CovidOverview]) {
        self.pieChartView.delegate = self
        let entries = covidOverviewList.compactMap{ [weak self] overview -> PieChartDataEntry? in
            guard let self = self else {return nil}
            return PieChartDataEntry(
                value: self.removeFormatString(string: overview.newCase),
                label: overview.countryName,
                data: overview
            )
        }
        let dataSet = PieChartDataSet(entries: entries, label: "코로나 발생 현황")
        dataSet.sliceSpace = 1
        dataSet.entryLabelColor = .black
        dataSet.valueTextColor = .black
        dataSet.xValuePosition = .outsideSlice
        dataSet.valueLinePart1OffsetPercentage = 0.8
        dataSet.valueLinePart1Length = 0.2
        dataSet.valueLinePart2Length = 0.3

        
        dataSet.colors = ChartColorTemplates.vordiplom() +
        ChartColorTemplates.joyful() +
        ChartColorTemplates.liberty() +
        ChartColorTemplates.pastel() +
        ChartColorTemplates.material()
        
        self.pieChartView.data = PieChartData(dataSet: dataSet)
        self.pieChartView.spin(duration: 0.3, fromAngle: self.pieChartView.rotationAngle, toAngle:
                                self.pieChartView.rotationAngle + 80)
    }
    
    func removeFormatString(string: String) -> Double{
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter.number(from:string)?.doubleValue ?? 0
    }
    
    func configureStackView(koreaCovidOverview: CovidOverview) {
        self.totalCaseLabel.text = "\(koreaCovidOverview.totalCase)명"
        self.newCaseLabel.text = "\(koreaCovidOverview.newCase)명"
    }

    func fetchcovidOverview(
        completionHandelr: @escaping (Result<CityCovidOverview, Error>) -> Void
    ) {
        let url = "https://api.corona-19.kr/korea/country/new/"
        let param = [
            "serviceKey": "jGhFB8arknsUyTzeJAmvSMEQiuDK4dCft"
        ]
        AF.request(url, method: .get, parameters: param)
            .responseData(completionHandler: { response in
            switch response.result {
            case let .success(data):
                do {
                    let decoder = JSONDecoder()
                    let result = try decoder.decode(CityCovidOverview.self, from: data)
                    completionHandelr(.success(result))
                }catch {
                    completionHandelr(.failure(error))
                }
            case let .failure(error):
                completionHandelr(.failure(error))
            }
        })
    }
}

extension ViewController: ChartViewDelegate {
    func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight) {
        guard let covidDetailViewController = self.storyboard?.instantiateViewController(identifier: "CovidDetailViewController") as? CovidDetailViewController else {return}
        guard let covidOverview = entry.data as? CovidOverview else {return}
        covidDetailViewController.covidOverview = covidOverview
        self.navigationController?.pushViewController(covidDetailViewController, animated: true)
    }
}

