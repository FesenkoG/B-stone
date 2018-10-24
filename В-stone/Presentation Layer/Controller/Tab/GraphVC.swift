//
//  GraphVC.swift
//  В-stone
//
//  Created by Георгий Фесенко on 20.10.2018.
//  Copyright © 2018 Georgy. All rights reserved.
//

import UIKit
import Charts


class GraphVC: UIViewController {
    
    @IBOutlet weak var graphView: LineChartView!
    
    private let localDataService = LocalDataService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let entry1 = ChartDataEntry(x: 1.0, y: 1)
        let entry2 = ChartDataEntry(x: 2.0, y: 4)
        let entry3 = ChartDataEntry(x: 3.0, y: 9)
        let dataSet = LineChartDataSet(values: [entry1, entry2, entry3], label: "Widgets Type")
        let data = LineChartData(dataSets: [dataSet])
        graphView.data = data
        graphView.chartDescription?.text = "Парабола"
        dataSet.mode = .cubicBezier
        //Gradient
        let gradientColors = [UIColor.white.cgColor, UIColor.clear.cgColor] as CFArray // Colors of the gradient
        let colorLocations:[CGFloat] = [1.0, 0.0] // Positioning of the gradient
        let gradient = CGGradient.init(colorsSpace: CGColorSpaceCreateDeviceRGB(), colors: gradientColors, locations: colorLocations) // Gradient Object
        dataSet.fill = Fill.fillWithLinearGradient(gradient!, angle: 90.0) // Set the Gradient
        dataSet.drawFilledEnabled = true // Draw the Gradient
        //Colors
        dataSet.valueColors = [UIColor.white]
        dataSet.colors = [UIColor.white]
        dataSet.circleColors = [UIColor.white]
        
        graphView.xAxis.drawGridLinesEnabled = false
        graphView.xAxis.drawAxisLineEnabled = false
        graphView.rightAxis.enabled = false
        
        
        graphView.backgroundColor = #colorLiteral(red: 0.7607843137, green: 0.7803921569, blue: 0.8823529412, alpha: 1)
        graphView.chartDescription?.textColor = UIColor.white
        graphView.legend.textColor = UIColor.white
        graphView.drawGridBackgroundEnabled = false
        

        
        //Delegate
        graphView.delegate = self
        
        //This must stay at end of function
        graphView.notifyDataSetChanged()
    }
    
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        switch localDataService.fetchBluetoothData() {
//        case .success(let bluetoothData):
//            let chartEntryData = prepareForChart(bluetoothData)
//            let dataSet = LineChartDataSet(values: chartEntryData, label: nil)
//            let data = LineChartData(dataSets: [dataSet])
//            graphView.data = data
//
//
//            graphView.notifyDataSetChanged()
//        case .failure(let error):
//            print(error)
//        }
//    }
    
    private func prepareForChart(_ bluetoothData: [BluetoothInfo]) -> [ChartDataEntry] {
        return bluetoothData.map {
            ChartDataEntry(x: $0.measuredData.mean(), y: $0.measuredData.mean())
        }
    }
    
}

extension GraphVC: ChartViewDelegate {
    func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight) {
        print(entry.x, entry.y)
    }
}
