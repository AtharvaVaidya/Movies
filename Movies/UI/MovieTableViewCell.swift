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
    
    var movie: Movie
    {
        didSet
        {
            update()
        }
    }
    
    private var hasAppliedConstraints: Bool = false
    
    init(movie: Movie)
    {
        self.movie = movie

        super.init(style: .default, reuseIdentifier: MovieTableViewCell.identifier)
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        return nil
    }
    
    func setup()
    {
        
    }
    
    func update()
    {
        
    }
    
    override func updateConstraints()
    {
        if hasAppliedConstraints { return }
        
        var contentViewConstraints: [NSLayoutConstraint] = []
        
        contentViewConstraints.append(posterImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5))
        contentViewConstraints.append(posterImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 5))
        contentViewConstraints.append(posterImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8))
        contentViewConstraints.append(posterImageView.widthAnchor.constraint(equalToConstant: 135))
        
        contentViewConstraints.append(movieTitleLabel.leadingAnchor.constraint(equalTo: posterImageView.trailingAnchor, constant: 5))
        contentViewConstraints.append(movieTitleLabel.topAnchor.constraint(equalTo: posterImageView.topAnchor, constant: 5))
        contentViewConstraints.append(movieTitleLabel.trailingAnchor.constraint(lessThanOrEqualTo: contentView.trailingAnchor, constant: 5))
        
        contentViewConstraints.append(releaseDateLabel.topAnchor.constraint(equalTo: movieTitleLabel.bottomAnchor, constant: 5))
        contentViewConstraints.append(releaseDateLabel.leadingAnchor.constraint(equalTo: movieTitleLabel.leadingAnchor))
        
        contentViewConstraints.append(movieOverviewTextView.leadingAnchor.constraint(equalTo: movieTitleLabel.leadingAnchor))
        contentViewConstraints.append(movieOverviewTextView.topAnchor.constraint(equalTo: releaseDateLabel.bottomAnchor, constant: 15))
        contentViewConstraints.append(movieOverviewTextView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 5))
        
        NSLayoutConstraint.activate(contentViewConstraints)
        
        super.updateConstraints()
    }
}
