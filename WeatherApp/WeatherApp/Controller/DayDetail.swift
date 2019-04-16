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

    @IBOutlet weak var cityName: UILabel!
    @IBOutlet weak var weatherState: UILabel!
    @IBOutlet weak var windSpeed: UILabel!
    @IBOutlet weak var humidity: UILabel!
    @IBOutlet weak var visibility: UILabel!
    @IBOutlet weak var uvIndex: UILabel!
    @IBOutlet weak var pressure: UILabel!
    @IBOutlet weak var colorBar: UIView!
    @IBOutlet var dayBackground: UIView!
    
    
    var cityInformations:CityWeather? = nil
    var refreshCityName = " "
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //setColorBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        cityName.text = refreshCityName
        weatherState.text = cityInformations?.weatherState?.description
        windSpeed.text = "\(cityInformations?.windSpeedInMPH ?? 0.0) mph"
        humidity.text = "\(cityInformations?.humidity ?? 0.0)%"
        pressure.text = "\(cityInformations?.airPressureInMBAR ?? 0.0) hPa"
        visibility.text = "\(cityInformations?.visibilityInMiles ?? 0.0) mi"
        dayBackground.backgroundColor = UIColor(patternImage: UIImage(named: (cityInformations?.weatherState?.background)!)!)
        
    }
    
    
    
    func setColorBar(){
        
        let redColor = UIColor(red: 1.0, green: 0.61, blue: 0.58, alpha: 0.6).cgColor
        let blueColor = UIColor(red: 0.65 , green: 0.81, blue: 1.0, alpha: 0.6).cgColor
        
        var colorGradient = CAGradientLayer()
        colorGradient.type = .radial
        colorGradient.colors = [redColor, blueColor]
        colorGradient.locations = [0.0, 2.0]
        
        colorGradient.frame = colorBar.frame
        
        print("Gradiente: ", colorGradient.frame)
        print("Barra: ", colorBar.frame)
        
        
        colorBar.layer.insertSublayer(colorGradient, at: 0)
        
        //colorBar = CAGradientLayer()
        //colorBar.colors = [redColor, blueColor]
    }
    
}


