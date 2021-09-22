//
//  AVFoundationCameraViewController.swift
//  CamExplore
//
//  Created by Paramitha on 18/09/21.
//

import AVFoundation
import UIKit

class AVFoundationCameraViewController: UIViewController {
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    
    //MARK:- View Setup
    let switchCameraButton : UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemGreen
        button.tintColor = .white
        button.layer.cornerRadius = 25
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let captureImageButton : UIButton = {
        let button = UIButton()
        button.backgroundColor = .white
        button.tintColor = .white
        button.layer.cornerRadius = 25
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
}
