//
//  CityWeatherViewController.swift
//  OpenWeatherMap
//
//  Created by Viktor Drykin on 13.03.2018.
//  Copyright © 2018 Viktor Drykin. All rights reserved.
//

import UIKit
import MBProgressHUD
import MapKit

protocol CityWeatherViewProtocol : class {
    func updateView()
    func showProgressHUD()
    func hideProgressHUD()
    func showError(text : String)
    func updateNavigationBar(cityName name : String?, date : Date?)
}


class CityWeatherViewController: BaseViewController {
    
    @IBOutlet weak var map: MKMapView!
    @IBOutlet weak var cityWeatherTableView: UITableView!
    
    var presenter : CityWeatherViewPresenter!
    var city : City?

    override func viewDidLoad() {
        super.viewDidLoad()
        configureViews()
        updateNavigationBar(cityName : city?.name, date : nil)
        presenter = CityWeatherPresenter(withView: self)
        presenter.downloadWeatherInformation(cityId: city?.id)
    }

    func configureViews() {
        cityWeatherTableView.dataSource = self
    }
    
    func updateNavigationBar(cityName name : String?, date : Date?) {
        self.navigationItem.title = (name ?? "") + " (\(date?.text ?? ""))"

    }
}

extension CityWeatherViewController : CityWeatherViewProtocol {
    
    func updateView() {
        let mapParameters = presenter.mapParameters()
        map.setMapVisibleArea(lat: mapParameters.lat, lng: mapParameters.lng, visibility: mapParameters.visibility)
        cityWeatherTableView.reloadData()
    }
    
    func showProgressHUD() {
        MBProgressHUD.showAdded(to: self.view, animated: true)
    }
    
    func hideProgressHUD() {
        MBProgressHUD.hide(for: self.view, animated: true)
    }
    
    func showError(text: String) {
        self.showAlertView(text, nil)
    }
    
}

extension CityWeatherViewController : UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return presenter.numberOfSections();
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.numberOfRowsInSection(section: section);
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return presenter.rowHeight(section: indexPath.section, row: indexPath.row) ?? UITableViewAutomaticDimension
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case CityWeatherSection.weather.rawValue:
            let cell : WeatherTableViewCell = tableView.dequeueReusableCell(withIdentifier: WeatherTableViewCell.cellIdentifier()) as! WeatherTableViewCell
            let info = presenter.weatherMainInformation()
            cell.setInfo(main: info.main, description: info.description, imageAddress: info.imageAddress)
            return cell;
        case CityWeatherSection.mainInformation.rawValue:
            let cell : MainInfoTableViewCell = tableView.dequeueReusableCell(withIdentifier: MainInfoTableViewCell.cellIdentifier()) as! MainInfoTableViewCell
            let info = presenter.mainInfo(by: indexPath.row)
            cell.setInfo(title: info.title, value: info.value)
            return cell;
        default:
            return UITableViewCell()
        }
    }
}


