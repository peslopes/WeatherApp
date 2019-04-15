//
//  ViewController.swift
//  WeatherApp
//
//  Created by Pedro Enrique Sobrosa Lopes on 12/04/19.
//  Copyright © 2019 WeatherApp. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var weatherDescriptionLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    var cityWeather: CityWeather?
    var woeid: String?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let session = URLSession.shared
        let url = URL(string: "https://www.metaweather.com/api/location/search/?query=london")!
        let task = session.dataTask(with: url, completionHandler: saveData(data:response:error:))
//        let task = session.dataTask(with: url) { (data, _, _) -> Void in
//            if let data = data {
//                let string = String(data: data, encoding: String.Encoding.utf8)
//                print(self.getWOEID(string: string!))
//            }
//        }
        task.resume()
    }
    
    private func saveData(data: Data?, response: URLResponse?, error: Error?) {
        if error == nil {
            if let data = data {
                let parser = Parser()
                let string = String(data: data, encoding: String.Encoding.utf8) ?? ""
                self.woeid = parser.getWOEID(string: string)
                print(woeid ?? "")
            }
        }
    }

}

