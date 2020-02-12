//
//  FlashCardsVC.swift
//  Unit4Assessment
//
//  Created by David Lin on 2/11/20.
//  Copyright © 2020 Alex Paul. All rights reserved.
//

import UIKit
import DataPersistence

class FlashCardsVC: UIViewController {
    
    private let flashCardsView = FlashCardsView()
    
    // step 4: data persistence
    public var dataPersistence: DataPersistence<Cards>!
    
    private var savedFlashCards = [Cards]() {
        didSet {
            flashCardsView.collectionView.reloadData()
            print("There are \(savedFlashCards.count) flash cards")
            if savedFlashCards.isEmpty {
            flashCardsView.collectionView.backgroundView = EmptyView(title: "Saved Flash Cards", message: "You better add some cards to this page and start studying if you want to make that 🍞")
            } else {
                flashCardsView.collectionView.backgroundView = nil
            }
        }
    }
    
    override func loadView() {
        view = flashCardsView
    }
    
    override func viewWillLayoutSubviews() {
        self.navigationItem.title = "Flash Cards"
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.5094134212, green: 0.7622374296, blue: 1, alpha: 1)
        flashCardsView.collectionView.register(FlashCardCell.self, forCellWithReuseIdentifier: "flashCardCell")
        flashCardsView.collectionView.delegate = self
        flashCardsView.collectionView.dataSource = self
        loadSavedFlashCards()
    }
    
    private func loadSavedFlashCards() {
            do {
                savedFlashCards = try dataPersistence.loadItems()
            } catch {
                print("error fetching articles")
            }
        }
   }

extension FlashCardsVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return savedFlashCards.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "flashCardCell", for: indexPath) as? FlashCardCell else {
            fatalError("could not downcast to NewsCell")
        }
        
        let card = savedFlashCards[indexPath.row]
        cell.backgroundColor = .white
        cell.configureCell(for: card)
        cell.currentScreen = card
        cell.delegate = self
        return cell
    }
    
    
}

extension FlashCardsVC:UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let maxSize: CGSize = UIScreen.main.bounds.size   // create a constant for the max size of screen
        let itemWidth: CGFloat = maxSize.width * 0.80  // 80% of screen
        let itemHeight: CGFloat = maxSize.height * 0.30 // ~30% of screen
        return CGSize(width: itemWidth, height: itemHeight)
    }
}


// step 5: data persistence
extension FlashCardsVC: DataPersistenceDelegate {
    func didSaveItem<T>(_ persistenceHelper: DataPersistence<T>, item: T) where T : Decodable, T : Encodable, T : Equatable {
        loadSavedFlashCards()
    }
    
    func didDeleteItem<T>(_ persistenceHelper: DataPersistence<T>, item: T) where T : Decodable, T : Encodable, T : Equatable {
        loadSavedFlashCards()
    }
}


extension FlashCardsVC: FlashCardDelegate {
    func buttonPressed(savedFlashCards: FlashCardCell, card: Cards) {
        
        print("button extension called \(card.quizTitle)")
        
        
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let deleteAction = UIAlertAction(title: "Delete", style: .destructive) { (action) in
            self.deleteCard(card: card)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        alertController.addAction(deleteAction)
        alertController.addAction(cancelAction)
        present(alertController, animated: true)
    }
    private func deleteCard(card: Cards) {
        guard let index = savedFlashCards.firstIndex(of: card) else {
            return
        }
        do {
            try dataPersistence.deleteItem(at: index)
        } catch {
            print("issue deleting card  due to error: \(error)")
        }
    }
}
