//
//  DayDetail.swift
//  WeatherApp
//
//  Created by Henrique Figueiredo Conte on 15/04/19.
//  Copyright © 2019 WeatherApp. All rights reserved.
//

import Foundation
import UIKit

class DayDetail: UIViewController {

    @IBOutlet weak var graphCanvas: UIView!
    @IBOutlet weak var cityName: UILabel!
    @IBOutlet weak var weatherState: UILabel!
    @IBOutlet weak var windSpeed: UILabel!
    @IBOutlet weak var humidity: UILabel!
    @IBOutlet weak var visibility: UILabel!
    @IBOutlet weak var pressure: UILabel!
    @IBOutlet var dayBackground: UIView!
    
    @IBOutlet weak var sixHour: UIView!
    @IBOutlet weak var tenHour: UIView!
    @IBOutlet weak var twelveHour: UIView!
    @IBOutlet weak var fourteenHour: UIView!
    @IBOutlet weak var sixteenHour: UIView!
    @IBOutlet weak var eighteenHour: UIView!
    @IBOutlet weak var twentytwoHour: UIView!
    
    @IBOutlet weak var labelSix: UILabel!
    
    var temperatureList:[String] = []
    
    var cityInformations:CityWeather? = nil
    var refreshCityName = " "
    var selectedDay = 0
    
    var url: URL?
    var dayWoeid = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        cityName.text = refreshCityName
        weatherState.text = cityInformations?.weatherState?.description
        windSpeed.text = "\(cityInformations?.windSpeedInMPH?.rounded() ?? 0.0) mph"
        humidity.text = "\(cityInformations?.humidity ?? 0.0)%"
        pressure.text = "\(cityInformations?.airPressureInMBAR?.rounded() ?? 0.0) hPa"
        visibility.text = "\(cityInformations?.visibilityInMiles?.rounded() ?? 0.0) mi"
        dayBackground.backgroundColor = UIColor(patternImage: UIImage(named: (cityInformations?.weatherState?.background)!)!)
 
        

        guard let date = cityInformations?.aplicableDate else {
            return
        }
        
        let actualDate = date.replacingOccurrences(of: "-", with: "/")
       
        url = URL(string: "https://www.metaweather.com/api/location/\(dayWoeid)/\(actualDate)/")
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        getDataFromDay { (temperatures, error) in
            if error == nil{
                DispatchQueue.main.async {
                    self.drawBar()
                }
                
            }
            else {
            }
        }
        
        
        
        
    }
    
    func getDataFromDay(completion: @escaping ([Float]?, Error?) -> ()){
        let request = NSMutableURLRequest(url:  self.url!)
        request.httpMethod = "GET"
        let task = URLSession.shared.dataTask(with: request as URLRequest) { (data, urlResponse, error) in
            if error != nil{
                completion(nil, error)
            } else {
                let decodedData = String(bytes: data!, encoding: .utf8)
                let temperatures = self.parseTemperature(json: decodedData)
                completion(temperatures, nil)
            }
        }
        task.resume()
    }
    
    private func parseTemperature(json: String?) -> [Float]? {
        
        
        guard let resultString = json else {
            return nil
        }
        
        var partialString = resultString.components(separatedBy: "min_temp")
        
        
        
        for i in 1..<partialString.count{
            partialString[i].remove(at: partialString[i].startIndex)
            partialString[i].remove(at: partialString[i].startIndex)
            
            let temporaryString = partialString[i].split(separator: ",")[0]

            temperatureList.append(String(temporaryString))
        }
        
        
        
            return nil
    }
    
//    private func getDataFromDay(data: Data?, response: URLResponse?, error: Error?){
//        if error == nil {
//            if let data = data {
//                let parser = Parser()
//                let json = String(data: data, encoding: String.Encoding.utf8) ?? ""
//                DispatchQueue.main.async {
//
//                }
//            }
//
//        }
//
//    }
    
    private func drawBar(){
        
        let heightCanvas = graphCanvas.frame.height
        let widthCanvas = graphCanvas.frame.width
        
        //hourSix.frame = CGRect(x: hourSix.frame.minX, y: hourSix.frame.minY, width: hourSix.frame.width, height: 30)
        //let heightConstraint = NSLayoutConstraint(item: hourSix, attribute: NSLayoutConstraint.Attribute.top, relatedBy: NSLayoutConstraint.Relation.equal, toItem: graphCanvas, attribute: NSLayoutConstraint.Attribute.top, multiplier: 1.0, constant: 20)
        
        //hourSix.addConstraint(heightConstraint)
        var temporaryConverter = Double(temperatureList[0])!
        var graphHeigth = CGFloat(temporaryConverter)
        graphHeigth = graphHeigth * -8
        
        sixHour.frame = CGRect(x: sixHour.frame.minX, y: sixHour.frame.midY + 10, width: 5, height: graphHeigth)
    
        temporaryConverter = Double(temperatureList[7])!
        graphHeigth = CGFloat(temporaryConverter)
        graphHeigth = graphHeigth * -11
        
        tenHour.frame = CGRect(x: tenHour.frame.minX, y: tenHour.frame.midY + 10, width: 5, height: graphHeigth)
        
        temporaryConverter = Double(temperatureList[12])!
        graphHeigth = CGFloat(temporaryConverter)
        graphHeigth = graphHeigth * -12
        
        twelveHour.frame = CGRect(x: twelveHour.frame.minX, y: twelveHour.frame.midY + 10, width: 5, height: graphHeigth)
        
        temporaryConverter = Double(temperatureList[17])!
        graphHeigth = CGFloat(temporaryConverter)
        graphHeigth = graphHeigth * -12
        
        fourteenHour.frame = CGRect(x: fourteenHour.frame.minX, y: fourteenHour.frame.midY + 10, width: 5, height: graphHeigth)
        
        temporaryConverter = Double(temperatureList[21])!
        graphHeigth = CGFloat(temporaryConverter)
        graphHeigth = graphHeigth * -11
        
        sixteenHour.frame = CGRect(x: sixteenHour.frame.minX, y: sixteenHour.frame.midY + 10, width: 5, height: graphHeigth)
        
        temporaryConverter = Double(temperatureList[24])!
        graphHeigth = CGFloat(temporaryConverter)
        graphHeigth = graphHeigth * -9
        
        eighteenHour.frame = CGRect(x: eighteenHour.frame.minX, y: eighteenHour.frame.midY + 10, width: 5, height: graphHeigth)
        
        temporaryConverter = Double(temperatureList[0])!
        graphHeigth = CGFloat(temporaryConverter)
        graphHeigth = graphHeigth * -8
        
        twentytwoHour.frame = CGRect(x: twentytwoHour.frame.minX, y: twentytwoHour.frame.midY + 10, width: 5, height: graphHeigth)
        
    }
    
}


