//
//  LoadingOverlay.swift
//  app
//
//  Created by Igor de Oliveira Sa on 25/03/15.
//  Copyright (c) 2015 Igor de Oliveira Sa. All rights reserved.
//
//  Usage:
//
//  # Show Overlay
//  LoadingOverlay.shared.showOverlay(self.navigationController?.view)
//
//  # Hide Overlay
//  LoadingOverlay.shared.hideOverlayView()
import UIKit
import Foundation

public class LoadingOverlay{
    var overlayView = UIView()
    var titleLabel:UILabel?
    
    var activityIndicator = UIActivityIndicatorView()
    class var shared: LoadingOverlay {
        struct Static {
            static let instance: LoadingOverlay = LoadingOverlay()
        }
        return Static.instance
    }
    public func showOverlay(view: UIView!) {
        overlayView = UIView(frame: UIScreen.main.bounds)
        overlayView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
        activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.whiteLarge)
        activityIndicator.center = overlayView.center
        overlayView.addSubview(activityIndicator)
        
        createTitle()
        overlayView.addSubview(titleLabel!)
        activityIndicator.startAnimating()
        view.addSubview(overlayView)
    }
    public func hideOverlayView() {
        activityIndicator.stopAnimating()
        overlayView.removeFromSuperview()
    
    }
    
    func createTitle(){
        titleLabel = UILabel(frame: CGRect(x:0, y:0, width: overlayView.frame.width, height: overlayView.frame.height + 50))
        titleLabel!.text = "Carregando"
        titleLabel!.textColor = UIColor.white
        titleLabel!.font = UIFont.preferredFont(forTextStyle: UIFontTextStyle.subheadline)
        titleLabel!.textAlignment = .center
        titleLabel!.translatesAutoresizingMaskIntoConstraints = false
    }
    
}
