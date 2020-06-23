//
//  FeaturedProductControllerViewController.swift
//  Hills
//
//  Created by nitesh.banskota on 1/6/20.
//  Copyright © 2020 Hills Limited. All rights reserved.
//

import UIKit
import Firebase
import DropDown

class FeaturedProductViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {

    
    @IBOutlet weak var selectCategory: UIButton!
    @IBOutlet weak var featuredProductCollectionView: UICollectionView!
    var positionClicked: Int?
    let db = Firestore.firestore()
    var featuredProductCollection: [FeaturedProductData] = []
    let firestoreDocumentName = ["acess_control", "cctv", "itc"]
    
    let categoryDropdown = DropDown()
    override func viewDidLoad() {
        super.viewDidLoad()
        categoryDropdown.anchorView = selectCategory
        categoryDropdown.dataSource = Constants.FeaturedProduct.categoryItems
        featuredProductCollectionView.dataSource = self
        featuredProductCollectionView.delegate = self
        featuredProductCollectionView.register(UINib(nibName: "ProductCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: Constants.FeaturedProduct.cellIdentifier)
        print("position clicked: \(positionClicked!)")
        selectCategory.setTitle(Constants.FeaturedProduct.categoryItems[positionClicked!], for: [])
        loadFirestoreFeaturedProduct(subCollectionName: firestoreDocumentName[positionClicked!])
    }
    
    func loadFirestoreFeaturedProduct(subCollectionName: String){
        self.featuredProductCollection = []
        db.collection(Constants.FeaturedProduct.collectionName).document(Constants.FeaturedProduct.documentName).collection(subCollectionName).getDocuments { (querySnapShot, error) in
            if let error = error{
                print(error.localizedDescription)
            }else{
                if let documentSnapShots = querySnapShot?.documents{
                    for doc in documentSnapShots{
                        if let productName = doc[Constants.FeaturedProduct.productName] as? String,
                            let productImage = doc[Constants.FeaturedProduct.productImage] as? String,
                            let productLink = doc [Constants.FeaturedProduct.productLink] as? String,
                            let productNumber = doc[Constants.FeaturedProduct.productNumber] as? String,
                            let productSupplier = doc[Constants.FeaturedProduct.productSupplier] as? String {
                            self.featuredProductCollection.append(FeaturedProductData(productName: productName, productImage: productImage, productLink: productLink, productNumber: productNumber, productSupplier: productSupplier))
                            DispatchQueue.main.async {
                                self.featuredProductCollectionView.reloadData()
                            }
                        }
                    }
                }
            
        }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        featuredProductCollection.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let product = featuredProductCollection[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.FeaturedProduct.cellIdentifier, for: indexPath) as! ProductCollectionViewCell
        cell.productImage.sd_setImage(with: URL(string: product.productImage), placeholderImage: UIImage(named: "HillsLogoWhite.png") )
        cell.productName.text = product.productName
        cell.productSku.text = product.productNumber
        cell.productManufacturer.text = product.productSupplier
        let layer = cell.layer
        layer.shadowOffset = CGSize(width: 0, height: 1)
        layer.shadowRadius = 2
        layer.shadowColor = UIColor.lightGray.cgColor
        layer.shadowOpacity = 0.2
        layer.frame = cell.frame
       // cell.tagLabel.text = tagItems[indexPath.row].text
       return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let linkURL = featuredProductCollection[indexPath.row].productLink
        UIApplication.shared.open(URL(string: linkURL)! as URL, options: [:], completionHandler: nil)
    }
    
    @IBAction func categoryPressed(_ sender: UIButton) {
        self.categoryDropdown.show()
        self.categoryDropdown.selectionAction = {
                [unowned self](index: Int, item: String) in
                self.selectCategory.setTitle(item, for: [])
            self.loadFirestoreFeaturedProduct(subCollectionName: self.firestoreDocumentName[index])
            }
    }
}

extension FeaturedProductViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        var w = collectionView.frame.size.width / 2
        var h = collectionView.frame.size.height/2
        w = w - 5 * (h/w)
        h = h - 3 * (h/w)
        //print("height: \(h) and width: \(w)")
        return CGSize(width: w, height:h)
    }
}
