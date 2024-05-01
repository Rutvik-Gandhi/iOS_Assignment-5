//
//  DetailsViewController.swift
//  Assignment 5
//
//  Created by Assignment 5 on 23/11/22.
//

import UIKit

class DetailsViewController: UIViewController {

    //MARK: - Outlets -
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblDesc: UILabel!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    
    //MARK: - Variable Declaration -
    var objIimage: Photo?

    //MARK: - ViewControllers Life Cycle -
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = objIimage?.title
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
        self.lblTitle.text = objIimage?.title
        self.lblDesc.text = objIimage?.description
    }
}
