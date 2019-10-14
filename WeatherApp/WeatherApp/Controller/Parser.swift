//
//  Parser.swift
//  WeatherApp
//
//  Created by Pedro Enrique Sobrosa Lopes on 15/04/19.
//  Copyright © 2019 WeatherApp. All rights reserved.
//

import Foundation

class Parser {
    func getDataFromJSON(json: String) -> [CityWeather] {
        var cityWeatherInWeek: [CityWeather] = []
        var dict: [String:String] = [:]
        var itsAKey = true
        var itsAValue = false
        var key = ""
        var value = ""
        var started = false
        var newDay = false
        for char in json {
            if started{
                let putInKey = itsAKey && (char != ":" && char != "\\" && char != "{" && char != "\"" && char != ",")
                let putInValue = itsAValue && (char != "," && char != "\\" && char != "}" && char != "\"")
                if char == "]" {
                    break
                }
                else if putInKey {
                    key.append(char)
                }
                else if putInValue {
                    value.append(char)
                }
                else if char == ":" {
                    itsAKey = false
                    itsAValue = true
                    value = ""
                }
                else if char == "," {
                    itsAValue = false
                    if !newDay{
                        dict[key] = value
                    }
                    else {
                        newDay = false
                    }
                    itsAKey = true
                    key = ""
                }
                else if char == "}" {
                    dict[key] = value
                    cityWeatherInWeek.append(CityWeather(id: Int(dict["id"] ?? ""), aplicableDate: dict["applicable_date"], weatherState: getWeatherStateFromAbbr(abbr: dict["weather_state_abbr"] ?? ""), windSpeedInMPH: Float(dict["wind_speed"] ?? ""), windDirection: Float(dict["wind_direction"] ?? ""), temp: Int(Float(dict["the_temp"] ?? "") ?? -100.0), maxTemp: Int(Float(dict["max_temp"] ?? "") ?? -100.0), minTemp: Int(Float(dict["min_temp"] ?? "") ?? -100.0), airPressureInMBAR: Float(dict["air_pressure"] ?? ""), humidity: Float(dict["humidity"] ?? ""), visibilityInMiles: Float(dict["visibility"] ?? ""), predictability: Int(dict["predictability"] ?? "")))
                    itsAKey = true
                    itsAValue = false
                    dict = [:]
                    key = ""
                    newDay = true
                }
            }
            else if char == "[" {
                started = true
            }
        }
        
        
        return cityWeatherInWeek
    }
    
    private func getWeatherStateFromAbbr(abbr: String) -> WeatherState? {
        var type: WeatherState?
        WeatherState.allCases.forEach {
            if abbr == $0.rawValue{
                type = $0
            }
        }
        return type
    }
    
    func getCityNameShortcut(from cityName: String) -> String {
        var cityNameShortcut: String
        cityNameShortcut = cityName
        return cityNameShortcut
    }
    
    func getCity(string: String) -> City?{
        var key = ""
        var woeid = ""
        var cityName = ""
        var keyCanBeComing = true
        var titleIsComing = false
        var woeidIsComing = false
        var found = false
        for char in string{
            if !titleIsComing && !woeidIsComing {
                if keyCanBeComing && (char != ":" && char != "\\" && char != "\"" && char != "{" && char != "["){
                    key.append(char)
                }
                else if char == ","{
                    keyCanBeComing = true
                }
                else if char == ":"{
                    keyCanBeComing = false
                    if key == "woeid" {
                        woeidIsComing = true
                    }
                    else if key == "title" {
                        titleIsComing = true
                    }
                    key = ""
                }
            }
            else if char != "," && char != "}" && char != "\"" && char != "\\"{
                if titleIsComing{
                    cityName.append(char)
                }
                else {
                    woeid.append(char)
                }
            }
            else if woeidIsComing {
                found = true
                break
            }
            else if char == "," || char == "}" {
                titleIsComing = false
                keyCanBeComing = true
                key = ""
            }
        }
        if found  {
            getCity(string: cityName)
            return City(name: cityName, woeid: woeid)
        }
        return nil
    }
    
}
