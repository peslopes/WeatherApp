//
//  ViewController.swift
//  WeatherApp
//
//  Created by Pedro Enrique Sobrosa Lopes on 12/04/19.
//  Copyright © 2019 WeatherApp. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var firstScreenView: UIView!
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var weatherDescriptionLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    var cityWeatherInWeek: [CityWeather]?
    var city: City?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        cityNameLabel.text = ""
        weatherDescriptionLabel.text = ""
        temperatureLabel.text = ""
        let session = URLSession.shared
        cityNameLabel.text = ""
        let url = URL(string: "https://www.metaweather.com/api/location/search/?query=paris")!
        let task = session.dataTask(with: url, completionHandler: saveData(data:response:error:))
        task.resume()
    }
    
    private func saveData(data: Data?, response: URLResponse?, error: Error?) {
        if error == nil {
            if let data = data {
                let parser = Parser()
                let json = String(data: data, encoding: String.Encoding.utf8) ?? ""
                city = parser.getCity(string: json)
                let session = URLSession.shared
                if city != nil {
                    DispatchQueue.main.async {
                        self.cityNameLabel.text = self.city!.name
                    }
                    let url = URL(string: "https://www.metaweather.com/api/location/\(city!.woeid!)/")!
                    let task = session.dataTask(with: url, completionHandler: getDataFromWOEID(data:response:error:))
                    task.resume()
                }
            }
        }
    }
    private func getDataFromWOEID(data: Data?, response: URLResponse?, error: Error?) {
        if error == nil {
            if let data = data {
                let parser = Parser()
                let json = String(data: data, encoding: String.Encoding.utf8) ?? ""
                DispatchQueue.main.async {
                    self.cityWeatherInWeek = parser.getDataFromJSON(json: json)
                    self.weatherDescriptionLabel.text = self.cityWeatherInWeek?[0].weatherState?.description
                    self.temperatureLabel.text = (self.cityWeatherInWeek?[0].temp!.description)! + "°"
                    self.tableView.reloadData()
                    let backgroundImage = self.cityWeatherInWeek?[0].weatherState?.background
                    self.firstScreenView.backgroundColor = UIColor(patternImage: UIImage(named: backgroundImage!)!)
                }
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let nextViewController = segue.destination as? DayDetail {
            
            //nextViewController.
            
           
        }
    }

}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (cityWeatherInWeek?.count ?? 6) - 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "weatherDaysCell") as? WeatherDaysCell else {
            return UITableViewCell()
        }
        cell.maxTemp.text = cityWeatherInWeek?[indexPath.row + 1].maxTemp?.description ?? ""
        cell.minTemp.text = cityWeatherInWeek?[indexPath.row + 1].minTemp?.description ?? ""
        let formatter = DateFormatter()
        formatter.dateFormat = "YYYY-MM-dd"
        let date = formatter.date(from: cityWeatherInWeek?[indexPath.row + 1].aplicableDate ?? "")
        
        if date != nil{
            let weekDay = formatter.weekdaySymbols[Calendar.current.component(.weekday, from: date!) - 1]
            cell.weekDay.text = weekDay
        }
        else {
            cell.weekDay.text = ""
        }
        let abbr = cityWeatherInWeek?[indexPath.row + 1].weatherState?.rawValue
        if abbr != nil {
            cell.weatherStateImage.image = UIImage(named: abbr!)
        }
        return cell
    }
    

}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("entrou na table view")
        performSegue(withIdentifier: "dayDetails", sender: cityWeatherInWeek![indexPath.row + 1])
    
        print("performou a segue")
    }
}


