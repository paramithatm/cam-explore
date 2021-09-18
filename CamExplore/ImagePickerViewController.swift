//
//  ImagePickerViewController.swift
//  CamExplore
//
//  Created by Paramitha on 08/09/21.
//

import UIKit

class ImagePickerViewController: UIImagePickerController {
    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
        sourceType = .camera
        mediaTypes = ["public.image"]
    }
}


