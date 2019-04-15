//
//  Parser.swift
//  WeatherApp
//
//  Created by Pedro Enrique Sobrosa Lopes on 15/04/19.
//  Copyright © 2019 WeatherApp. All rights reserved.
//

import Foundation

class Parser {
    func getWOEID(string: String) -> String?{
        var key = ""
        var value = ""
        var woeid = ""
        var keyCanBeComing = false
        var valueIsComing = false
        for char in string{
            if !valueIsComing {
                if keyCanBeComing && (char != ":" && char != "\\" && char != "\""){
                    key.append(char)
                }
                else if char == ","{
                    keyCanBeComing = true
                }
                else if char == ":"{
                    keyCanBeComing = false
                    if key == "woeid" {
                        valueIsComing = true
                    }
                    key = ""
                }
            }
            else if char != "," && char != "}" {
                value.append(char)
            }
            else {
                woeid = value
                break
            }
        }
        if !woeid.isEmpty {
            return woeid
        }
        return nil
    }
}
