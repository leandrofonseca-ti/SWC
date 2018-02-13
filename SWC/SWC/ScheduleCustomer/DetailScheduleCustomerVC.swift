//
//  File.swift
//  SWC
//
//  Created by Leandro Fonseca on 19/01/18.
//  Copyright © 2018 LF. All rights reserved.
//

import UIKit
import Photos
import RIGImageGallery
//import BSImagePicker


class DetailScheduleCustomerVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
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
        
        /*
        let placeholderTextView = MultilinePlaceholderTextView()
        placeholderTextView.frame = CGRect(x: 10, y: 180, width: UIScreen.main.bounds.width - 20, height: 200)
        placeholderTextView.backgroundColor = .white
        placeholderTextView.layer.cornerRadius = 8
        
        placeholderTextView.textContainerInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        placeholderTextView.font = UIFont.systemFont(ofSize: 17)
        
        view.addSubview(placeholderTextView)
        
        placeholderTextView.placeholder = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat."
        */
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
        
        
        //let userid = 1
        
        //ScheduleService.LoadScheduleListStaff(userid: userid, completion:{(success, objs) -> Void in
        //  if(success){
        //    self.list = objs
        // }
        //})
        
        
        
        
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
        print("image :)")
        // let tappedImage = tapGestureRecognizer.view as! UIImageView
        //tapGestureRecognizer.value(forKey: key)
        // Your action
        
        
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
        //navigationController?.popViewController(animated: true)
        
        
        let revealviewcontroller:SWRevealViewController = self.revealViewController()
        let mainstoryboard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewcontroller = mainstoryboard.instantiateViewController(withIdentifier: "ScheduleCustomerListVC")
        let newFrontController = UINavigationController.init(rootViewController: newViewcontroller)
        revealviewcontroller.pushFrontViewController(newFrontController, animated: true)
        
        /*
         let revealviewcontroller:SWRevealViewController = self.revealViewController()
         let mainstoryboard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
         let newViewcontroller = mainstoryboard.instantiateViewController(withIdentifier: "ScheduleVC")
         let newFrontController = UINavigationController.init(rootViewController: newViewcontroller)
         revealviewcontroller.pushFrontViewController(newFrontController, animated: true)
         */
        
        /* let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
         let nextViewController = storyBoard.instantiateViewController(withIdentifier: "RevealView") as! SWRevealViewController
         self.present(nextViewController, animated:true, completion:nil)
         */
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
        }, completion: nil)
 */
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
            //self.collectView.delete()
            /*for j in 0..<self.PhotoArray.count {
             let imageView = UIImageView(image: self.PhotoArray[j])
             imageView.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
             self.collectView.addSubview(imageView)
             
             }*/
            // self.imgView.animationImages = self.PhotoArray
            // self.imgView.animationDuration = 3.0
            // self.imgView.startAnimating()
        }
        SelectedAssets = [PHAsset]()
    }
    
    
    
    
    /*
     
     override func viewWillAppear(_ animated: Bool) {
     super.viewWillAppear(animated)
     
     let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
     layout.sectionInset = UIEdgeInsets(top: 20, left: 10, bottom: 10, right: 10)
     layout.itemSize = CGSize(width: 60, height: 60)
     
     let myCollectionView:UICollectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
     myCollectionView.dataSource = self
     myCollectionView.delegate = self
     myCollectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "MyCell")
     myCollectionView.backgroundColor = UIColor.white
     self.view.addSubview(myCollectionView)
     }
     
     func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
     return 10
     }
     
     internal func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
     let myCell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyCell", for: indexPath as IndexPath)
     myCell.backgroundColor = UIColor.blue
     return myCell
     }
     
     private func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: IndexPath)
     {
     print("User tapped on item \(indexPath.row)")
     }
     
     
     */
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.list.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        /*let cell = tbView.dequeueReusableCell(withIdentifier: "cell") as! CustomerTableViewCell
        
        let data = list[indexPath.row] as Tasks
        cell.txtTexto.text =  data.NAME
        cell.txtQtd.text =  "\(data.QUANTITY)"
        cell.ID = data.ID
        */
        let cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
        let data = list[indexPath.row] as Tasks
        cell.textLabel?.text = data.NAME
        
        return cell
        
    }
    
    //func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
    /* let delete = UITableViewRowAction(style: .destructive, title: "Delete") { (action, indexPath) in
     // delete item at indexPath
     self.list.remove(at: indexPath.row)
     self.tbview.reloadData()
     }
     
     let share = UITableViewRowAction(style: .normal, title: "Edit") { (action, indexPath) in
     // share item at indexPath
     
     //  self.perform(#selector(ViewController.showNavController), with: nil, afterDelay: 2)
     
     
     let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
     
     let nextViewController = storyBoard.instantiateViewController(withIdentifier: "DetailSchedule") as! DetailScheduleController
     
     nextViewController.ID =  self.list[indexPath.row].ID
     nextViewController.SCHEDULE_NAME = self.list[indexPath.row].NAME
     
     self.present(nextViewController, animated:true, completion:nil)
     
     
     }
     
     share.backgroundColor = UIColor.blue
     
     return [delete, share]
     */
    //}
}
