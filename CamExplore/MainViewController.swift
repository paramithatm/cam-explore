//
//  ViewController.swift
//  CamExplore
//
//  Created by Paramitha on 08/09/21.
//

import UIKit

class MainViewController: UITableViewController {
    let array: [String] = ["ImagePicker", "AVFoundation"]
    
    let imageView = UIImageView(frame: CGRect(x: 20, y: 200, width: 375, height: 300))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = " 📸: Say 🧀"
        tableView.tableFooterView = UIView()
        tableView.dataSource = self
        tableView.delegate = self
        imageView.contentMode = .scaleAspectFit
        view.addSubview(imageView)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return array.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = array[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc: UIViewController
        switch indexPath.row {
        case 0:
            let someVc = UIImagePickerController()
            someVc.sourceType = .camera
            someVc.mediaTypes = ["public.image"]
            someVc.delegate = self
            vc = someVc
        case 1:
            vc = AVFoundationCameraViewController()
        default:
            vc = UIViewController()
        }
        present(vc, animated: true)
    }
    
    // call this from other vcs
    func setImage(image: UIImage) {
        self.imageView.image = image
    }
}

extension MainViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else {
            picker.dismiss(animated: true)
            return
        }
        setImage(image: image)
        picker.dismiss(animated: true)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }
}
