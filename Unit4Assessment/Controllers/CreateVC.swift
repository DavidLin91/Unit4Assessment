//
//  CreateVC.swift
//  Unit4Assessment
//
//  Created by David Lin on 2/11/20.
//  Copyright © 2020 Alex Paul. All rights reserved.
//

import UIKit
import DataPersistence

protocol  SaveFlashCardDelegate: AnyObject {
    func didSave(thisCard: SavedCards)
}


class CreateVC: UIViewController {
    
    private let createView = CreateView()
    
    public var dataPersistence: DataPersistence<SavedCards>!
    
    weak var delegate: SaveFlashCardDelegate?
    
    var flashcard: SavedCards!
    
    
    override func loadView() {
        view = createView
    }
    
    override func viewWillLayoutSubviews() {
        self.navigationItem.title = "Create Quiz"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.5094134212, green: 0.7622374296, blue: 1, alpha: 1)
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Create", style: .plain, target: self, action: #selector(buttonPressed(_:)))
        navigationItem.rightBarButtonItem?.tintColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
     // need to figure a way to enable when pressed
        //   navigationItem.rightBarButtonItem?.isEnabled = false
        
    }
    
    
    
    
    
    @objc func buttonPressed(_ sender: UIBarButtonItem){
          saveFlashCard()
       }
    
    func saveFlashCard() {
        flashcard = SavedCards(cardTitle: createView.questionTextField.text ?? "", factOne: createView.answerTextViewOne.text ?? "", factTwo: createView.answerTextViewTwo.text ?? "")
        delegate?.didSave(thisCard: flashcard)
        do {
            try dataPersistence.createItem(flashcard)
        } catch {
            print("saving error: (error)")
        }
        
    }
    
    
}
