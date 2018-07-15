//
//  Constants.swift
//  Movies
//
//  Created by Atharva Vaidya on 14/07/18.
//  Copyright © 2018 Atharva vaidya. All rights reserved.
//

import UIKit

public struct Constants
{
    static let APIKey: String = "2696829a81b1b5827d515ff121700838"
    
    static let postersCache: NSCache<NSString, UIImage> =
    {
        let cache = NSCache<NSString, UIImage>()
        cache.name = "Posters Cache"
        return cache
    }()
    
    private init() {}
}
