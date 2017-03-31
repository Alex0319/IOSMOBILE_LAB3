//
//  WeatherController.swift
//  FilmWatch
//
//  Created by Admin on 05.03.17.
//  Copyright © 2017 Admin. All rights reserved.
//
import SwiftyJSON
import Alamofire

class WeatherController{
    private var weatherInfoArray = [WeatherInfo]()
    private var tableViewDelegate:WeatherDataProtocol
    
    init(tableViewDelegate:WeatherDataProtocol){
        self.tableViewDelegate = tableViewDelegate
    }
    
    private func saveWeatherInfo(json:JSON){
        weatherInfoArray.removeAll(keepingCapacity: false)
        if let arrayCities=json["list"].array{
            for cityInfo in arrayCities{
                weatherInfoArray.append(WeatherInfo(name: cityInfo["name"].string!, temp: cityInfo["main"]["temp_max"].int!))
            }
        }
    }
    
    public func getWeatherInfo(){
        let manager = Alamofire.SessionManager.default
        manager.session.configuration.timeoutIntervalForRequest = 120
        Alamofire.request("http://api.openweathermap.org/data/2.5/group?id=5128581,5368361,4140963,6167865,6173331,4219762,2643743,2950159,2935517,2988507,2995469,8015556,3117735,3128760,756135,703448,625144,524901,629634,627145&units=metric&APPID=294a261b98a24fcd3df8816a7658d44e").validate().responseJSON { response in
            switch response.result{
            case .success(let value):
                self.saveWeatherInfo(json: JSON(value))
                self.tableViewDelegate.reloadAfter()
            case .failure(let error):
                self.tableViewDelegate.showError(errorString: "Error. Check connection")
            }
        }
    }
    
    public func getCountOfWeatherRecords() -> Int{
        return weatherInfoArray.count
    }
    
    public func getCityWeatherInfo(index:Int)-> WeatherInfo{
        return weatherInfoArray[index]
    }
}
