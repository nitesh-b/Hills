//
//  ViewController.swift
//  Hills
//
//  Created by nitesh.banskota on 22/5/20.
//  Copyright © 2020 Hills Limited. All rights reserved.
//

import UIKit
import  Firebase
import iCarousel
import UserNotifications


class HomeController: UIViewController{
    //CarouselView IBOUtlets defination
    @IBOutlet weak var carouseCollectionlView: UICollectionView!
    @IBOutlet weak var pageController: UIPageControl!
    
    //Security Solutions Labels and Images outlets
    
    @IBOutlet weak var securityHeading: UILabel!
    @IBOutlet weak var cctvLabel: UILabel!
    @IBOutlet weak var aciLabel: UILabel!
    @IBOutlet weak var itcLabel: UILabel!
    
    @IBOutlet weak var featuredViewContainer: UIView!
    
    @IBOutlet weak var PreferredCollectionView: UICollectionView!
    
    
    let db = Firestore.firestore()
    var carouselCollection: [CarouselData] = []
    var preferrdBrandCollection: [PreferredBrandData] = []
    var timer = Timer()
    var counter = 0
    var counter0 = 0
    var index: IndexPath?
    var featuredProductPositionClicked = 0
    var featuredCarouselItems: [UIImage] = [#imageLiteral(resourceName: "accesscontrol_feature"), #imageLiteral(resourceName: "cctv_feature") ,#imageLiteral(resourceName: "ict_feature") ]
    
    let featuredCarousel: iCarousel = {
        let view = iCarousel()
        view.type = .linear
        return view
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Program Starts Here")
        carouseCollectionlView.dataSource = CarouselCollectionViewDataSource()
        //carouseCollectionlView.dataSource = self
       // carouseCollectionlView.delegate = self
        PreferredCollectionView.dataSource = self
        PreferredCollectionView.delegate = self
        getCarouselData()
        getPreferredBrandData()
        pageController.numberOfPages = 6
        pageController.alpha = 1
        pageController.currentPage = 0
        DispatchQueue.main.async {
            self.timer = Timer.scheduledTimer(timeInterval: 4.0, target: self, selector: #selector(self.changeImage), userInfo: nil, repeats: true)
        }
        
        //Set Security Solution Items Characteristics
        securityHeading.text! = Constants.StrConstants.securityHeading.uppercased()
        cctvLabel.text! = Constants.StrConstants.cctvLabel.uppercased()
        aciLabel.text! = Constants.StrConstants.accessControlLabel.uppercased()
        itcLabel.text! = Constants.StrConstants.itcLabel.uppercased()
        
        //Featured Product Views and its props
        featuredCarousel.dataSource = self
        featuredCarousel.delegate = self
        featuredCarousel.isPagingEnabled = true
        featuredCarousel.frame = CGRect(x: 0, y: 0, width: featuredViewContainer.frame.size.width, height: featuredViewContainer.frame.size.height)
        
        featuredViewContainer.addSubview(featuredCarousel)
        print(featuredViewContainer.frame.size)
        DispatchQueue.main.async {
            Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(self.changeFeaturedImage), userInfo: nil, repeats: true)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "featuredProductIdentifier"{
            let destinationVC = segue.destination as! FeaturedProductViewController
            destinationVC.positionClicked = featuredProductPositionClicked
        }
    }
    
    @IBAction func cctvButtonPressed(_ sender: UIButton) {
        openURL(Constants.StrConstants.cctvLink)
    }
    
    @IBAction func aciButtonPressed(_ sender: UIButton) {
        openURL(Constants.StrConstants.aciLink)
    }
    
    @IBAction func itcButtonPressed(_ sender: UIButton) {
        openURL(Constants.StrConstants.itcLink)
    }
    @objc func changeImage(){
        if counter < carouselCollection.count{
            index = IndexPath.init(item: counter, section: 0)
            self.carouseCollectionlView.scrollToItem(at: index!, at: .centeredHorizontally, animated: true)
            pageController.currentPage = counter
            counter += 1
        }else{
            counter = 0
        }
        
    }
    @objc func changeFeaturedImage(){
        if counter0 < featuredCarouselItems.count{
            self.featuredCarousel.scrollToItem(at: counter0, animated: true)
            counter0 += 1
        }else{
            counter0 = 0
        }
        
    }
    func getCarouselData() {
        db.collection(Constants.FStore.collectionName).addSnapshotListener {
            (querySnapShot, error) in
            if let e = error{
                print(e.localizedDescription)
            }else{
                if let documentSnapshots = querySnapShot?.documents{
                    for doc in documentSnapshots{
                        if let imageURL = doc[Constants.Carousel.imageURL] as? String, let linkURL = doc[Constants.Carousel.linkURL] as?String{
                            self.carouselCollection.append(CarouselData(image: imageURL, link: linkURL))
                            DispatchQueue.main.async {
                                self.carouseCollectionlView.reloadData()
                                print("image loading...")
                            }
                        }
                    }
                    
                }
                
            }
            
        }
    }
    
    func getPreferredBrandData(){
        db.collection(Constants.FStore.preferredCollectionName).getDocuments {
            (querySnapShot, error) in
            if let e = error{
                print(e.localizedDescription)
            }else{
                if let documentSnapshots = querySnapShot?.documents{
                    for doc in documentSnapshots{
                        if let logoURL = doc[Constants.Brand.logoURL] as? String, let linkURL = doc[Constants.Brand.linkURL] as?String{
                            self.preferrdBrandCollection.append(PreferredBrandData(logo: logoURL, link: linkURL))
                            DispatchQueue.main.async {
                                self.PreferredCollectionView.reloadData()
                                print("image loading...")
                            }
                        }
                    }
                    
                }
                
            }
            
        }
    }
    
}




extension UIViewController {
    
    func showAlert(title: String, message: String, callback: @escaping () -> ()) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: {
            alertAction in
            callback()
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func openURL(_ url: String){
        UIApplication.shared.open(URL(string: url)! as URL, options: [:], completionHandler: nil)
    }
    
}

class CarouselCollectionViewDataSource : NSObject, UICollectionViewDataSource{
    var homeController = HomeController()
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return homeController.carouselCollection.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let imageURL = homeController.carouselCollection[indexPath.row]
                   let item = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.Carousel.cellIdentifier, for: indexPath) as! CarouselCollectionViewCell
                   item.carouselImageView?.sd_setImage(with: URL(string: imageURL.image)!, placeholderImage: UIImage(named: "HillsLogoWhite.png"))
                   return item
    }
}

extension HomeController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == carouseCollectionlView{
            return carouselCollection.count
        } else if collectionView == PreferredCollectionView{
            print("Preferred Brand Count")
            return preferrdBrandCollection.count
        }else{
            return 0
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if(collectionView == carouseCollectionlView){

            let imageURL = carouselCollection[indexPath.row]
            let item = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.Carousel.cellIdentifier, for: indexPath) as! CarouselCollectionViewCell
            item.carouselImageView?.sd_setImage(with: URL(string: imageURL.image)!, placeholderImage: UIImage(named: "HillsLogoWhite.png"))
            return item
        }else{

            let logoURL = preferrdBrandCollection[indexPath.row]
            let item = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.Brand.cellIdentifier, for: indexPath) as! PreferredBrandCollectionViewCell
            item.preferredImageView?.sd_setImage(with: URL(string: logoURL.logo)!, placeholderImage: UIImage(named: "HillsLogoWhite.png"))
            return item
        }
    }
}
extension HomeController: UICollectionViewDelegateFlowLayout, UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        var linkURL = carouselCollection[indexPath.row].link
        if collectionView == PreferredCollectionView{
            linkURL = preferrdBrandCollection[indexPath.row].link
        }
        print("You clicked on item at: \(indexPath.row)")
        UIApplication.shared.open(URL(string: linkURL)! as URL, options: [:], completionHandler: nil)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        var w = collectionView.frame.size.width
        var h = collectionView.frame.size.height
        if collectionView == PreferredCollectionView{
            w = 150
            h = 75
        }
        //print("height: \(h) and width: \(w)")
        return CGSize(width: w, height:h)
    }
}

extension HomeController: iCarouselDataSource, iCarouselDelegate{
    func carousel(_ carousel: iCarousel, viewForItemAt index: Int, reusing view: UIView?) -> UIView {
        let w = carousel.frame.size.width
        let h = carousel.frame.size.height
        let vw = UIView(frame: CGRect(x: 0, y: 0, width: w, height: h))
        //print("Widht: \(w) and height: \(h)")
        let imageView = UIImageView(frame: featuredCarousel.frame)
        vw.addSubview(imageView)
        imageView.contentMode = .scaleToFill
        imageView.image = featuredCarouselItems[index]
        return vw
    }
    
    func numberOfItems(in carousel: iCarousel) -> Int {
        return featuredCarouselItems.count
    }
    
    func carousel(_ carousel: iCarousel, didSelectItemAt index: Int) {
        featuredProductPositionClicked = index
        self.performSegue(withIdentifier: "featuredProductIdentifier", sender: self)
    }
}
