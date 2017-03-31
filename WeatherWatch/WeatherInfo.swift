//
//  WeatherInfo.swift
//  WeatherWatch
//
//  Created by Admin on 31.03.17.
//  Copyright © 2017 Admin. All rights reserved.
//

struct WeatherInfo {
    var cityName: String = ""
    var cityTemperature: String = ""
    
    init(name:String, temp:Int){
        self.cityName = name
        if temp > 0{
            self.cityTemperature = "+"+String(temp)+" C˚"
        }else{
            self.cityTemperature = String(temp)+" C˚"
        }
    }
    
}
