//
//  ImageVC.swift
//  DogsPhotos
//
//  Created by MacOS on 20/09/2018.
//  Copyright © 2018 amberApps. All rights reserved.
//

import UIKit

protocol PhotosDelegate {
    func photosMethod(photo: UIImage)
}

class ImageVC: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    var delegate: PhotosDelegate?
    var image = UIImage()
    
    override func viewDidLoad() {
        super.viewDidLoad()
       imageView.image = image
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
