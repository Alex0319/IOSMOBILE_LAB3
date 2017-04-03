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
    private var tableViewDelegate:WeatherDataProtocol? = nil
        
    public func setTableViewDelegate(tableViewDelegate:WeatherDataProtocol){
        self.tableViewDelegate = tableViewDelegate
    }
    
    private func saveWeatherInfo(json:JSON){
        weatherInfoArray.removeAll(keepingCapacity: false)
        if let arrayCities=json["list"].array{
            for cityInfo in arrayCities{
                if let weatherInfo = cityInfo["weather"].array{
                    weatherInfoArray.append(WeatherInfo(name: cityInfo["name"].string!, latitude: cityInfo["coord"]["lat"].double!, longitude: cityInfo["coord"]["lon"].double!, temperature: cityInfo["main"]["temp_max"].int!, pressure: cityInfo["main"]["pressure"].int!, humidity: cityInfo["main"]["humidity"].int!, windSpeed: cityInfo["wind"]["speed"].double!, description: weatherInfo[0]["description"].string!))
                }
            }
        }
    }
    
    public func getWeatherInfo(){
        let manager = Alamofire.SessionManager.default
        manager.session.configuration.timeoutIntervalForRequest = 120
        Alamofire.request("http://api.openweathermap.org/data/2.5/group?id=5128581,5368361,4140963,6167865,6173331,6545158,2643743,2643123,2950159,2935517,2988507,2995469,8015556,3117735,3128760,756135,703448,625144,524901,627145&lang=ru&units=metric&APPID=294a261b98a24fcd3df8816a7658d44e").validate().responseJSON { response in
            switch response.result{
            case .success(let value):
                self.saveWeatherInfo(json: JSON(value))
                if(self.tableViewDelegate != nil){
                    self.tableViewDelegate?.reloadAfter()
                }
            case .failure(let error):
                if(self.tableViewDelegate != nil){
                    self.tableViewDelegate?.showError(errorString: "Ошибка. Проверьте подключение к Интернету")
                }
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
