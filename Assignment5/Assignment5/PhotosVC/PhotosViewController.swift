//
//  PhotosViewController.swift
//  Assignment 5
//
//  Created by Assignment 5 on 23/11/22.
//

import UIKit

class PhotosViewController: UIViewController {

    //MARK: - Variable Declaration -
    var arrImages = [Photo]()
    var storage = ImageStorage()
    
    
    //MARK: - Outlets -
    @IBOutlet weak var collectionView: UICollectionView!
    
    //MARK: - ViweController Life Cycle -
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Places"
        let appearance = UINavigationBarAppearance()
        self.navigationController?.navigationBar.scrollEdgeAppearance = appearance
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Get Places", style: .plain, target: self, action: #selector(self.loadPhotos))
    }
    
    //MARK: - Fetching Photos from JSON -
    @objc func loadPhotos() {
        storage.fetchAllImages { result in
            switch result {
            case .success(let array):
                self.arrImages = array
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            case .failure(let error):
                let alert = UIAlertController(title: "Assignment 5", message: error.localizedDescription, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default))
                alert.addAction(UIAlertAction(title: "Retry", style: .default, handler: { action in
                    self.loadPhotos()
                }))
                DispatchQueue.main.async {
                    self.present(alert, animated: true)
                }
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detailsSegue" {
            if let indexPath = collectionView.indexPathsForSelectedItems?.first {
                let obj = arrImages[indexPath.row]
                let detailsVC = segue.destination as! DetailsViewController
                detailsVC.objIimage = obj
            }
        }
    }
}


//MARK: - UICollectionView Datasource and Delegates -
extension PhotosViewController: UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.arrImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCollViewCell", for: indexPath) as? ImageCollViewCell else {
            return UICollectionViewCell()
        }
        cell.objIimage = self.arrImages[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let screenWidth = collectionView.bounds.width - 40
        return CGSize(width: screenWidth/3, height: screenWidth/3);
    }
}
