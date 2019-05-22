//
//  SecondViewController.swift
//  CollecionView_animation
//
//  Created by Артем Валерьевич on 12/05/2019.
//  Copyright © 2019 Артем Валерьевич. All rights reserved.
//

import UIKit


protocol SecondViewControllerDelegate {
    func didGoBack()
}

class SecondViewController: UIViewController {
//    var color: UIColor!
//    var selectedRow = 0
//    var indexCell: Int!
//    let titleLabel = UILabel()
//    let lineView = UIView()
//    let cellId = "cell"
//    
    var delegate: SecondViewControllerDelegate?
    var imageName: String!
    let imageView = UIImageView()
    var collectionView: UICollectionView!
    // let views = UIImageView()
    override func viewDidLoad() {
        super.viewDidLoad()

        let image = UIImage(named: imageName!)
        let images = image!
        let size = images.size
        let w = size.width
        
        
        let h = size.height
        let rotation = w / UIScreen.main.bounds.width
       
        let height = h / rotation
        let width = w / rotation
        print(width, height)
        imageView.frame = CGRect(x: 0, y: 80, width: width, height: height)
        
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 35
        imageView.layer.masksToBounds = true
        imageView.image = UIImage(named: imageName!)
        view.addSubview(imageView)
       
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(goBackTapGestureAction(_ :)))
        view.addGestureRecognizer(tapGesture)
    }
    

    

    
//    fileprivate func setupLabel() {
//        let label = UILabel()
//        label.numberOfLines = 0
//        label.font = UIFont.boldSystemFont(ofSize: 40)
//        label.textColor = .white
//        label.textAlignment = .center
//        label.text = "Number selected row\n\(selectedRow)"
//        label.translatesAutoresizingMaskIntoConstraints = false
//        self.view.addSubview(label)
//
//        NSLayoutConstraint.activate([
//            label.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 32.0),
//            label.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -32.0),
//            label.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 64.0),
//            label.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor)
//            ])
//    }
    
    @objc fileprivate func goBackTapGestureAction(_ sender: UITapGestureRecognizer) {
        guard let delegate = delegate else { return }
        delegate.didGoBack()
        imageView.alpha = 0
        DispatchQueue.main.async {
            
            self.dismiss(animated: true, completion: nil)
        }
        
    }
    
}


