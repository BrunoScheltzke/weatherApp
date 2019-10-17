//
//  TemperatureView.swift
//  WeatherApp
//
//  Created by Bruno Scheltzke on 17/10/19.
//  Copyright © 2019 Bruno Scheltzke. All rights reserved.
//

import UIKit

class TemperatureView: UIView {
    
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var temperatureLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    init() {
        super.init(frame: .zero)
        commonInit()
    }
    
    func commonInit() {
        Bundle.main.loadNibNamed("TemperatureView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        
        contentView.layer.cornerRadius = 3
    }
    
}
