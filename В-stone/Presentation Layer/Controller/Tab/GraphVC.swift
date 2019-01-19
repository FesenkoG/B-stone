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
    private var data: [ChartDataEntry] = []
    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        let entry1 = ChartDataEntry(x: 1.0, y: 40)
//        let entry2 = ChartDataEntry(x: 2.0, y: 70)
//        let entry3 = ChartDataEntry(x: 3.0, y: 60)
//        let dataSet = LineChartDataSet(values: [entry1, entry2, entry3], label: "")
//        let data = LineChartData(dataSets: [dataSet])
//        graphView.data = data
//        dataSet.mode = .cubicBezier
//        //Gradient
//        let gradientColors = [UIColor.white.cgColor, UIColor.clear.cgColor] as CFArray // Colors of the gradient
//        let colorLocations:[CGFloat] = [1.0, 0.0] // Positioning of the gradient
//        let gradient = CGGradient.init(colorsSpace: CGColorSpaceCreateDeviceRGB(), colors: gradientColors, locations: colorLocations) // Gradient Object
//        dataSet.fill = Fill.fillWithLinearGradient(gradient!, angle: 90.0) // Set the Gradient
//        dataSet.drawFilledEnabled = true // Draw the Gradient
//        //Colors
//        dataSet.valueColors = [UIColor.white]
//        dataSet.colors = [UIColor.white]
//        dataSet.circleColors = [UIColor.white]
//        graphView.leftAxis.labelTextColor = UIColor.white
//        graphView.leftAxis.labelFont = UIFont.systemFont(ofSize: 18)
//        graphView.backgroundColor = #colorLiteral(red: 0.7607843137, green: 0.7803921569, blue: 0.8823529412, alpha: 1)
//        graphView.chartDescription?.textColor = UIColor.white
//        
//        //Some magic with axes
//        graphView.xAxis.drawGridLinesEnabled = false
//        graphView.xAxis.drawAxisLineEnabled = false
//        graphView.rightAxis.enabled = false
//        graphView.xAxis.drawLabelsEnabled = false
//        graphView.leftAxis.drawGridLinesEnabled = false
//        graphView.rightAxis.drawGridLinesEnabled = false
//        
//        //Sizes
//        dataSet.circleRadius = 10.0
//        dataSet.lineWidth = 1.0
//        
//        graphView.legend.enabled = false
//        graphView.drawGridBackgroundEnabled = false
//        //Touches
//        graphView.highlightPerTapEnabled = false
//        //Limits
//        graphView.leftAxis.axisMaximum = 100
//        graphView.leftAxis.axisMinimum = 0
//        //Delegate
//        graphView.delegate = self
//        
//        //This must stay at end of function
//        graphView.notifyDataSetChanged()
//    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        switch localDataService.fetchBluetoothData() {
        case .success(let bluetoothData):
            let chartEntryData = prepareForChart(bluetoothData)
            let dataSet = LineChartDataSet(values: chartEntryData, label: nil)
            let data = LineChartData(dataSets: [dataSet])
            graphView.data = data
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
            graphView.leftAxis.labelTextColor = UIColor.white
            graphView.leftAxis.labelFont = UIFont.systemFont(ofSize: 18)
            graphView.backgroundColor = #colorLiteral(red: 0.7607843137, green: 0.7803921569, blue: 0.8823529412, alpha: 1)
            graphView.chartDescription?.textColor = UIColor.white
            
            //Some magic with axes
            graphView.xAxis.drawGridLinesEnabled = false
            graphView.xAxis.drawAxisLineEnabled = false
            graphView.rightAxis.enabled = false
            graphView.xAxis.drawLabelsEnabled = false
            graphView.leftAxis.drawGridLinesEnabled = false
            graphView.rightAxis.drawGridLinesEnabled = false
            
            //Sizes
            dataSet.circleRadius = 10.0
            dataSet.lineWidth = 1.0
            
            graphView.legend.enabled = false
            graphView.drawGridBackgroundEnabled = false
            //Touches
            graphView.highlightPerTapEnabled = false
            //Limits
            graphView.leftAxis.axisMaximum = 100
            graphView.leftAxis.axisMinimum = 0
            //Delegate
            graphView.delegate = self
            
            //This must stay at end of function
            graphView.notifyDataSetChanged()
        case .failure(let error):
            print(error)
        }
    }
    
    private func prepareForChart(_ bluetoothData: [BluetoothInfo]) -> [ChartDataEntry] {
        return bluetoothData.map {
            ChartDataEntry(x: $0.measuredData.mean(), y: $0.measuredData.mean())
        }
    }
    
}

extension GraphVC: ChartViewDelegate {
    func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight) {
        print(entry.x, entry.y)
        let width = chartView.bounds.width
        let height = chartView.bounds.height
        
        guard let first = data.first,
            let last = data.last else { return }
        let difference = CGFloat(last.x - first.x + 1.0)
        let yPosition = (height / 100) * CGFloat(entry.y)
        let xPosition = (width / difference) * CGFloat(entry.x)
        
        let point = CGPoint(x: xPosition, y: yPosition)
        print(point)
    }
}
