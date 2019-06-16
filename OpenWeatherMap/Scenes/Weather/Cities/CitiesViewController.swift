//
//  ViewController.swift
//  OpenWeatherMap
//
//  Created by Viktor Drykin on 13.03.2018.
//  Copyright © 2018 Viktor Drykin. All rights reserved.
//

import UIKit
import MBProgressHUD
class CitiesViewController: BaseViewController {
    
    @IBOutlet weak var citiesTableView: UITableView!
    
    let cityWeatherSegue = "CityWeatherSegue"
    let controllerTitle = "City List"
    
    var cities = [City]()
    var selectedCity : City?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViews()
        loadCities()
    }
    
    func configureViews() {
        self.navigationItem.title = controllerTitle
        citiesTableView.dataSource = self
        citiesTableView.delegate = self
    }
    
    func loadCities() {
        MBProgressHUD.showAdded(to: self.view, animated: true)
        APIWeather.shared.cities { [weak self] (result) in
            guard let realSelf = self else {
                return
            }
            if let commonCities = result as? [City] {
                realSelf.cities = commonCities
            }
            MBProgressHUD.hide(for: realSelf.view, animated: true)
            realSelf.citiesTableView.reloadData()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == cityWeatherSegue {
            let weatherViewController = segue.destination as! CityWeatherViewController
            weatherViewController.city = selectedCity
        }
    }

}


extension CitiesViewController : UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : CityTableViewCell = tableView.dequeueReusableCell(withIdentifier: CityTableViewCell.cellIdentifier()) as! CityTableViewCell
        let city = cities[indexPath.row]
        cell.city.text = city.name ?? ""
        cell.country.text = city.country ?? ""
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let city = cities[indexPath.row]
        if city.id != nil  {
            selectedCity = city
            self.performSegue(withIdentifier: cityWeatherSegue, sender: self)
        }
        
    }
}

