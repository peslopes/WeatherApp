//
//  CityWeather.swift
//  WeatherApp
//
//  Created by Pedro Enrique Sobrosa Lopes on 13/04/19.
//  Copyright © 2019 WeatherApp. All rights reserved.
//

import Foundation

struct CityWeather {
    let id: Int?
    let aplicableDate: String?
    let weatherState: WeatherState?
    let windSpeedInMPH: Float?
    let windDirection: Float?
    let temp: Float?
    let maxTemp: Float?
    let minTemp: Float?
    let airPressureInMBAR: Float?
    let humidity: Float?
    let visibilityInMiles: Float?
    let predictability: Int?
}
