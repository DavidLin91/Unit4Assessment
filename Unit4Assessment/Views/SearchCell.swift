//
//  SearchCell.swift
//  Unit4Assessment
//
//  Created by David Lin on 2/11/20.
//  Copyright © 2020 Alex Paul. All rights reserved.
//

import UIKit

class SearchCell: UICollectionViewCell {
    
    
    private lazy var flashCardQuestion: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont .preferredFont(forTextStyle: .subheadline)
        label.text = "FlashCardQuestion"
        label.textColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
        return label
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder:coder)
        commonInit()
    }
    
    
    private func commonInit() {
        setupFlashCardQuestionConstraints()
    }
    
    
    private func setupFlashCardQuestionConstraints() {
        addSubview(flashCardQuestion)
        flashCardQuestion.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            flashCardQuestion.centerXAnchor.constraint(equalTo: centerXAnchor),
            flashCardQuestion.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
    
    
    public func configureCell(for flashCard: Card) {
        flashCardQuestion.text = flashCard.cardTitle
    }
    
    
}
