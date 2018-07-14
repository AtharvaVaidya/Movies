//
//  MovieTableViewCell.swift
//  Movies
//
//  Created by Atharva Vaidya on 13/07/18.
//  Copyright © 2018 Atharva vaidya. All rights reserved.
//

import UIKit

class MovieTableViewCell: UITableViewCell
{
    let posterImageView:        UIImageView  = UIImageView()
    let movieTitleLabel:        UILabel      = UILabel()
    let movieOverviewTextView:  UITextView   = UITextView()
    let releaseDateLabel:       UILabel      = UILabel()
    
    init(movie: Movie)
    {
        super.init(style: .default, reuseIdentifier: String(describing: MovieTableViewCell.self))
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool)
    {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
