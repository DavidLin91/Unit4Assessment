//
//  CreateView.swift
//  Unit4Assessment
//
//  Created by David Lin on 2/11/20.
//  Copyright © 2020 Alex Paul. All rights reserved.
//

import UIKit

class CreateView: UIView {
    
    public lazy var questionTextField: UITextField = {
        let tf = UITextField()
        tf.backgroundColor = .white
        tf.placeholder = " enter question"
        tf.layer.cornerRadius = 5.0
        return tf
    }()
    
    public lazy var answerTextViewOne: UITextView = {
        let tv = UITextView()
        tv.backgroundColor = .white
        tv.layer.cornerRadius = 5.0
        return tv
    }()
    
    public lazy var answerTextViewTwo: UITextView = {
        let tv = UITextView()
        tv.backgroundColor = .white
        tv.layer.cornerRadius = 5.0
        return tv
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
        setupQuestionTextFieldConstraint()
        setupAnswerTextViewOneConstraint()
        setupAnswerTextViewTwoConstraint()
    }

    
    
    
    
    private func setupQuestionTextFieldConstraint() {
        addSubview(questionTextField)
        questionTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            questionTextField.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20),
            questionTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            questionTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            questionTextField.heightAnchor.constraint(equalToConstant: 40)
        
        ])
    }
    
    private func setupAnswerTextViewOneConstraint() {
        addSubview(answerTextViewOne)
        answerTextViewOne.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            answerTextViewOne.topAnchor.constraint(equalTo: questionTextField.bottomAnchor, constant: 20),
            answerTextViewOne.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            answerTextViewOne.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            answerTextViewOne.heightAnchor.constraint(equalToConstant: 120)
        
        ])
    }
    
    private func setupAnswerTextViewTwoConstraint() {
        addSubview(answerTextViewTwo)
        answerTextViewTwo.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            answerTextViewTwo.topAnchor.constraint(equalTo: answerTextViewOne.bottomAnchor, constant: 20),
            answerTextViewTwo.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            answerTextViewTwo.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            answerTextViewTwo.heightAnchor.constraint(equalToConstant: 120)
        ])
    }
    
    
    
}


