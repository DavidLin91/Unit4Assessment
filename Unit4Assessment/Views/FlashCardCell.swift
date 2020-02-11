//
//  FlashCardCell.swift
//  Unit4Assessment
//
//  Created by David Lin on 2/11/20.
//  Copyright © 2020 Alex Paul. All rights reserved.
//

import UIKit

class FlashCardCell: UICollectionViewCell {
    
    private var currentScreen: Card!
    
    private var isShowingAnswer = false
    
    private lazy var longPressedGesture: UILongPressGestureRecognizer = {
        let gesture = UILongPressGestureRecognizer()
        gesture.addTarget(self, action: #selector(didLongPress(_:)))
        return gesture
    }()
    
    private lazy var flashCardQuestion: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont .preferredFont(forTextStyle: .subheadline)
        label.text = "FlashCardQuestion"
        label.textColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
        return label
    }()
    
    private lazy var flashCardAnswer: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont .preferredFont(forTextStyle: .subheadline)
        label.text = "FlashCardAnswer"
        return label
    }()
    
    public lazy var editButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "ellipsis"), for: .normal)
        
        // add target is needed to execute function.. when person clicks taget (cell, the moreButtonPressed func gets called)
        button.addTarget(self, action: #selector(editButtonPressed(_sender:)), for: .touchUpInside)
        return button
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
        setupEditButtonConstraints()
        setupFlashCardQuestionConstraints()
        setupFlashCardAnswerConstraints()
    }
    
    @objc private func didLongPress(_ gesture: UILongPressGestureRecognizer) {
        guard let currentScreen = currentScreen else { return }
        if gesture.state == .began || gesture.state == .changed {
            print("long pressed")
            return
        }
    }
    
    @objc private func editButtonPressed(_sender: UIButton) {
        // Step 3: custom protocl (step 4: savedArticleVC, set the info in the cellForItemAt)
        // captures the data for the specific cell its cli
    }
    
    
    private func setupEditButtonConstraints() {
        addSubview(editButton)
        editButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            editButton.topAnchor.constraint(equalTo: topAnchor),
            editButton.trailingAnchor.constraint(equalTo: trailingAnchor),
            editButton.heightAnchor.constraint(equalToConstant: 44),
            editButton.widthAnchor.constraint(equalTo: editButton.heightAnchor)
        ])
    }
    
    private func setupFlashCardQuestionConstraints() {
        addSubview(flashCardQuestion)
        flashCardQuestion.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            flashCardQuestion.centerXAnchor.constraint(equalTo: centerXAnchor),
            flashCardQuestion.centerYAnchor.constraint(equalTo: centerYAnchor),
            flashCardQuestion.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            flashCardQuestion.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10)
        ])
    }
    
    private func setupFlashCardAnswerConstraints() {
        addSubview(flashCardAnswer)
        flashCardAnswer.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            flashCardAnswer.centerXAnchor.constraint(equalTo: centerXAnchor),
            flashCardAnswer.centerYAnchor.constraint(equalTo: centerYAnchor),
            flashCardAnswer.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            flashCardAnswer.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10)
        ])
    }
    
    
    
    
}
