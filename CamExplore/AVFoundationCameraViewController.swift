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
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    func capturePhoto() {
        
    }
    
    // MARK: - View Setup
    let captureImageButton : UIButton = {
        let button = UIButton()
        button.backgroundColor = .white
        button.tintColor = .white
        button.layer.cornerRadius = 25
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    let dismissButton : UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemBlue
        button.tintColor = .white
        button.layer.cornerRadius = 25
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
}
