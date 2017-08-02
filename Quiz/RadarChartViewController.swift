//
//  RadarChartViewController.swift
//  Quiz
//
//  Created by nttr on 2017/07/25.
//  Copyright © 2017年 nttr. All rights reserved.
//

import UIKit
import Charts

class RadarChartViewController: UIViewController {
    
    @IBOutlet var chartView: RadarChartView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        // var rect = view.bounds
        // rect.origin.y += 20
        // rect.size.height -= 20
        // let chartView = RadarChartView(frame: rect)
        let ud = UserDefaults.standard
        var scores = ud.array(forKey: "Scores") as? [Double]
        
        if let scoreArray = scores {
            let entries = [
                RadarChartDataEntry(value: scoreArray[1]),
                RadarChartDataEntry(value: scoreArray[2]),
                RadarChartDataEntry(value: scoreArray[3]),
                RadarChartDataEntry(value: scoreArray[4]),
                RadarChartDataEntry(value: scoreArray[0])
            ]
            let subject = ["興味","性格","敵対心","都会度","田舎度"]
            
            let set = RadarChartDataSet(values: entries, label: "Score")
            
            chartView.chartDescription?.text = "あなたの小平適正度"
            chartView.animate(xAxisDuration: 2.0)
            set.colors = ChartColorTemplates.colorful()
            chartView.data = RadarChartData(dataSet: set)
            chartView.xAxis.valueFormatter = IndexAxisValueFormatter(values: subject)
            
        } else {
            
        }

    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
    
    
    @IBAction func back(){
        self.dismiss(animated: true, completion: nil)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
