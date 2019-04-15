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
}
