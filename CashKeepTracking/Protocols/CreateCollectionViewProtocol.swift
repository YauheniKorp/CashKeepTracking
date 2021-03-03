//
//  CreateCollectionViewProtocol.swift
//  CashKeepTracking
//
//  Created by Admin on 28.12.2020.
//

import Foundation
import UIKit

protocol CreateCollectionView: UICollectionViewDelegate, UICollectionViewDataSource, UIGestureRecognizerDelegate {
    func createCollectionView(_ viewController: UIViewController, _ collectionView: UICollectionView, _ detailButton: UIButton, _ view: UIView)
}

extension CreateCollectionView {
    func createCollectionView(_ viewController: UIViewController, _ collectionView: UICollectionView, _ detailButton: UIButton, _ view: UIView) {
        
        var collectionVC = collectionView
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 20, left: 10, bottom: 30, right: 10)
        layout.itemSize = CGSize(width: 335, height: 150)
  
        let frameCollectionVC = CGRect(x: 0, y: 0, width: viewController.view.frame.width, height: viewController.view.frame.height)
        collectionVC = UICollectionView(frame: frameCollectionVC, collectionViewLayout: layout)
        collectionVC.backgroundView = UIImageView(image: UIImage(named: "ocean")!)
        collectionVC.delegate = self
        collectionVC.dataSource = self
        collectionVC.register(ItemCollectionViewCell.self, forCellWithReuseIdentifier: "Cell")

        collectionVC.addSubview(view)
        viewController.view.addSubview(collectionVC)
    }
   
}
