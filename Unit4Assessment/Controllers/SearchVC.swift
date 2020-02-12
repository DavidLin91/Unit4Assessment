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
    
    public var dataPersistence: DataPersistence<Cards>!
    
    private var flashCards = [Cards]() {
        didSet {
            DispatchQueue.main.async {
                self.searchView.collectionView.reloadData()
            }
        }
    }
    
    override func loadView() {
        view = searchView
    }
    
    override func viewWillLayoutSubviews() {
        self.navigationItem.title = "Search Flash Cards"
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
        guard let fileURL = Bundle.main.url(forResource: "FlashCards", withExtension: "json") else {
            fatalError()
        }
        do {
            let data = try Data(contentsOf: fileURL)
            let cardData = Cards.getCards(from: data)
            flashCards = cardData
        } catch {
            print("error loading json data")
        }
    }
    
    
    
}

extension SearchVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return flashCards.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "searchCell", for: indexPath) as? SearchCell else {
            fatalError("could not downcast to NewsCell")
        }
        let flashCard = flashCards[indexPath.row]
        cell.backgroundColor = .white
        cell.delegate = self
        cell.cards = flashCard
        cell.configureCell(for: flashCard)
        return cell
    }
}

extension SearchVC: SaveFlashCardDelegate {
    func didSave(thisCard: Cards) {
        if dataPersistence.hasItemBeenSaved(thisCard) {
            return
        }
        do {
            try dataPersistence.createItem(thisCard)
        } catch {
            print("could not save due to \(error)")
        }
    }
}


extension SearchVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let maxSize: CGSize = UIScreen.main.bounds.size   // create a constant for the max size of screen
        let itemWidth: CGFloat = maxSize.width * 0.80
        let itemHeight: CGFloat = maxSize.height * 0.30 // ~30% of screen
        return CGSize(width: itemWidth, height: itemHeight)
    }
    
    func scrollViewDidScroll(_scrollView: UIScrollView) {
        if searchView.searchBar.isFirstResponder {
            searchView.searchBar.resignFirstResponder()
        }
    }
}



extension SearchVC: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar)  {
        searchBar.resignFirstResponder()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard !searchText.isEmpty else {
            loadFlashCards()
            return
        }
        flashCards = flashCards.filter {$0.quizTitle.lowercased().contains(searchText.lowercased())}
    }
}




