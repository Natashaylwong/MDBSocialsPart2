//
//  DarkSkyAPI.swift
//  MDB Socials
//
//  Created by Natasha Wong on 3/3/18.
//  Copyright © 2018 Natasha Wong. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class DarkSkyAPI {
//    var currentTemp = "Chilly"
    var minutelySummary = "Chilly"
    var hourlySummary = "Chilly"
    var dailySummary = "Chilly"
    
    func getWeather() {
        var weatherData = Alamofire.request("https://api.darksky.net/forecast/50b32f864695d836f5360d46bdfb6a61/" + String(37.8716) + "," + String(122.2727)).responseJSON { response in
            if let json = response.result.value {
                let weatherData = JSON(json)
//                self.currentTemp = Int(weatherData["currently"]["temperature"].double!)
                self.minutelySummary = weatherData["minutely"]["summary"].stringValue
                self.hourlySummary = weatherData["hourly"]["summary"].stringValue
                self.dailySummary = weatherData["daily"]["summary"].stringValue
            }
        }
    }
}
                
                
                
                
                
                
                
                

                
//                self.temp = Int(json2["currently"]["temperature"].double!)
//                self.currentDesc = json2["currently"]["summary"].stringValue
//                let iconName = json2["currently"]["icon"].stringValue
//                self.precip = json2["minutely"]["data"][0]["precipType"].string
//                self.rainTime = json2["minutely"]["data"][0]["time"].double
//
//                if self.precip != "rain" {
//                    self.minutelyDesc = "It will not rain in the next hour."
//                } else {
//                    self.minutelyDesc = "It will rain at " + String(describing: NSDate(timeIntervalSince1970: self.rainTime)) + "!"
//                }
//
//                let weather = WeatherData(temperature: self.temp, rainData: self.minutelyDesc, weatherDescription: self.currentDesc, iconName: iconName)
//                // Notification manager
//                let nc = NotificationCenter.default
//                nc.post(name: Notification.Name(rawValue: "weather"), object: nil, userInfo: ["weather": weather])
//                self.notificationFinished = true
//                self.locManager.stopUpdatingLocation()
//                self.canWeSegue()

