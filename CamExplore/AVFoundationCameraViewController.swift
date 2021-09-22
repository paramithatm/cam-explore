//
//  AVFoundationCameraViewController.swift
//  CamExplore
//
//  Created by Paramitha on 18/09/21.
//

import AVFoundation
import UIKit

class AVFoundationCameraViewController: UIViewController {
    
    var captureSession: AVCaptureSession!
    
    var backCamera: AVCaptureDevice!
    var frontCamera: AVCaptureDevice!
    
    var backInput: AVCaptureInput!
    var frontInput: AVCaptureInput!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        checkPermissions()
        setupSession()
    }
    
    func checkPermissions() {
        let cameraAuthStatus =  AVCaptureDevice.authorizationStatus(for: AVMediaType.video)
        switch cameraAuthStatus {
        case .authorized:
            return
        case .denied:
            fatalError("permission denied")
        case .notDetermined:
            AVCaptureDevice.requestAccess(
                for: AVMediaType.video, completionHandler: { (authorized) in
                    if(!authorized){
                        fatalError("permission denied")
                    }
                })
        case .restricted:
            fatalError("permission denied")
        @unknown default:
            fatalError("permission denied")
        }
    }
    
    func setupSession() {
        DispatchQueue.global(qos: .userInitiated).async {
            self.captureSession = AVCaptureSession()
            
            self.captureSession.beginConfiguration()
            
            if self.captureSession.canSetSessionPreset(.photo) {
                self.captureSession.sessionPreset = .photo
            }
            self.captureSession.automaticallyConfiguresCaptureDeviceForWideColor = true
            
            self.setupInput()
            
            self.captureSession.commitConfiguration()
            
            self.captureSession.startRunning()
        }
    }
    
    func setupInput() {
        if let device = AVCaptureDevice.default(AVCaptureDevice.DeviceType.builtInWideAngleCamera, for: AVMediaType.video, position: .back) {
            backCamera = device
        } else {
            fatalError("no back camera")
        }
        
        if let device = AVCaptureDevice.default(AVCaptureDevice.DeviceType.builtInWideAngleCamera, for: AVMediaType.video, position: .front) {
            frontCamera = device
        } else {
            fatalError("no front camera")
        }
        
        guard let bcInput = try? AVCaptureDeviceInput(device: backCamera) else {
            fatalError("cannot create input from back camera")
        }
        backInput = bcInput
        
        guard let frInput = try? AVCaptureDeviceInput(device: frontCamera) else {
            fatalError("cannot create input from front camera")
        }
        frontInput = frInput
        
        guard captureSession.canAddInput(backInput), captureSession.canAddInput(frontInput) else {
            fatalError("could not add input to session")
        }
        
        captureSession.addInput(backInput)
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
    let dismissButton : UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemBlue
        button.tintColor = .white
        button.layer.cornerRadius = 25
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
}
