//
//  ViewController.swift
//  DogsPhotos
//
//  Created by MacOS on 19/09/2018.
//  Copyright © 2018 amberApps. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let arrayOfPhotos = parseFromJson()
        print(arrayOfPhotos)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: Parsing photo urls from JSON
    
    func parseFromJson() -> [String] {
        guard let path = Bundle.main.path(forResource: "dog_urls", ofType: "json") else {
            return [""]
        }
        let url = URL(fileURLWithPath: path)
        
        do {
            let data = try Data(contentsOf: url)
            let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers)
            
            guard let array = json as? [String: Array<String>] else { return [""] }
            
            guard let photos = array["urls"] else { return [""] }
            return photos
        }
        catch {
            print(error)
        }
        return [""]
    }
    
}

