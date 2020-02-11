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
    
    private var flashCards = [Card]() {
        didSet {
            DispatchQueue.main.async {
                self.flashCardsView.collectionView.reloadData()
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
        
    }
    
}

extension FlashCardsVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "flashCardCell", for: indexPath) as? FlashCardCell else {
            fatalError("could not downcast to NewsCell")
        }
        cell.backgroundColor = .white
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
