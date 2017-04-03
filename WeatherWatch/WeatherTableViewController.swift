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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        weatherController?.setTableViewDelegate(tableViewDelegate: self)
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
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        if(segue.identifier == "ShowWeatherOnMap"){
            guard let weatherDetailViewController = segue.destination as? WeatherViewController else {
                fatalError("Unexpected destination: \(segue.destination)")
            }
            
            guard let selectedFilmCell = sender as? WeatherTableViewCell else {
                fatalError("Unexpected sender: \(sender)")
            }
            
            guard let indexPath = tableView.indexPath(for: selectedFilmCell) else {
                fatalError("The selected cell is not being displayed by the table")
            }
            weatherDetailViewController.weatherInfo = weatherController?.getCityWeatherInfo(index: indexPath.row)
        }
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
