//
//  EventsViewController.swift
//  Hills
//
//  Created by nitesh.banskota on 1/6/20.
//  Copyright © 2020 Hills Limited. All rights reserved.
//

import UIKit
import Firebase
import SDWebImage

class EventsViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return eventCollection.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let event = eventCollection[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.Event.cellIdentifier, for: indexPath) as! EventCollectionViewCell
        cell.title.text = event.title
        cell.imgName.text = event.imgName
        cell.eventDescription.text = event.description
        cell.image.sd_setImage(with: URL(string: event.image), placeholderImage: UIImage(named: "HillsLogoWhite.png") )
    return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let linkURL = eventCollection[indexPath.row].link
        print("You clicked on Event item at: \(indexPath.row)")
        UIApplication.shared.open(URL(string: linkURL)! as URL, options: [:], completionHandler: nil)
    }
    
    
    let db = Firestore.firestore()
    @IBOutlet weak var eventControllerView: UICollectionView!
    
    var eventCollection: [EventData] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        eventControllerView.dataSource = self
        eventControllerView.delegate = self
        eventControllerView.register(UINib(nibName: Constants.Event.cellNibName, bundle: nil), forCellWithReuseIdentifier: Constants.Event.cellIdentifier)
        loadEventsFromFirebase()
        // Do any additional setup after loading the view.
    }
    
    func loadEventsFromFirebase(){
        db.collection(Constants.Event.collectionName).addSnapshotListener {
            (querySnapShot, error) in
            if let e = error{
                print(e.localizedDescription)
            }else{
                if let documentSnapshots = querySnapShot?.documents{
                    for doc in documentSnapshots{
                        if let description = doc[Constants.Event.description] as? String,
                            let link = doc[Constants.Event.link] as? String,
                            let image = doc[Constants.Event.image] as? String,
                            let title = doc[Constants.Event.title] as? String,
                            let imgName = doc[Constants.Event.imgName] as? String
                        {
                            self.eventCollection.append(EventData(description: description, image: image, imgName: imgName, link: link, title: title))
                            print(self.eventCollection)
                            DispatchQueue.main.async {
                                self.eventControllerView.reloadData()
                                print("image loading...")
                            }
                        }
                    }
                    
                }
                
            }
            
        }
    }

}

extension EventsViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let w = collectionView.frame.size.width - 2
        let h = collectionView.frame.size.width
        //print("height: \(h) and width: \(w)")
        return CGSize(width: w, height:h)
    }
}
