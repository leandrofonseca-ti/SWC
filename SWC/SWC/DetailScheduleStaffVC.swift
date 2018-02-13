//
//  GalleryController.swift
//  SWC
//
//  Created by Leandro Fonseca on 14/01/18.
//  Copyright © 2018 LF. All rights reserved.
//

import UIKit
import Photos
import RIGImageGallery
//import BSImagePicker

class DetailScheduleStaffVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    fileprivate let imageSession = URLSession(configuration: .default)
    @IBOutlet var lblSchedule: UILabel!
    var ID = 0
    var SCHEDULE_NAME = ""
    
    var list: Array<Tasks> = Array()
    
    @IBOutlet var tbView: UITableView!
    
    var SelectedAssets = [PHAsset]()
    //var PhotoArray = [UIImage]()
    
    @IBOutlet var pic01: UIImageView!
    @IBOutlet var pic02: UIImageView!
    @IBOutlet var pic03: UIImageView!
    @IBOutlet var pic04: UIImageView!
    @IBOutlet var pic05: UIImageView!
    @IBOutlet var pic06: UIImageView!
    
    var pic01Exist: Bool = false;
    var pic02Exist: Bool = false;
    var pic03Exist: Bool = false;
    var pic04Exist: Bool = false;
    var pic05Exist: Bool = false;
    var pic06Exist: Bool = false;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        
        self.lblSchedule.text = SCHEDULE_NAME
        addbuttonfloatOK()
        setImages()
        
        loadTasks()
    }
    
    func loadTasks()
    {
        
        let item1 = Tasks()
        item1.ID = 1
        item1.NAME = "Task 1"
        item1.QUANTITY = 5
        
        let item2 = Tasks()
        item2.ID = 2
        item2.NAME = "Task 2"
        item2.QUANTITY = 4
        
        let item3 = Tasks()
        item3.ID = 3
        item3.NAME = "Task 3"
        item3.QUANTITY = 7
        
        self.list.append(item1)
        self.list.append(item2)
        self.list.append(item3)
        
       
        
        
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
    
    
    
    
    func createPhotoGallery() -> RIGImageGalleryViewController {
        
        let urls: [URL] = [
            "https://placehold.it/1920x1080",
            "https://placehold.it/1080x1920",
            "https://placehold.it/350x150",
            "https://placehold.it/150x350",
            ].flatMap(URL.init(string:))
        
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
        
       // button.addTarget(self, action: #selector(pressButton(button:)), for: .touchUpInside)
        
        self.view.addSubview(button)
    
        
        
        let viewBottom = UIView(frame: CGRect(x:0,y: self.view.bounds.height - 70, width: self.view.bounds.width, height: 100))
        viewBottom.layer.backgroundColor = UIColor.white.cgColor
        viewBottom.addSubview(button)
        
        self.view.addSubview(viewBottom)
        
        
    }
    
    @IBAction func btnBackDetail(_ sender: Any) {
        
        let revealviewcontroller:SWRevealViewController = self.revealViewController()
        let mainstoryboard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewcontroller = mainstoryboard.instantiateViewController(withIdentifier: "ScheduleStaffListVC")
        let newFrontController = UINavigationController.init(rootViewController: newViewcontroller)
        revealviewcontroller.pushFrontViewController(newFrontController, animated: true)
        
    }
    
    @IBAction func BtnAddImage(_ sender: Any) {
       /* let vc = BSImagePickerViewController()
        
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
        }, completion: nil)*/
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
    
  
 
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.list.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        
        
        let cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
        let data = list[indexPath.row] as Tasks
        cell.textLabel?.text = data.NAME
        
        return cell
        
    }
    
}
