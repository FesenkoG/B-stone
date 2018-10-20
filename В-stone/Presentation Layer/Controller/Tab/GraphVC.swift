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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let entry1 = ChartDataEntry(x: 1.0, y: 1)
        let entry2 = ChartDataEntry(x: 2.0, y: 4)
        let entry3 = ChartDataEntry(x: 3.0, y: 9)
        let dataSet = LineChartDataSet(values: [entry1, entry2, entry3], label: "Widgets Type")
        let data = LineChartData(dataSets: [dataSet])
        graphView.data = data
        graphView.chartDescription?.text = "Парабола"
        
        //All other additions to this function will go here
        dataSet.colors = ChartColorTemplates.joyful()
        dataSet.valueColors = [UIColor.black]

        graphView.backgroundColor = UIColor.black
        graphView.chartDescription?.textColor = UIColor.white
        graphView.legend.textColor = UIColor.white
        
        //This must stay at end of function
        graphView.notifyDataSetChanged()
    }
    
}
