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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let session = URLSession.shared
        let url = URL(string: "https://www.metaweather.com/api/location/search/?query=london")!
        let task = session.dataTask(with: url, completionHandler: saveData(data:response:error:))
        task.resume()
    }
    
    private func saveData(data: Data?, response: URLResponse?, error: Error?) {
        if error == nil {
            if let data = data {
                let parser = Parser()
                let string = String(data: data, encoding: String.Encoding.utf8) ?? ""
                let woeid = parser.getWOEID(string: string) ?? ""
                let session = URLSession.shared
                let url = URL(string: "https://www.metaweather.com/api/location/\(woeid)/")!
                let task = session.dataTask(with: url, completionHandler: getDataFromWOEID(data:response:error:))
            }
        }
    }
    private func getDataFromWOEID(data: Data?, response: URLResponse?, error: Error?) {
        
    }

}

