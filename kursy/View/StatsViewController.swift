//
//  StatsViewController.swift
//  kursy
//
//  Created by Piotr Żakieta on 06/05/2022.
//

import UIKit
import Charts

class StatsViewController: UIViewController {

    @IBOutlet weak var lineChartView: LineChartView!
    
    var nbpDataDetail: NBPModelDetail!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        updateLineChart()
    }
    
    func updateLineChart(){
        
        if let nbpDataDetail = nbpDataDetail?.rates {
            if nbpDataDetail.count < 5{
                print("mniej niz 5")
                lineChartView.isHidden = true
                lineChartView.layer.frame.size.height = 1
            }else{
                
                lineChartView.layer.frame.size.height = 300
                lineChartView.isHidden = false
                var lineChartEntry = [ChartDataEntry]()
                for i in 0..<nbpDataDetail.count{
                    let value = ChartDataEntry(x: Double(i), y: nbpDataDetail[i].mid)
                    lineChartEntry.append(value)
                }
                let lineForChart1 = LineChartDataSet(entries: lineChartEntry, label: "Wykres dla ")
                lineForChart1.colors = [NSUIColor.blue]
                lineForChart1.drawCirclesEnabled = false
                lineForChart1.drawValuesEnabled = false
               
                
                let data = LineChartData()
                data.addDataSet(lineForChart1)
                
                lineChartView.data = data
                lineChartView.chartDescription?.text = "Wykres dla"
                lineChartView.backgroundColor = UIColor.white
                lineChartView.animate(xAxisDuration: 1.0)
            }
            
        }
    }

}
