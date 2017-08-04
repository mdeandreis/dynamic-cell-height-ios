//
//  MyCell.swift
//  TableViewTest
//
//  Created by Martin on 7/31/17.
//  Copyright © 2017 Martin. All rights reserved.
//

import UIKit

protocol MyCellDelegate {
    func handleReadMore(articleData: CellArticleData)
}

class MyCell: UITableViewCell {
    
    @IBOutlet weak var topConstraint: NSLayoutConstraint!
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var heightConstraint: NSLayoutConstraint!
    @IBOutlet weak var readMoreLabel: UILabel!
    @IBOutlet weak var readMoreImageView: UIImageView!
    @IBOutlet weak var shareLabel: UILabel!
    @IBOutlet weak var shareImageView: UIImageView!
    @IBOutlet weak var favoriteLabel: UILabel!
    @IBOutlet weak var favoriteImageView: UIImageView!
    @IBOutlet weak var borderView: UIView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    var delegate: MyCellDelegate?
    var articleData: CellArticleData?
    
    func setup(articleData: CellArticleData) {
        self.articleData = articleData
                
        titleLabel.text = articleData.article.title
        descriptionLabel.text = articleData.article.description
        
        addReadMoreTap()
        addShadow()
        updateCellConstraints()
    }
    
    fileprivate func addReadMoreTap() {
        readMoreLabel.isUserInteractionEnabled = true
        let readMoreTap = UITapGestureRecognizer(target: self, action: #selector(handleReadMore))
        readMoreTap.cancelsTouchesInView = false
        readMoreLabel.addGestureRecognizer(readMoreTap)
    }
    
    fileprivate func updateCellConstraints() {
        if let articleData = self.articleData {
            if !articleData.isExpanded {
                heightConstraint.priority = 999
                topConstraint.priority = 250
                bottomConstraint.priority = 250
            }else {
                heightConstraint.priority = 250
                topConstraint.priority = 999
                bottomConstraint.priority = 999
            }
        }
    }
    
    fileprivate func addShadow() {
        borderView.backgroundColor = UIColor.white
        borderView.layer.cornerRadius = 5.0
        borderView.layer.masksToBounds = false
        borderView.layer.shadowOffset = CGSize(width: 0.0, height: 5.0)
        borderView.layer.shadowColor = UIColor(colorLiteralRed: 194/255, green: 198/255, blue: 220/255, alpha: 1.0).cgColor
        borderView.layer.shadowRadius = 5.0
        borderView.layer.shadowOpacity = 1.0
    }
    
    func handleReadMore() {
        if let articleData = self.articleData {
            articleData.isExpanded = !articleData.isExpanded
            delegate?.handleReadMore(articleData: articleData)
        }
    }
}
