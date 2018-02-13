//
//  CreateScheduleCustomer2VC.swift
//  SWC
//
//  Created by Leandro Fonseca on 26/01/18.
//  Copyright © 2018 LF. All rights reserved.
//

import UIKit
import Photos
import RIGImageGallery
import BSImagePicker
import DatePickerDialog
import JModalController


class CreateScheduleCustomer2VC: UIViewController {
    var ID = 0
    
    fileprivate let imageSession = URLSession(configuration: .default)
    
    var SelectedAssets = [PHAsset]()
    var ImageBytes = Array<String>()
    var ImageURLs = Array<URL>()
    
    @IBOutlet var nav: UINavigationItem!
    var ENTITY = ScheduleItem()
    @IBOutlet var lblDate: UILabel!
    @IBOutlet var lblTime: UILabel!
    @IBOutlet var lblPeriodType: UILabel!
    var pic01Exist: Bool = false;
    var pic02Exist: Bool = false;
    var pic03Exist: Bool = false;
    var pic04Exist: Bool = false;
    var pic05Exist: Bool = false;
    var pic06Exist: Bool = false;
    
    @IBOutlet var pic01: UIImageView!
    @IBOutlet var pic02: UIImageView!
    @IBOutlet var pic03: UIImageView!
    @IBOutlet var pic04: UIImageView!
    @IBOutlet var pic05: UIImageView!
    @IBOutlet var pic06: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        
        addbuttonfloatOK()
        setImages()
        nav.title = "Create Schedule"
        if ID > 0 {
            nav.title = "Edit Schedule"
        }
        loadItem(item: self.ENTITY)
    }
    
    private func loadItem(item: ScheduleItem)
    {
      if item.ID > 0 {
        self.ID = item.ID
        self.lblTime.text = item.TIME_BEGIN
        self.lblPeriodType.text = item.PERIOD_TYPE_NAME
        self.lblDate.text = item.DATE_BEGIN
        }
    }
    
    func setImages(){
        
        let tapGestureRecognizer1 = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        pic01.isUserInteractionEnabled = true
        pic01.addGestureRecognizer(tapGestureRecognizer1)
        
        
        let tapGestureRecognizer2 = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        pic02.isUserInteractionEnabled = true
        pic02.addGestureRecognizer(tapGestureRecognizer2)
        
        
        let tapGestureRecognizer3 = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        pic03.isUserInteractionEnabled = true
        pic03.addGestureRecognizer(tapGestureRecognizer3)
        
        
        let tapGestureRecognizer4 = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        pic04.isUserInteractionEnabled = true
        pic04.addGestureRecognizer(tapGestureRecognizer4)
        
        let tapGestureRecognizer5 = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        pic05.isUserInteractionEnabled = true
        pic05.addGestureRecognizer(tapGestureRecognizer5)
        
        let tapGestureRecognizer6 = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        pic06.isUserInteractionEnabled = true
        pic06.addGestureRecognizer(tapGestureRecognizer6)
    }
    
    @IBAction func clickModalTime(_ sender: Any) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        
        let simpleVC = storyBoard.instantiateViewController(withIdentifier: "ModalTimeController") as! ModalTimeController
        
        simpleVC.delegate = self
        let config = JModalConfig(transitionDirection: .bottom, animationDuration: 0.2, backgroundTransform: true, tapOverlayDismiss: true)
        presentModal(self, modalViewController: simpleVC, config: config) {
            //print("Presented Simple Modal")
        }
        
    }
    
    
    func createPhotoGallery() -> RIGImageGalleryViewController {
        
        var count = 0
        var urls: [URL] = [].flatMap(URL.init(string:))
        for url in ImageURLs{
            urls.insert(url, at: urls.count)
        }
        
        /*let urls: [URL] = [
            "https://placehold.it/1920x1080",
            "https://placehold.it/1080x1920",
            "https://placehold.it/350x150",
            "https://placehold.it/150x350",
            ].flatMap(URL.init(string:))*/
        
        let rigItems: [RIGImageGalleryItem] = urls.map { _ in
            RIGImageGalleryItem(placeholderImage: UIImage(named: "placeholder") ?? UIImage(),
                                isLoading: true)
        }
        
        let rigController = RIGImageGalleryViewController(images: rigItems)
        
        for (index, URL) in urls.enumerated() {
            let request = imageSession.dataTask(with: URLRequest(url: URL)) { [weak rigController] data, _, error in
                if let image = data.flatMap(UIImage.init), error == nil {
                    rigController?.images[index].image = image
                    rigController?.images[index].isLoading = false
                }
            }
            request.resume()
            
            count = count + 1
        }
        
        while count < 6 {
            
            for byt in ImageBytes {
                let dataDecoded : Data = Data(base64Encoded: byt, options: .ignoreUnknownCharacters)!
                let decodedimage = UIImage(data: dataDecoded)
                
                rigController.images[count - 1].image = decodedimage
                rigController.images[count - 1].isLoading = false
            }
            
            count = count + 1
        }
        
        
        return rigController
    }
    
    
    func imageTapped(tapGestureRecognizer: UITapGestureRecognizer)
    {
        
        let photoViewController = createPhotoGallery()
        photoViewController.dismissHandler = dismissPhotoViewer
        photoViewController.actionButtonHandler = actionButtonHandler
        photoViewController.actionButton = UIBarButtonItem(barButtonSystemItem: .trash, target: nil, action: nil)
        photoViewController.traitCollectionChangeHandler = traitCollectionChangeHandler
        photoViewController.countUpdateHandler = updateCount
        let navigationController = UINavigationController(rootViewController: photoViewController)
        present(navigationController, animated: true, completion: nil)
    }
    
    func dismissPhotoViewer(_ :RIGImageGalleryViewController) {
        dismiss(animated: true, completion: nil)
    }
    
    func actionButtonHandler(_ gallery: RIGImageGalleryViewController, galleryItem: RIGImageGalleryItem) {
        print(" ?? \(gallery.currentImage)")
    }
    
    func updateCount(_ gallery: RIGImageGalleryViewController, position: Int, total: Int) {
        gallery.countLabel.text = "\(position + 1) of \(total)"
    }
    
    func traitCollectionChangeHandler(_ photoView: RIGImageGalleryViewController) {
        let isPhone = UITraitCollection(userInterfaceIdiom: .phone)
        let isCompact = UITraitCollection(verticalSizeClass: .compact)
        let allTraits = UITraitCollection(traitsFrom: [isPhone, isCompact])
        photoView.doneButton = photoView.traitCollection.containsTraits(in: allTraits) ? nil : UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: nil)
    }
    
    
    func addbuttonfloatOK()
    {
        
        let button = UIButton(frame: CGRect(x: 10, y: 10, width: self.view.bounds.width - 20, height: 50))
        
        button.backgroundColor =  UIColor.uicolorFromHex(0x4794FE, alpha: 1)
        button.setTitle("OK", for: .normal)
        button.addTarget(self, action: #selector(pressButton(button:)), for: .touchUpInside)
        
        self.view.addSubview(button)
        
        
        
        let viewBottom = UIView(frame: CGRect(x:0,y: self.view.bounds.height - 70, width: self.view.bounds.width, height: 100))
        viewBottom.layer.backgroundColor = UIColor.white.cgColor
        viewBottom.addSubview(button)
        
        self.view.addSubview(viewBottom)
        
        
    }
    
    
    @objc func pressButton(button: UIButton) {
        
        
    }
    
    @IBAction func btnBackDetail(_ sender: Any) {
   
        navigationController?.popViewController(animated: true)
        
        dismiss(animated: true, completion: nil)
        
    }
    
    @IBAction func clickModalDate(_ sender: Any) {
        
        DatePickerDialog().show(title: "Date", doneButtonTitle: "Done", cancelButtonTitle: "Cancel", datePickerMode: .date) {
            (date) -> Void in
            if let dt = date {
                let formatter = DateFormatter()
                formatter.dateFormat = "yyyy/MM/dd"
                self.lblDate.text = formatter.string(from: dt)
            }
        }
    }
    @IBAction func clickAddImage(_ sender: Any) {
    
        let vc = BSImagePickerViewController()
        
        self.bs_presentImagePickerController(vc, animated: true,
                                             select: {(asset: PHAsset) -> Void in
                                                
                                                
        },
                                             deselect: {(asset: PHAsset) -> Void in
                                                
                                                
        },
                                             cancel: {(asset: [PHAsset]) -> Void in
                                                
                                                
        },
                                             finish: {(assets: [PHAsset]) -> Void in
                                                
                                                for i in 0..<assets.count {
                                                    self.SelectedAssets.append(assets[i])
                                                }
                                                self.convertAssetToImages()
        }, completion: nil)
 
    }
    
    func convertAssetToImages() -> Void {
        if SelectedAssets.count != 0 {
            
            for i in 0..<SelectedAssets.count {
                let manager = PHImageManager()
                let option = PHImageRequestOptions()
                var thumbnail = UIImage()
                option.isSynchronous = true
                manager.requestImage(for: SelectedAssets[i], targetSize: CGSize(width:200, height:200), contentMode: .aspectFill, options: option, resultHandler: {(result, info)-> Void in
                    thumbnail = result! })
                
                
                let data = UIImageJPEGRepresentation(thumbnail, 0.7)
                let newImage = UIImage(data: data!)
                //newImage?. = CGRect(x: 0, y: 0, width: 50, height: 50)
                ///self.PhotoArray.append(newImage! as UIImage)
                
                
                pic01Exist = false;
                pic02Exist = false;
                pic03Exist = false;
                pic04Exist = false;
                pic05Exist = false;
                pic06Exist = false;
                
                
                let base64String = data?.base64EncodedString()//NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
                ImageBytes.insert(base64String! as String, at: i)
                
                switch (i)
                {
                case 0:
                    
                    pic01.image = newImage
                    pic01Exist = true
                    break;
                    
                case 1:
                    pic02.image = newImage
                    pic02Exist = true
                    break;
                    
                case 2:
                    pic03.image = newImage
                    pic03Exist = true
                    break;
                    
                case 3:
                    pic04.image = newImage
                    pic04Exist = true
                    break;
                    
                case 4:
                    pic05.image = newImage
                    pic05Exist = true
                    break;
                    
                case 5:
                    pic06.image = newImage
                    pic06Exist = true
                    break;
                default:
                    print("-")
                }
                
                
            }
            
        }
        SelectedAssets = [PHAsset]()
    }
    
    @IBAction func clickModalPeriod(_ sender: Any) {
        
        let arraySelect : [String] = ["Once", "Daily", "Weekly", "Monthly"]
       
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .alert)
        
        _ = { (action: UIAlertAction!) -> Void in
            let index = alert.actions.index(of: action)
            
            if index != nil {
                NSLog("Index: \(index!)")
            }
        }
        for item in arraySelect {
            alert.addAction(UIAlertAction(title: item, style: .default, handler: {
                (_) in
                self.lblPeriodType.text = item
            }
            ))
            
        }
        
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: {(_) in }))
        
        self.present(alert, animated: false, completion: nil)
        
        
    }
    
    
    override func dismissModal(_ sender: Any, data: Any?) {
        super.dismissModal(sender, data: data)
        
        if sender is ModalTimeController, let value = data as? String {
            lblTime.text = value
        }
        if sender is CustomerDetailTableViewCell, let value = data as? Int {
           print( value )
        }
    }
    
}
