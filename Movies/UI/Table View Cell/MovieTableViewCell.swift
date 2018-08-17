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
        setup()
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        return nil
    }
    
    func setup()
    {
        movieTitleLabel.text            = movie.titleAndReleaseYear
        movieOverviewTextView.text      = movie.overview
        
        movieTitleLabel.font            = UIFont.preferredFont(forTextStyle: .headline)
        movieOverviewTextView.font      = UIFont.preferredFont(forTextStyle: .body)
        
        movieTitleLabel.textColor       = UIColor.black
        movieOverviewTextView.textColor = UIColor.black
        
        movieOverviewTextView.isScrollEnabled = false
        movieTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        movieOverviewTextView.translatesAutoresizingMaskIntoConstraints = false
        posterImageView.translatesAutoresizingMaskIntoConstraints = false
        
        movieTitleLabel.numberOfLines = 0
        
        movieOverviewTextView.contentMode = .topLeft
        movieOverviewTextView.isEditable = false
        
        posterImageView.image = UIImage(named: "Placeholder")
        
        contentView.addSubview(movieTitleLabel)
        contentView.addSubview(movieOverviewTextView)
        contentView.addSubview(posterImageView)
    }
    
    func update()
    {
        movieTitleLabel.text        = movie.titleAndReleaseYear
        movieOverviewTextView.text  = movie.overview
    }
    
    func update(image: UIImage)
    {
        hasAppliedConstraints = false
        posterImageView.image = image
        posterImageView.setNeedsDisplay()
    
        self.layoutIfNeeded()
    }
    
    override func layoutIfNeeded()
    {
        super.layoutIfNeeded()
        
        self.updateConstraints()
    }
    
    
    override func updateConstraints()
    {
        if hasAppliedConstraints { return }
        
        var contentViewConstraints: [NSLayoutConstraint] = []
        
        contentViewConstraints.append(posterImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5))
        contentViewConstraints.append(posterImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5))
        contentViewConstraints.append(posterImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8))
        contentViewConstraints.append(posterImageView.widthAnchor.constraint(equalToConstant: 135))
        
        contentViewConstraints.append(movieTitleLabel.leadingAnchor.constraint(equalTo: posterImageView.trailingAnchor, constant: 5))
        contentViewConstraints.append(movieTitleLabel.topAnchor.constraint(equalTo: posterImageView.topAnchor))
        contentViewConstraints.append(movieTitleLabel.trailingAnchor.constraint(lessThanOrEqualTo: contentView.trailingAnchor, constant: -5))
        
        contentViewConstraints.append(movieOverviewTextView.leadingAnchor.constraint(equalTo: movieTitleLabel.leadingAnchor, constant: -5))
        contentViewConstraints.append(movieOverviewTextView.topAnchor.constraint(greaterThanOrEqualTo: movieTitleLabel.bottomAnchor, constant: 8))
        contentViewConstraints.append(movieOverviewTextView.bottomAnchor.constraint(lessThanOrEqualTo: posterImageView.bottomAnchor))
        contentViewConstraints.append(movieOverviewTextView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5))
        
        NSLayoutConstraint.activate(contentViewConstraints)
        
        hasAppliedConstraints = true
        
        super.updateConstraints()
    }
}
