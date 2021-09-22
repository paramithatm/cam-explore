//
//  AVFoundationCameraViewController.swift
//  CamExplore
//
//  Created by Paramitha on 18/09/21.
//

import AVFoundation
import UIKit

class AVFoundationCameraViewController: UIViewController {
    
    var previewLayer : AVCaptureVideoPreviewLayer!
    var captureSession: AVCaptureSession!
    
    var camera: AVCaptureDevice!
    
    var input: AVCaptureInput!
    
    var photoOutput: AVCapturePhotoOutput!
    
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
            self.setupOutput()
            
            DispatchQueue.main.async {
                self.setupPreview()
            }
            
            self.captureSession.commitConfiguration()
            
            self.captureSession.startRunning()
        }
    }
    
    func setupInput() {
        if let device = AVCaptureDevice.default(AVCaptureDevice.DeviceType.builtInWideAngleCamera, for: AVMediaType.video, position: .back) {
            camera = device
        } else {
            fatalError("no back camera")
        }
        
        guard let bcInput = try? AVCaptureDeviceInput(device: camera) else {
            fatalError("cannot create input from back camera")
        }
        input = bcInput
        
        guard captureSession.canAddInput(input) else {
            fatalError("could not add input to session")
        }
        
        captureSession.addInput(input)
    }
    
    func setupPreview() {
        previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        view.layer.insertSublayer(previewLayer, below: captureImageButton.layer)
        previewLayer.frame = self.view.layer.frame
    }
    
    func setupOutput() {
        photoOutput = AVCapturePhotoOutput()
        guard captureSession.canAddOutput(photoOutput) else {
            fatalError("could not add output to session")
        }
        captureSession.addOutput(photoOutput)
    }
    
    func capturePhoto() {
        photoOutput.capturePhoto(with: AVCapturePhotoSettings(), delegate: self)
    }
    
    // MARK: - View Setup
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
    
    var delegate: AVCameraVCDelegate? = nil
}

extension AVFoundationCameraViewController: AVCapturePhotoCaptureDelegate {
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        guard let photoData = photo.fileDataRepresentation(),
              let image = UIImage(data: photoData)
        else { return }
        
        dismiss(animated: true, completion: {
            self.delegate?.putImage(image: image)
        })
    }
}

protocol AVCameraVCDelegate {
    func putImage(image: UIImage)
}
