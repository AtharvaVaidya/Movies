//
//  UIViewController+Extensions.swift
//  Movies
//
//  Created by Atharva Vaidya on 17/08/2018.
//  Copyright © 2018 Atharva vaidya. All rights reserved.
//

import UIKit

extension UIViewController
{
    func presentNotification(text: String, subText: String)
    {
        let alert = UIAlertController(title: text, message: subText, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { (action) in
            alert.dismiss(animated: true, completion: nil)
        }
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    @objc func showLoadingIndicator()
    {
        DispatchQueue.main.async
        {
            let superview: UIView = self.view.superview ?? self.view
            
            let activityIndicator = Factory.makeActivityIndicator(for: superview)
            
            superview.addSubview(activityIndicator)
            superview.bringSubview(toFront: activityIndicator)
            activityIndicator.startAnimating()
        }
    }
    
    @objc func hideLoadingIndicator()
    {
        DispatchQueue.main.async
        {
            let superview: UIView = self.view.superview ?? self.view
            
            if let activityIndicator = superview.viewWithTag(-1001) as? UIActivityIndicatorView
            {
                activityIndicator.stopAnimating()
                activityIndicator.removeFromSuperview()
            }
        }
    }
}
