//
//  PictureCollectionViewCell.swift
//  picturesflow8
//
//  Created by Егор Горских on 18.03.2021.
//

import UIKit
import SDWebImage

class RandomPicuresCell: UICollectionViewCell {
    
    static let reuseId = "PicturesCell"
    
    let picturesImageView: UIImageView = {
       let imageView = UIImageView()
       imageView.translatesAutoresizingMaskIntoConstraints = false
       imageView.backgroundColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
       imageView.contentMode = .scaleAspectFill
       return imageView
   }()
    
    private let checkmark: UIImageView = {
        let image = UIImage(systemName: "checkmark")
        let imageView = UIImageView(image: image)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.alpha = 0
        return imageView
    }()
    
    var unsplashPhoto: RandomPicturesResponse! {
        didSet {
            let photoUrl = unsplashPhoto.urls["regular"] // full raw regular
            
            guard let imageUrl = photoUrl, let url = URL(string: imageUrl) else { return }
            
            picturesImageView.sd_setImage(with: url, completed: nil)
        }
    }
    
    override var isSelected: Bool {
        didSet {
            updateSelectedState()
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        picturesImageView.image = nil
    }
    
    // MARK: - Life Cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        updateSelectedState()
        setupImageView()
        setupCheckmarkView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Privet method
    
    private func updateSelectedState() {
        picturesImageView.alpha = isSelected ? 0.7 : 1
        checkmark.alpha = isSelected ? 1 : 0
    }
    
    private func setupImageView() {
        addSubview(picturesImageView)
        
        NSLayoutConstraint.activate([
            picturesImageView.topAnchor.constraint(equalTo: self.topAnchor),
            picturesImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            picturesImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            picturesImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
    
    private func setupCheckmarkView() {
        addSubview(checkmark)
        NSLayoutConstraint.activate([
            checkmark.trailingAnchor.constraint(equalTo: picturesImageView.trailingAnchor, constant: -8),
            checkmark.bottomAnchor.constraint(equalTo: picturesImageView.bottomAnchor, constant: -8)
        ])
    }
        
}

