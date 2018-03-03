//
//  DetailViewController.swift
//  MDB Socials
//
//  Created by Natasha Wong on 2/20/18.
//  Copyright © 2018 Natasha Wong. All rights reserved.
//

import UIKit
import Firebase
import CoreLocation
import MapKit

class DetailViewController: UIViewController {
    var currentUser: Users!
    var post: Post!
    var poster: String?
    var eventName: String?
    var descrip: String?
    var eventImage: UIImage?
    var exitButton: UIButton!
    var posterId: String?
    var interested: [String]!
    var interestedLabel: UILabel!
    var posterLabel: UILabel!
    var eventNameLabel: UILabel!
    var eventImageView: UIImageView!
    var descriptionLabel: UILabel!
    var interestedButton: UIButton!
    var interestCount = 0
    var mapView: MKMapView!
    var scrollView: UIScrollView!
    var directionButton: UIButton!
    var directionLabel: UILabel!
    var id = String()


    
    var color = Constants.appColor

    
    override func viewWillAppear(_ animated: Bool) {
        self.id = (Auth.auth().currentUser?.uid)!
        if interested == nil {
            interestedLabel.text = "\(0)"
            interestedButton.tintColor = UIColor.black

        } else {
            interestCount = interested.count
            interestedLabel.text = "\(post.interested!.count)"
            if (post.interested?.contains(self.id))! {
                interestedButton.tintColor = UIColor.red
            } else {
                interestedButton.tintColor = UIColor.black
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setupExit()
        setupLabels()
        setupInterested()
        setupImageView()
        setupMapView()
        setupScrollView()

    
        }
    func setupMapView() {
        mapView = MKMapView(frame: CGRect(x: 0, y: view.frame.height + 10, width: view.frame.width, height: view.frame.width - 70))
        mapView.showsUserLocation = true
        mapView.layer.borderColor = UIColor.black.cgColor
        mapView.layer.borderWidth = 2
        getCoordinates(withBlock: { coordinates in
            self.mapView.region = MKCoordinateRegion(center: coordinates, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
            let pin = MKPointAnnotation()
            pin.coordinate = coordinates
            self.mapView.addAnnotation(pin)
        })
        directionButton = UIButton(frame: CGRect(x: mapView.frame.maxX - 60, y: mapView.frame.maxY + 10, width: 50, height: 50))
        directionButton.setImage(UIImage(named: "location"), for: .normal)
        directionButton.addTarget(self, action: #selector(directionButtonPressed), for: .touchUpInside)

        
        directionLabel = UILabel(frame: CGRect(x: 0, y: mapView.frame.maxY + 30, width: view.frame.width*0.8, height: 50))
        directionLabel.layer.backgroundColor = UIColor.white.cgColor
        directionLabel.layer.borderColor = UIColor.black.cgColor
        directionLabel.layer.borderWidth = 2
        directionLabel.text = "Get Directions"
        directionLabel.textAlignment = .center
        directionLabel.font = UIFont(name: "Strawberry Blossom", size: 30)
        directionButton = UIButton(frame: CGRect(x: mapView.frame.maxX - 60, y: mapView.frame.maxY + 30, width: 50, height: 50))
        directionButton.setImage(UIImage(named: "location"), for: .normal)
        view.addSubview(directionLabel)
        view.addSubview(directionButton)
    }
    
    @objc func directionButtonPressed() {
        
    }
    
    func getCoordinates(withBlock: @escaping (CLLocationCoordinate2D) -> ()) {
        let geocoder = CLGeocoder()
        var coordinates: CLLocationCoordinate2D!
       // let address = post.location ?? "2467 Warring Street Berkeley, CA 94720"
        let address = "2467 Warring Street Berkeley, CA 94720"
        geocoder.geocodeAddressString(address) { placemarks, error in
            if error == nil {
                let placemark = placemarks?.first
                coordinates = placemark?.location?.coordinate
                withBlock(coordinates)
            }
        }
    }
    
    @objc func getDirections() {
        getCoordinates() { coordinates in
            let mapItem = MKMapItem(placemark: MKPlacemark(coordinate: coordinates))
            mapItem.openInMaps(launchOptions: [MKLaunchOptionsDirectionsModeKey : MKLaunchOptionsDirectionsModeDriving])
        }
    }
    
    func setupImageView() {
        eventImageView = UIImageView(frame: CGRect(x: 0, y: 220, width: view.frame.width, height: 250))
        eventImageView.backgroundColor = color
        eventImageView.layer.borderColor = UIColor.black.cgColor
        eventImageView.layer.borderWidth = 2
        eventImageView.alpha = 0.9
        eventImageView.image = eventImage
        view.addSubview(eventImageView)
    }
    func setupExit() {
        exitButton = UIButton(frame: CGRect(x: 310, y: 20, width: 30, height: 30))
        exitButton.setImage(UIImage(named: "exit"), for: .normal)
        exitButton.addTarget(self, action: #selector(exitScreen), for: .touchUpInside)
        view.addSubview(exitButton)
    }
    @objc func exitScreen(sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    func setupLabels() {
        view.backgroundColor = UIColor(patternImage: UIImage(named: "image")!)

        posterLabel = UILabel(frame: CGRect(x: 0, y: 140, width: view.frame.width, height: 50))
        posterLabel.text = "Host: " + poster!
        posterLabel.textAlignment = .center
        posterLabel.font = UIFont(name: "Strawberry Blossom", size: 40)
        view.addSubview(posterLabel)
        
        eventNameLabel = UILabel(frame: CGRect(x: 0, y: 60, width: view.frame.width, height: 80))
        eventNameLabel.layer.borderColor = UIColor.black.cgColor
        eventNameLabel.layer.borderWidth = 2
        eventNameLabel.backgroundColor = UIColor.white
        eventNameLabel.text = eventName
        eventNameLabel.textAlignment = .center
        eventNameLabel.numberOfLines = 0
        eventNameLabel.adjustsFontSizeToFitWidth = true
        eventNameLabel.font = UIFont(name: "Strawberry Blossom", size: 80)
        view.addSubview(eventNameLabel)
        
        descriptionLabel = UILabel(frame: CGRect(x: 0, y: 500, width: view.frame.width, height: 90))
        descriptionLabel.layer.borderColor = UIColor.black.cgColor
        descriptionLabel.layer.borderWidth = 2
        descriptionLabel.text = "Description: " + descrip!
        descriptionLabel.backgroundColor = UIColor.white
        descriptionLabel.textAlignment = .center
        descriptionLabel.font = UIFont(name: "Strawberry Blossom", size: 30)
        descriptionLabel.lineBreakMode = .byWordWrapping
        descriptionLabel.numberOfLines = 0
        view.addSubview(descriptionLabel)
        
        interestedLabel = UILabel(frame: CGRect(x: view.frame.width - 110, y: view.frame.height - 60, width: 50, height: 50))
        
        view.addSubview(interestedLabel)
    }
    func setupScrollView() {
        scrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
        scrollView.addSubview(eventImageView)
        scrollView.addSubview(posterLabel)
        scrollView.addSubview(eventNameLabel)
        scrollView.addSubview(descriptionLabel)
        scrollView.addSubview(exitButton)
        scrollView.addSubview(interestedButton)
        scrollView.addSubview(interestedLabel)
//        scrollView.addSubview(foaasButton)
        scrollView.addSubview(mapView)
        scrollView.addSubview(directionButton)
//        scrollView.addSubview(calendarButton)
        scrollView.addSubview(directionLabel)
        scrollView.contentSize = CGSize(width: UIScreen.main.bounds.width, height: directionLabel.frame.maxY+100)
        
        view.addSubview(scrollView)
    }
    
    func setupInterested() {
        let origImage = UIImage(named: "heartIcon")
        let tintedImage = origImage?.withRenderingMode(.alwaysTemplate)
        interestedButton = UIButton(frame: CGRect(x: view.frame.width - 70, y: view.frame.height - 60, width: 50, height: 50))
        interestedButton.setImage(tintedImage, for: .normal)
        if interested == nil {
            interestedButton.tintColor = UIColor.black
        } else if interested.contains(self.id) {
            interestedButton.tintColor = UIColor.red
        } else {
            interestedButton.tintColor = UIColor.black
        }
        interestedButton.addTarget(self, action: #selector(interestPressed), for: .touchUpInside)
        view.addSubview(interestedButton)
    }
    
    @objc func interestPressed() {
        if interested == nil {
            interestedButton.tintColor = UIColor.red
            interested = [currentUser.id!]
            interestedLabel.text = "\(interested.count)"
            let postsRef = Database.database().reference().child("Posts").child(post.id!)
            let childUpdates = ["interested": interested]
            postsRef.updateChildValues(childUpdates)
        }
         else if interested.contains((currentUser?.id)!) {
            interestedButton.tintColor = UIColor.black
            let index = interested.index(of: (currentUser?.id)!)
            interested.remove(at: index!)
            interestedLabel.text = "\(interested.count)"
            let postsRef = Database.database().reference().child("Posts").child(post.id!)
            let childUpdates = ["interested": interested]
            postsRef.updateChildValues(childUpdates)
        } else {
            interestedButton.tintColor = UIColor.red
            interested.append((currentUser?.id)!)
            interestedLabel.text = "\(interested.count)"
            let postsRef = Database.database().reference().child("Posts").child(post.id!)
            let childUpdates = ["interested": interested]
            postsRef.updateChildValues(childUpdates)
        }
    
    }
    

}
