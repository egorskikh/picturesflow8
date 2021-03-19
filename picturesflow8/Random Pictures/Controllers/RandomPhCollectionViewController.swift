//
//  RandomPhCollectionViewController.swift
//  picturesflow8
//
//  Created by Егор Горских on 18.03.2021.
//

import UIKit

private let reuseIdentifier = "Cell"

class RandomPhCollectionViewController: UICollectionViewController {
    
    private let networkDataFetcher = NetworkDataFetcher()
    private var pictures = [RandomPicturesResponse]()
    private var selectedPictures = [UIImage]()
    
    private let itemsPerRow: CGFloat = 2
    private let sectionInserts = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
    
    // BarButtonItem
    
    private lazy var updatePicturesButtonItem: UIBarButtonItem = {
        return UIBarButtonItem(barButtonSystemItem: .refresh,
                               target: self,
                               action: #selector(updatePicturesTapped))
    }()
    
    private lazy var sharePicturesButtonItem: UIBarButtonItem = {
        return UIBarButtonItem(barButtonSystemItem: .action,
                               target: self,
                               action: #selector(sharePicturesTapped))
    }()
    
    private lazy var savePicturesButtonItem: UIBarButtonItem = {
        return UIBarButtonItem(barButtonSystemItem: .add,
                               target: self,
                               action: #selector(savePicturesTapped))
    }()
    
    private var nuberOfSelectedPictures: Int {
        return collectionView.indexPathsForSelectedItems?.count ?? 0
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateNavigateBarState()
        setupCollectionView()
        setupNavigationBarItem()
        
    }
    
    private func updateNavigateBarState() {
        sharePicturesButtonItem.isEnabled = nuberOfSelectedPictures > 0
        savePicturesButtonItem.isEnabled = nuberOfSelectedPictures > 0
    }
    
    func refresh() {
        self.selectedPictures.removeAll()
        self.collectionView.selectItem(at: nil, animated: true, scrollPosition: [])
        
        updateNavigateBarState()
    }
    
    // MARK: - Navigation Item Action
    
    @objc private func updatePicturesTapped() {
        print(#function)
        
        networkDataFetcher.fetchImage() { randomResults in
            self.pictures = randomResults
            self.collectionView.reloadData()
            self.refresh()
        }
    }
    
    @objc private func sharePicturesTapped(sender: UIBarButtonItem) {
        print(#function)
        
        let shareController = UIActivityViewController(activityItems: selectedPictures, applicationActivities: nil)
        shareController.completionWithItemsHandler = { _, bool, _, _ in
            if bool {
                self.refresh()
            }
        }
        shareController.popoverPresentationController?.barButtonItem = sender
        shareController.popoverPresentationController?.permittedArrowDirections = .any
        present(shareController, animated: true, completion: nil)
    }
    
    @objc private func savePicturesTapped() {
        print(#function)
        
        // ... save in app
    }
    
    // MARK: - Setup Elements
    
    private func setupCollectionView() {
        collectionView.backgroundColor = #colorLiteral(red: 1, green: 0.5194444919, blue: 0.8712037218, alpha: 0.8308427253)
        
        collectionView.register(RandomPicuresCell.self, forCellWithReuseIdentifier: RandomPicuresCell.reuseId)
        
        collectionView.layoutMargins = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        collectionView.contentInsetAdjustmentBehavior = .automatic
        collectionView.allowsMultipleSelection = true
    }
    
    private func setupNavigationBarItem() {
        
        let title = UILabel()
        title.text = "picturesflow8"
        title.font = UIFont.systemFont(ofSize: 13, weight: .light)
        
        navigationItem.leftBarButtonItem = UIBarButtonItem.init(customView: title)
        
        navigationItem.rightBarButtonItems = [
            updatePicturesButtonItem,
            sharePicturesButtonItem,
            savePicturesButtonItem
        ]
        
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using [segue destinationViewController].
     // Pass the selected object to the new view controller.
     }
     */
    
    // MARK: UICollectionViewDataSource
    
    //    override func numberOfSections(in collectionView: UICollectionView) -> Int {
    //        // #warning Incomplete implementation, return the number of sections
    //        return 0
    //    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return pictures.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RandomPicuresCell.reuseId, for: indexPath) as! RandomPicuresCell
        let unpashPhoto = pictures[indexPath.item]
        cell.unsplashPhoto = unpashPhoto
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        updateNavigateBarState()
        let cell = collectionView.cellForItem(at: indexPath) as! RandomPicuresCell
        guard let image = cell.picturesImageView.image else { return }
        selectedPictures.append(image)
    }
    
    override func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        updateNavigateBarState()
        let cell = collectionView.cellForItem(at: indexPath) as! RandomPicuresCell
        guard let image = cell.picturesImageView.image else { return }
        if let index = selectedPictures.firstIndex(of: image) {
            selectedPictures.remove(at: index)
        }
    }
    
    
    // MARK: - UICollectionViewDelegate
    
    /*
     // Uncomment this method to specify if the specified item should be highlighted during tracking
     override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
     return true
     }
     */
    
    /*
     // Uncomment this method to specify if the specified item should be selected
     override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
     return true
     }
     */
    
    /*
     // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
     override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
     return false
     }
     
     override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
     return false
     }
     
     override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
     
     }
     */
    
    
}

// MARK: - UICollectionViewDelegateFlowLayout

extension RandomPhCollectionViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let picture = pictures[indexPath.item]
        
        let paddingSpace = sectionInserts.left * (itemsPerRow + 1)
        let availableWidth = view.frame.width - paddingSpace
        let widthPerItem = availableWidth / itemsPerRow
        let hiegth = CGFloat(picture.height) * widthPerItem / CGFloat(picture.width)
        return CGSize(width: widthPerItem, height: hiegth)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return sectionInserts
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInserts.left
    }
}
