//
//  ImagePickerViewController.swift
//  CamExplore
//
//  Created by Paramitha on 08/09/21.
//

import UIKit

class ImagePickerViewController: UIImagePickerController {
    
    override func viewDidLoad() {
        sourceType = .camera
        super.viewDidLoad()
    }
}
