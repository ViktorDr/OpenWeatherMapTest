//
//  CityWeatherCell.swift
//  OpenWeatherMap
//
//  Created by Viktor Drykin on 13.03.2018.
//  Copyright © 2018 Viktor Drykin. All rights reserved.
//

import UIKit
import Kingfisher

class CityWeatherCell: BaseTableViewCell {

    @IBOutlet weak var weatherIcon: UIImageView!
    @IBOutlet weak var mainInfo: UILabel!
    @IBOutlet weak var weatherDescription: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setInfo(main : String?, description : String?, imageAddress : String) {
        mainInfo.text = main
        weatherDescription.text = description
        weatherIcon.kf.setImage(with: URL(string: imageAddress))
    }

}
