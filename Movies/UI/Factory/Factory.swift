//
//  Factory.swift
//  Movies
//
//  Created by Atharva Vaidya on 14/07/18.
//  Copyright © 2018 Atharva vaidya. All rights reserved.
//

import UIKit

/// Struct to act as the container for all factories
struct Factory
{
    private init() {}
    
    static func makeActivityIndicator(for view: UIView) -> UIActivityIndicatorView
    {
        let activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.whiteLarge)
        activityIndicator.backgroundColor = UIColor(white: 0.1, alpha: 0.4)
        activityIndicator.tag = -1001
        activityIndicator.frame = CGRect(x: 0, y: 0, width: 80, height: 80)
        activityIndicator.center = view.center
        activityIndicator.color = .white
        activityIndicator.layer.cornerRadius = 20
        return activityIndicator
    }
}
