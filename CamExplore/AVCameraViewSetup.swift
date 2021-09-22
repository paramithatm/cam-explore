//
//  AVCameraViewSetup.swift
//  AVCameraViewSetup
//
//  Created by Paramitha on 22/09/21.
//

import UIKit

extension AVFoundationCameraViewController {
    
    
    func setupView(){
       view.backgroundColor = .black
       view.addSubview(switchCameraButton)
       view.addSubview(captureImageButton)
       
       NSLayoutConstraint.activate([
           switchCameraButton.widthAnchor.constraint(equalToConstant: 50),
           switchCameraButton.heightAnchor.constraint(equalToConstant: 50),
           switchCameraButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10),
           switchCameraButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
           
           captureImageButton.widthAnchor.constraint(equalToConstant: 50),
           captureImageButton.heightAnchor.constraint(equalToConstant: 50),
           captureImageButton.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
           captureImageButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10),
       ])
       
       switchCameraButton.addTarget(self, action: #selector(switchCamera(_:)), for: .touchUpInside)
       captureImageButton.addTarget(self, action: #selector(captureImage(_:)), for: .touchUpInside)
    }
    
    @objc func captureImage(_ sender: UIButton?){
        
    }
    
    @objc func switchCamera(_ sender: UIButton?){
        
    }
}
