//
//  Constants.swift
//  Hills
//
//  Created by nitesh.banskota on 28/5/20.
//  Copyright © 2020 Hills Limited. All rights reserved.
//

import UIKit
import MapKit

struct Constants {
    
    struct FStore {
        static let collectionName = "CarouselImages"
        static let preferredCollectionName = "Key Partners"
    }
    
    struct Carousel {
        static let imageURL = "image"
        static let linkURL = "link"
        static let cellIdentifier = "itemCollectionCell"
    }
    struct Brand {
        static let logoURL = "logo"
        static let linkURL = "link"
        static let cellIdentifier = "preferredBrandIdentifier"
    }
    
    struct Event {
        static let cellIdentifier = "eventCellIdentifier"
        static let cellNibName = "EventCollectionViewCell"
        static let collectionName = "news and events"
        static let description = "description"
        static let image = "image"
        static let imgName = "imgName"
        static let link = "link"
        static let title = "title"
    }
    struct FeaturedProduct{
        static let cellIdentifier = "featuredCellIdentifier"
        static let collectionName = "Products"
        static let documentName = "featured_products"
        static let productName = "productDescription"
        static let productImage = "productImage"
        static let productLink = "productLink"
        static let productNumber = "productNumber"
        static let productSupplier = "productSupplier"
        static let categoryItems = ["Access Control and Intrusion", "CCTV" , "Information and Communication Technology"]
//        static func getSelectedItem(_ position : Int) -> String {
//
//            if position == 0{
//
//                return "
//            }else if citi == "vic"{
//                return vic
//            }else if citi == "qld"{
//                return qld
//            }else if citi == "wa"{
//                return wa
//            }else{
//                return nt
//            }
//
//        }
    }
    
    struct StrConstants {
        static let securityHeading = "Providing all your security solutions"
        static let cctvLabel = "cctv solutions"
        static let accessControlLabel = "Access Control & Intrusion Solutions"
        static let itcLabel = "Itc solutions"
        static let cctvLink = "https://www.hills.com.au/c/products/security_products/cctv_surveillance"
        static let aciLink = "https://www.hills.com.au/c/products/security_products/fire_security"
        static let itcLink = "https://www.hills.com.au/c/products/information_technology"
    }
    
    struct MenuLink{
        
    }
    
    struct Map{
        static let state = ["NSW", "VIC", "QLD", "WA", "SA", "TAS", "ACT", "NT"]
        struct Cities{
            static let nsw = ["Alexandria Branch", "Silverwater - AV repairs", "Seven Hills Branch"]
            static let vic = ["Coburg Branch"]
            static let qld = ["Nerang Branch"]
            static let wa = ["Balcatta Branch"]
            static let nt = ["canberra Branch"]
            static func getCity(_ city : String) -> [String] {
                let citi = city.lowercased()
                if citi == "nsw"{
                    return nsw
                }else if citi == "vic"{
                    return vic
                }else if citi == "qld"{
                    return qld
                }else if citi == "wa"{
                    return wa
                }else{
                    return nt
                }
                
            }
            static func pinLocation(_ city: String ) -> (CLLocationCoordinate2D, BranchDetail) {
                var lat = -33.9177997
                var lon = 151.1899165
                var branch: BranchDetail = BranchDetail(name: BranchLocationConstants.Alexandria.name, address: BranchLocationConstants.Alexandria.address, phone: BranchLocationConstants.Alexandria.phone, openingHours: BranchLocationConstants.Alexandria.openingHours)
                
                if city == "Alexandria Branch"{
                    branch = BranchDetail(name: city, address: BranchLocationConstants.Alexandria.address, phone: BranchLocationConstants.Alexandria.phone, openingHours: BranchLocationConstants.Alexandria.openingHours)
                }else if city == "Seven Hills Branch"{
                    lat = -33.7682097
                    lon = 150.9486464
                    branch = BranchDetail(name: city, address: BranchLocationConstants.SevenHills.address, phone: BranchLocationConstants.SevenHills.phone
                        , openingHours: BranchLocationConstants.SevenHills.openingHours)
                }
                let location = CLLocationCoordinate2D(latitude: lat, longitude: lon)
                return  (location, branch)
            }
        }
    }
}
