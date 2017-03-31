//
//  WeatherTableViewController.swift
//  WeatherWatch
//
//  Created by Admin on 31.03.17.
//  Copyright © 2017 Admin. All rights reserved.
//

import UIKit

class WeatherTableViewController: UITableViewController,WeatherDataProtocol{
    
    var weatherController:WeatherController? = nil
    
    private func loadWeatherInfo(){
        weatherController=WeatherController(tableViewDelegate: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadWeatherInfo()
        refreshControl = UIRefreshControl()
        self.refreshControl?.addTarget(self, action: #selector(WeatherTableViewController.refreshNewWeatherInfo), for: UIControlEvents.valueChanged)
    }
    
    func refreshNewWeatherInfo(refreshControl: UIRefreshControl){
        refreshBegin(refreshEnd: {(x:Int) -> () in
            self.tableView.reloadData()
            refreshControl.endRefreshing()
        })
    }
    
    func refreshBegin(refreshEnd: @escaping (Int) -> ()){
        DispatchQueue.global().async {
            self.weatherController?.getWeatherInfo()
            DispatchQueue.main.async {
                refreshEnd(0)
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return (weatherController?.getCountOfWeatherRecords())!
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "WeatherTableViewCell"
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? WeatherTableViewCell else {
            fatalError("The dequeued cell is not an instance of WeatherTableViewCell")
        }
        let weatherInfo = weatherController?.getCityWeatherInfo(index: indexPath.row)
        cell.lblCityName.text = weatherInfo!.cityName
        cell.lblTemperatureValue.text = weatherInfo!.cityTemperature
        return cell
    }
    
    func reloadAfter(){
        self.tableView.reloadData()
    }
    
    func showError(errorString:String){
        let alert=UIAlertController(title: "Error",message: errorString,preferredStyle:UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK",style: UIAlertActionStyle.default,handler: nil))
        self.present(alert,animated: true,completion: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        weatherController?.getWeatherInfo()
    }
}
