//
//  ViewController.swift
//  DogsPhotos
//
//  Created by MacOS on 19/09/2018.
//  Copyright © 2018 amberApps. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    fileprivate var dogImages = [String]()
    
    var image = UIImage()
    
    var tapGesture = UITapGestureRecognizer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        updateLayout()
        dogImages = parseFromJson()
        
        tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.myviewTapped(_:)))
        tapGesture.numberOfTapsRequired = 1
        tapGesture.numberOfTouchesRequired = 1
        self.view.addGestureRecognizer(tapGesture)
        self.view.isUserInteractionEnabled = true
    }
    
    // MARK: Parse image URLs from JSON
    
    fileprivate func parseFromJson() -> [String] {
        guard let path = Bundle.main.path(forResource: "dog_urls", ofType: "json") else {
            return [""]
        }
        let url = URL(fileURLWithPath: path)
        
        do {
            let data = try Data(contentsOf: url)
            let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers)
            
            guard let arrayOfData = json as? [String: Array<String>] else { return [""] }
            
            guard let imageUrls = arrayOfData["urls"] else { return [""] }
            return imageUrls
        }
        catch {
            print(error)
        }
        return [""]
    }
    
    // MARK: Loading images from URL
    
    fileprivate func getImageFromUrl(_ url_str:String, _ imageView:UIImageView)
    {
        let url:URL = URL(string: url_str)!
        let session = URLSession.shared
        
        let task = session.dataTask(with: url, completionHandler: {
            (
            data, response, error) in
            
            if data != nil
            {
                let image = UIImage(data: data!)
                
                if(image != nil)
                {
                    DispatchQueue.main.async(execute: {
                        
                        imageView.image = image
                        imageView.alpha = 0
            
                        UIView.animate(withDuration: 2.5, animations: {
                            imageView.alpha = 1.0
                        })
                    })
                }
            }
        })
        task.resume()
    }
    
    // MARK: Collection View methods
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dogImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let imageCell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! customCell
        
        if dogImages != [""] {
            getImageFromUrl(dogImages[indexPath.row], imageCell.dogPhoto)

            imageCell.dogPhoto.image = UIImage(named: dogImages[indexPath.row])
        
            if let dogImage = imageCell.dogPhoto.image {
                image = dogImage
            }
        }
        
        return imageCell
    }
    
    // MARK: Change layout
    
    fileprivate func updateLayout() {
        let imageSize = UIScreen.main.bounds.width/3 - 2
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: imageSize, height: imageSize)
        
        layout.minimumInteritemSpacing = 2
        layout.minimumLineSpacing = 2
        
        collectionView.collectionViewLayout = layout
    }
    
    // TO DO: finish methods for loading tapped image on new screen
    
    @objc func myviewTapped(_ sender: UITapGestureRecognizer) {
        performSegue(withIdentifier: "segue", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segue" {
            if let otherVc: ViewController = segue.destination as? ViewController {
            otherVc.image = image
            }
        }
    }
    
    func photosMethod(photo: UIImage) {
        image = photo
    }
    
}

