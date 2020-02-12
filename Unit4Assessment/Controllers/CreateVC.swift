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
    func didSave(thisCard: Cards)
}


class CreateVC: UIViewController {
    
    private let createView = CreateView()
    
    public var dataPersistence: DataPersistence<Cards>!
    
    weak var delegate: SaveFlashCardDelegate?
    
    var cards: Cards!
    
    
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
        createView.questionTextField.delegate = self
        createView.answerTextViewOne.delegate = self
        createView.answerTextViewTwo.delegate = self
    }
    
    func saveFlashCard() {
           cards = Cards(quizTitle: createView.questionTextField.text!, facts: [createView.answerTextViewOne.text!, createView.answerTextViewTwo.text!])
           do {
               try dataPersistence.createItem(cards)
           } catch {
               print("saving error: \(error)")
           }

       }
       
       func clearTextFields() {
           createView.questionTextField.text = nil
           createView.answerTextViewOne.text = nil
           createView.answerTextViewTwo.text = nil
       }

    
        func emptyAlert(){
            let showAlert = UIAlertController(title: "Failed", message: "Please enter all fields", preferredStyle: .alert)
            showAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(showAlert, animated: true, completion: nil)
        }
    
        func successAlert(){
            let showAlert = UIAlertController(title: "Success", message: "Flash card has been added to your deck!", preferredStyle: .alert)
            showAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(showAlert, animated: true, completion: nil)
        }
    
    @objc func buttonPressed(_ sender: UIBarButtonItem){
        if createView.questionTextField.text!.isEmpty || createView.answerTextViewOne.text!.isEmpty || createView.answerTextViewTwo.text!.isEmpty {
        emptyAlert()
        } else {
            saveFlashCard()
            clearTextFields()
            successAlert()
        }
    }
    
}




extension CreateVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

extension CreateVC: UITextViewDelegate {
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == "\n" {
            textView.resignFirstResponder()
            return false
        }
        return true
    }
}
