//
//  PhotosViewController.swift
//  L1_GBVk
//
//  Created by Andrew on 18/05/2019.
//  Copyright © 2019 Andrew. All rights reserved.
//

import UIKit
import Foundation
import Realm
import RealmSwift

class PhotosViewController: UICollectionViewController {

    var friendId: Int = 0

    var photosToDisplay: [RPhoto] = []
    let presentTransition = CustomPresentModalAnimator()
    let dismissTransition = CustomDismissModalAnimator()
    let vkServices = VKServices()
    
    private var fullScreenViewController: FullScreenImagePresenterViewController?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.configCollectionVIew()
        self.getPhotosData()

    }

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return photosToDisplay.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AvatarCell.reuseIdentifier, for: indexPath) as? AvatarCell else { return UICollectionViewCell() }
        cell.indexPath = indexPath
        let photo = self.photosToDisplay[indexPath.row]
        let operationQueue = OperationQueue()
        let operation = LoadImageOperation()
        operation.url = URL(string: photo.photoUrl)
        operationQueue.addOperation(operation)
        operation.completion = { image in
            if cell.indexPath == indexPath {
                cell.avatarImageView.image = image
            }
        }
            return cell
    }
    
//    func getImagesArray(_ URLArray :[String]) -> [UIImage] {
//        var ImageViewsArray: [UIImage] = []
//        for string in URLArray {
//            let url = URL(string: string)
//            let image = UIImageView()
//            image.load(url: url!)
//            guard let uiImage = image.image else { return [] }
//            ImageViewsArray.append(uiImage)
//        }
//        return ImageViewsArray
//    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        let fullScreenGallery = storyboard!.instantiateViewController(withIdentifier: "FullScreenImagePresenter") as! FullScreenImagePresenterViewController
//
//        fullScreenGallery.transitioningDelegate = self
//        fullScreenGallery.imagesToDisplay = photosToDisplay
//        fullScreenGallery.indexPathToScrollTo = selectedIndexPath
//        fullScreenGallery.indexPathToScrollTo = selectedIndexPath
//
//        present(fullScreenGallery, animated: true, completion: nil )
        self.fullScreenViewController?.imagesToDisplay = self.photosToDisplay
        self.fullScreenViewController?.indexPathToScrollTo = indexPath
    }
    
    private func getPhotosData() {
        self.vkServices.getPhotos(id: self.friendId) { (isCompleted) in
            let realm = try? Realm()
            let resultPhotos = realm?.objects(RPhoto.self).filter("id=\(self.friendId)")
            guard let finalPhotos = resultPhotos else { return }
            self.photosToDisplay = Array(finalPhotos)
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    
    private func configCollectionVIew() {
        self.collectionView.dataSource = self
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? FullScreenImagePresenterViewController {
            self.fullScreenViewController = destination
        }
    }
}



extension PhotosViewController: UIViewControllerTransitioningDelegate {
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return presentTransition
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return dismissTransition
    }
    
}
