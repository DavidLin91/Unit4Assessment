//
//  SearchCell.swift
//  Unit4Assessment
//
//  Created by David Lin on 2/11/20.
//  Copyright © 2020 Alex Paul. All rights reserved.
//

import UIKit
import DataPersistence


class SearchCell: UICollectionViewCell {
    
    weak var delegate: SaveFlashCardDelegate?
    
    public var dataPersistence: DataPersistence<Cards>!
    
    public var cards: Cards!
    
    private var isShowingAnswer = false
    
    let button = UIButton()
    
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
        label.alpha = 1
        label.textColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
        return label
    }()
    
    private lazy var flashCardAnswer: UILabel = {
       let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont .preferredFont(forTextStyle: .subheadline)
        label.text = "FlashCardAnswer"
        label.alpha = 0
        return label
    }()
    
    public lazy var bookmarkButton: UIButton = {
           
           button.setImage(UIImage(systemName: "bookmark"), for: .normal)
           
           // add target is needed to execute function.. when person clicks taget (cell, the moreButtonPressed func gets called)
           button.addTarget(self, action: #selector(saveButtonPressed(_sender:)), for: .touchUpInside)
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
        setupFlashCardQuestionConstraints()
        setupFlashCardAnswerConstraints()
        setupSaveButtonConstraints()
        addGestureRecognizer(longPressedGesture)
    }
    
    // flip animation
   @objc private func didLongPress(_ gesture: UILongPressGestureRecognizer) {
        if gesture.state == .began || gesture.state == .changed {
            return
        }
        isShowingAnswer.toggle()
       // self.flashCardAnswer.text = currentScreen
        self.animate()
    }
    
    
    private func animate() {
        let duration: Double = 1.0 // seconds
        if isShowingAnswer {
            UIView.transition(with: self, duration: duration, options: [.transitionFlipFromRight], animations: {
                self.flashCardAnswer.alpha = 1.0
                self.flashCardQuestion.alpha = 0.0
            }, completion: nil)
        } else {
            UIView.transition(with: self, duration: duration, options: [.transitionFlipFromLeft], animations: {
                self.flashCardAnswer.alpha = 0.0
                self.flashCardQuestion.alpha = 1.0
            }, completion: nil)
        }
    }
    
    // Bookmark Button
    @objc private func saveButtonPressed(_sender: UIButton) {
        // Step 3: custom protocl
        if let card = cards {
        delegate?.didSave(thisCard: card)
        }
        changeBookmarkImage()
        print("bookmark button pressed")
    }
    
    func changeBookmarkImage(){
         button.setImage(UIImage(systemName: "bookmark.fill"), for: .normal)
        bookmarkButton.isEnabled = false
    }

    
    private func setupSaveButtonConstraints() {
        addSubview(bookmarkButton)
        bookmarkButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            bookmarkButton.topAnchor.constraint(equalTo: topAnchor),
            bookmarkButton.trailingAnchor.constraint(equalTo: trailingAnchor),
            bookmarkButton.heightAnchor.constraint(equalToConstant: 44),
            bookmarkButton.widthAnchor.constraint(equalTo: bookmarkButton.heightAnchor)
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
    
    
    public func configureCell(for flashCard: Cards) {
        flashCardQuestion.text = flashCard.quizTitle
        flashCardAnswer.text = """
                                Fact 1:
                                \(flashCard.facts.first!)
                                Fact 2:
                                \(flashCard.facts.last!)
                               """
    }
    
    
}
