//
//  RoundedButton.swift
//  Survey
//
//  Created by Marko Rankovic on 1/22/18.
//  Copyright © 2018 marko.rankovic. All rights reserved.
//

import UIKit

class RoundedButton: UIButton {

    override func layoutSubviews() {
        super.layoutSubviews()
        
        layer.cornerRadius = 8
    }
}
