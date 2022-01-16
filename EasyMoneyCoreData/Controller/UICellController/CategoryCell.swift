//
//  CategoryCell.swift
//  EasyMoneyCoreData
//
//  Created by 郭勇 on 22/9/20.
//  Copyright © 2020 Yong Guo. All rights reserved.
//

import UIKit

class CategoryCell: UICollectionViewCell {
    // set the 'UILabel' link to the view
    var categoryLabel: UILabel!

    // set category and subcategory for provide data
    var categroy: String!
    var subcategory: String!
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        // set UILabel
        categoryLabel = UILabel()
        
        // set font size and text alignment
        categoryLabel.textAlignment = .center
        categoryLabel.font = UIFont.systemFont(ofSize: 14.0)
        
        self.contentView.addSubview(categoryLabel)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
