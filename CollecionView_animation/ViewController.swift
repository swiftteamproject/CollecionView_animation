//
//  ViewController.swift
//  CollecionView_animation
//
//  Created by Артем Валерьевич on 12/05/2019.
//  Copyright © 2019 Артем Валерьевич. All rights reserved.
//

import UIKit

struct ZoomTransition {
    var cardView: UIImageView
    var cardViewFrame: CGRect
}

class ViewController: UIViewController {
    let duration = 0.25
    var alphaCell = 0
    var imageName = ["images1", "images2", "images3", "images4", "images5", "images6", "images7", "images8", "images9", "images10", "images11"]
    var zoomTransition: ZoomTransition!
    var index: IndexPath!
    let cellId = "cell"
    var collectionView: UICollectionView!
    let headerView = UIView()
    var arrayImages = [UIImage]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        for i in 0..<imageName.count {
            let image = UIImage(named: imageName[i])
            arrayImages.append(image!)
        }
        // Layout
        let layout: PinterestLayout = PinterestLayout()
        layout.delegate = self
        let frame = UIScreen.main.bounds
       
        // CollectionView setings
        collectionView = UICollectionView(frame: frame, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(CollectionViewCell.self, forCellWithReuseIdentifier: cellId)
        collectionView.backgroundColor = .clear

        let gradient = CAGradientLayer()
        gradient.frame = view.bounds
        gradient.colors = [UIColor.white.cgColor, UIColor.black.cgColor]
        view.layer.insertSublayer(gradient, at: 0)
        view.addSubview(collectionView)
        
        
    }
}


extension ViewController: UICollectionViewDelegate {
    
    
}

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageName.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! CollectionViewCell
        cell.imageView.image = UIImage(named: imageName[indexPath.row])
        cell.imageView.contentMode = .scaleAspectFill
        return cell
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let image = UIImage(named: imageName[indexPath.row])
        guard let cell = collectionView.cellForItem(at: indexPath) as? CollectionViewCell else { return }
        index = indexPath
        let cardViewFrame = cell.imageView.superview?.convert(cell.imageView.frame, to: nil)
        let copyOfCardView = UIImageView(frame: cardViewFrame!)
        copyOfCardView.contentMode = .scaleAspectFill
        copyOfCardView.image = image
        copyOfCardView.layer.cornerRadius = 12.0
        copyOfCardView.layer.masksToBounds = true
        cell.imageView.alpha = CGFloat(alphaCell)
        view.addSubview(copyOfCardView)
        
        zoomTransition = ZoomTransition(cardView: copyOfCardView, cardViewFrame: cardViewFrame!)
        UIView.animate(withDuration: duration, animations: {
            copyOfCardView.layer.cornerRadius = 25.0
            let image = UIImage(named: self.imageName[indexPath.row])
            let images = image!
            let size = images.size
            let w = size.width
            let h = size.height
            let rotation = w / UIScreen.main.bounds.width
            let height = h / rotation
            let width = w / rotation
            print(width, height)
            copyOfCardView.frame = CGRect(x: 0, y: 80, width: width, height: height)
        }) { (expanded) in
            self.goToNextVCFrom(row: indexPath.row)
        }
    }
}

extension ViewController: SecondViewControllerDelegate {
    fileprivate func goToNextVCFrom(row: Int) {
        let secondVC = SecondViewController()
        secondVC.delegate = self
        //        secondVC.selectedRow = row
        secondVC.imageName = imageName[row]
        secondVC.modalPresentationStyle = .overCurrentContext
        secondVC.modalTransitionStyle = .crossDissolve
        //        secondVC.indexCell = row
        secondVC.delegate = self
        present(secondVC, animated: true, completion: nil)
    }
    
    func didGoBack() {
        guard let cell = collectionView.cellForItem(at: index) as? CollectionViewCell else { return }
        UIView.animate(withDuration: duration, animations: {
            self.zoomTransition.cardView.frame = self.zoomTransition.cardViewFrame
            self.zoomTransition.cardView.layer.cornerRadius = 12.0
            self.zoomTransition.cardView.layer.masksToBounds = true
            
        }) { (shrinked) in
            cell.imageView.alpha = 1
            self.zoomTransition.cardView.removeFromSuperview()
        }
    }
}


// Save property images
extension ViewController: PinterestLayoutDelegate {
    func collectionView(_ collectionView: UICollectionView, heightForPhotoAtIndexPath indexPath: IndexPath) -> CGFloat {
        let width = UIScreen.main.bounds.width / 2
        let w = arrayImages[indexPath.row].size.width
        let ww = w / width
        let h = arrayImages[indexPath.row].size.height
        let hh = h / ww
        print(hh)
        return hh
    }
}

