//
//  SearchVC.swift
//  Unit4Assessment
//
//  Created by David Lin on 2/11/20.
//  Copyright © 2020 Alex Paul. All rights reserved.
//

import UIKit
import DataPersistence

class SearchVC: UIViewController {
    
    private let searchView = SearchView()
    
    
    private var flashCards = [Card]() {
        didSet {
            DispatchQueue.main.async {
                self.searchView.collectionView.reloadData()
            }
        }
    }
    
    override func loadView() {
        view = searchView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        searchView.collectionView.delegate = self
        
        searchView.collectionView.dataSource = self
        searchView.collectionView.register(SearchCell.self, forCellWithReuseIdentifier: "searchCell")
        searchView.searchBar.delegate = self
        loadFlashCards()
    }
    
    
    private func loadFlashCards() {
        FlashCardsAPIClient.fetchFlashCards { [weak self] (result) in
            switch result {
            case .failure(let appError):
                print("Could not fetch flashCards \(appError)")
            case .success(let flashCards):
                self?.flashCards = flashCards
            }
        }
    }
    
    
    
}

extension SearchVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print(flashCards.count)
        return flashCards.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "searchCell", for: indexPath) as? SearchCell else {
            fatalError("could not downcast to NewsCell")
        }
        let flashCard = flashCards[indexPath.row]
        cell.backgroundColor = .white
        cell.configureCell(for: flashCard)
        return cell
    }
}



extension SearchVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let maxSize: CGSize = UIScreen.main.bounds.size   // create a constant for the max size of screen
        let itemWidth: CGFloat = maxSize.width * 0.80
        let itemHeight: CGFloat = maxSize.height * 0.30 // ~30% of screen
        return CGSize(width: itemWidth, height: itemHeight)
    }
}



extension SearchVC: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard !searchText.isEmpty else {
            // if text is empty, reload all flash cards
            return
        }
        // filter cards based on searchText
    }
}


