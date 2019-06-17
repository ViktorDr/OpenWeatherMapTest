//
//  CityWeatherPresenter.swift
//  OpenWeatherMap
//
//  Created by Viktor Drykin on 13.03.2018.
//  Copyright © 2018 Viktor Drykin. All rights reserved.
//

import Foundation
import UIKit

enum CityWeatherSection : Int {
    case weather = 0
    case mainInformation = 1
}

protocol CityWeatherViewPresenter : class {
    init(withView view: CityWeatherViewProtocol)
    func downloadWeatherInformation(cityId : Int)
    func numberOfSections() -> Int
    func numberOfRowsInSection(section : Int) -> Int
    func rowHeight(section : Int, row : Int) -> CGFloat?
    func mapParameters() -> (lat : Double, lng : Double, visibility : Int)
    func weatherMainInformation() -> (main : String?, description : String?, imageAddress : String)
    func mainInfo(by row : Int) -> (title : String, value : String)

}

class CityWeatherPresenter : CityWeatherViewPresenter {
    
    let unknownInfo = "?"
    let weatherMainInfoTitles = ["Temperature", "Pressure", "Humidity", "Minimal t", "Maximum t"]
    
    weak var view: CityWeatherViewProtocol?
    var cityWeather: CityWeather?
    var weatherMainInfoValues: [String]
    
    required init(withView view: CityWeatherViewProtocol)  {
        self.view = view
        weatherMainInfoValues = Array(repeating: unknownInfo, count: weatherMainInfoTitles.count)
    }
    
    func downloadWeatherInformation(cityId : Int) {
        view?.showProgressHUD()
        APIClient.shared.start(connection: CityWeatherConnection(cityId: cityId), successHandler: { [weak self] result in
            self?.cityWeather = result
            self?.prepareMainInfoValues()
            self?.view?.updateNavigationBar(cityName: self?.cityWeather?.name ?? "", date: self?.cityWeather?.date)
            self?.view?.updateView()
            self?.view?.hideProgressHUD()
        }, failureHandler: { [weak self] error in
            self?.view?.showError(text: error.localizedDescription)
            self?.view?.hideProgressHUD()
        })
    }
    
    func numberOfSections() -> Int {
        return cityWeather != nil ? 2 : 0
    }
    
    func prepareMainInfoValues() {
        weatherMainInfoValues.removeAll()
        weatherMainInfoValues.append(value(of: cityWeather?.mainInfo?.temperature))
        weatherMainInfoValues.append(value(of: cityWeather?.mainInfo?.pressure))
        weatherMainInfoValues.append(value(of: cityWeather?.mainInfo?.humidity))
        weatherMainInfoValues.append(value(of: cityWeather?.mainInfo?.minimalTemperature))
        weatherMainInfoValues.append(value(of: cityWeather?.mainInfo?.maximumTemperature))
    }
    
    func value<T> (of value: T?) -> String {
        if let realValue = value {
            return "\(realValue)"
        } else {
            return unknownInfo
        }
    }
    
    func numberOfRowsInSection(section: Int) -> Int {
        guard cityWeather != nil else {
            return 0
        }
        switch section {
        case CityWeatherSection.weather.rawValue:
            return 1
        case CityWeatherSection.mainInformation.rawValue:
            return weatherMainInfoTitles.count
        default:
            return 0
        }
    }
    
    func rowHeight(section : Int, row : Int) -> CGFloat? {
        switch section {
        case CityWeatherSection.weather.rawValue:
            return 60
        case CityWeatherSection.mainInformation.rawValue:
            return 40
        default:
            return 0
        }
    }
    
    let defaultVisibility = 10000
    
    func mapParameters() -> (lat : Double, lng : Double, visibility : Int) {
        let latitude = cityWeather?.coordinate?.latitude ?? 0
        let longitude = cityWeather?.coordinate?.longitude ?? 0
        let visibility = cityWeather?.visibility ?? defaultVisibility
        return (lat : latitude, lng : longitude, visibility : visibility)
    }
    
    func weatherMainInformation() -> (main : String?, description : String?, imageAddress : String) {
        let weather = cityWeather?.weather?.first
        let main = weather?.main
        let descr = weather?.description
        let iconAddress = APIClient.shared.imageIconPath(by: weather?.icon ?? "")
        return (main : main, description : descr, imageAddress : iconAddress)
    }
    
    func mainInfo(by row : Int) -> (title : String, value : String) {
        return (title : weatherMainInfoTitles[row], value : weatherMainInfoValues[row])
    }
    
}
