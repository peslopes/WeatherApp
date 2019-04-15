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
    @IBOutlet weak var tableView: UITableView!
    var cityWeatherInWeek: [CityWeather]?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let session = URLSession.shared
        cityNameLabel.text = "London"
        let url = URL(string: "https://www.metaweather.com/api/location/search/?query=london")!
        let task = session.dataTask(with: url, completionHandler: saveData(data:response:error:))
        task.resume()
    }
    
    private func saveData(data: Data?, response: URLResponse?, error: Error?) {
        if error == nil {
            if let data = data {
                let parser = Parser()
                let json = String(data: data, encoding: String.Encoding.utf8) ?? ""
                let woeid = parser.getWOEID(string: json) ?? ""
                let session = URLSession.shared
                let url = URL(string: "https://www.metaweather.com/api/location/\(woeid)/")!
                let task = session.dataTask(with: url, completionHandler: getDataFromWOEID(data:response:error:))
                task.resume()
            }
        }
    }
    private func getDataFromWOEID(data: Data?, response: URLResponse?, error: Error?) {
        if error == nil {
            if let data = data {
                let parser = Parser()
                let json = String(data: data, encoding: String.Encoding.utf8) ?? ""
                cityWeatherInWeek = parser.getDataFromJSON(json: json)
                DispatchQueue.main.async {
                    self.weatherDescriptionLabel.text = self.cityWeatherInWeek?[0].weatherState?.description
                    self.temperatureLabel.text = Int(self.cityWeatherInWeek?[0].temp ?? 0.0).description
                }
            }
        }
    }

}

//extension ViewController: UITableViewDataSource {
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return 6
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        <#code#>
//    }
//    
//
//}

