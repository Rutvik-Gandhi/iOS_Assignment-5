//
//  ImageCollViewCell.swift
//  Assignment 5
//
//  Created by Assignment 5 on 23/11/22.
//

import UIKit


class ImageCollViewCell: UICollectionViewCell {
    
    //MARK: - Outlets -
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    @IBOutlet weak var imgView: UIImageView!
    
    //Loading an image in imageview
    var objIimage: Photo? {
        didSet {
            indicator.startAnimating()
            let url = URL(string: objIimage?.imageURL ?? "")!
            imgView.kf.setImage(with: url) { result in
                self.indicator.stopAnimating()
               switch result {
               case .success(let value):
                   print("Image: \(value.image). Got from: \(value.cacheType)")
               case .failure(let error):
                   print("Error: \(error)")
               }
             }
            
        }
    }
    
    
    
    override func awakeFromNib() {
        layer.borderColor = UIColor.gray.cgColor
        layer.borderWidth = 1.0
        layer.cornerRadius = 5.0
    }
}
