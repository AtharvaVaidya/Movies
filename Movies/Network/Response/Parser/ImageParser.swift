//
//  ImageParser.swift
//  Movies
//
//  Created by Atharva Vaidya on 14/07/18.
//  Copyright © 2018 Atharva vaidya. All rights reserved.
//

import UIKit

public class ImageParser: Parser<UIImage>
{
    override public func parse(data: Data) throws -> UIImage
    {
        guard let image = UIImage(data: data)
        else
        {
            throw NetworkError.failedToParseImageData(data)
        }
        return image
    }
}
