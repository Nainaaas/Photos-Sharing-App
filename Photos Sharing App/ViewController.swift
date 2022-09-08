//
//  ViewController.swift
//  Photos Sharing App
//
//  Created by shahina kassim on 07/09/2022.
//

import UIKit

class ViewController: UIViewController, UINavigationControllerDelegate {
    @IBOutlet weak var pickButton: UIButton!
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var imageView: UIImageView!
    
    let imagePicker = UIImagePickerController()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.scrollView.minimumZoomScale = 1.0
        self.scrollView.maximumZoomScale = 6.0
    
        // Do any additional setup after loading the view.
    }

    @IBAction func pickButtonAction(_ sender: Any) {
        
        if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum){
            self.imagePicker.delegate = self
            imagePicker.isEditing = false
            imagePicker.sourceType = .savedPhotosAlbum
            
            self.present(imagePicker, animated: true)
            
        }
        
    }
    @IBAction func shareAction(_ sender: Any) {
        if let image = imageView.image{
            let items : [Any] = [StringValues.imageShare, imageView.image!]
            let activityVC = UIActivityViewController(activityItems: items, applicationActivities: nil)
            self.present(activityVC, animated: true)
        }
        else{
            let alert = UIAlertController(title: StringValues.alertMsg, message: nil, preferredStyle: .alert)
            let okAction = UIAlertAction(title: StringValues.alertOK, style: .default) { UIAlertAction in
                
            }
            alert.addAction(okAction)
            self.present(alert, animated: true)
            
        }
       
    }
    
}
extension ViewController: UIImagePickerControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        self.dismiss(animated:true) { [self] in
            self.imageView.image = (info[UIImagePickerController.InfoKey.originalImage] as! UIImage)
        }
       
    
    }
    
    
}
extension ViewController: UIScrollViewDelegate{
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return self.imageView
    }
}
