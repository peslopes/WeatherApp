//
//  WeatherState.swift
//  WeatherApp
//
//  Created by Pedro Enrique Sobrosa Lopes on 13/04/19.
//  Copyright © 2019 WeatherApp. All rights reserved.
//

import Foundation

enum WeatherState: String, CaseIterable {
    case snow = "sn"
    case sleet = "sl"
    case hail = "h"
    case thunderstorm = "t"
    case heavyRain = "hr"
    case lightRain = "lr"
    case showers = "s"
    case heavyCloud = "hc"
    case lightCloud = "lc"
    case clear = "c"
    
    var description: String {
        switch self {
            
        case .snow:
            return "Snow"
        case .sleet:
            return "Sleet"
        case .hail:
            return "Hail"
        case .thunderstorm:
            return "Thunderstorm"
        case .heavyRain:
            return "Heavy rain"
        case .lightRain:
            return "Light rain"
        case .showers:
            return "Showers"
        case .heavyCloud:
            return "Heavy cloud"
        case .lightCloud:
            return "Light cloud"
        case .clear:
            return "Clear"
        }
    }
    var background: String {
        switch self{
        case .snow:
            return "snowing"
        case .sleet:
            return "snowing"
        case .hail:
            return "snowing"
        case .thunderstorm:
            return "storm"
        case .heavyRain:
            return "storm"
        case .lightRain:
            return "raining"
        case .showers:
            return "raining"
        case .heavyCloud:
            return "cloudy"
        case .lightCloud:
            return "sunny"
        case .clear:
            return "sunny"
        }
    }
}
