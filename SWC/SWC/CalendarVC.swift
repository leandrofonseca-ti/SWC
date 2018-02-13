//
//  CalendarVC.swift
//  SWC
//
//  Created by Leandro Fonseca on 02/02/18.
//  Copyright © 2018 LF. All rights reserved.
//

import UIKit
import DTCalendar

class CalendarVC: UIViewController {
    
    
    fileprivate let formatter = DateFormatter()
    
    
    
    @IBOutlet var monthLabel: UILabel!
    
    @IBOutlet var calendar: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        formatter.timeStyle = .none
        formatter.dateStyle = .full
        monthLabel.text = formatter.string(from: Date())
        
        let calendarVar = DTCalendar()
        calendarVar.dataSource = self
        calendarVar.delegate = self
        
        calendar.addSubview(calendarVar)
        
        calendarVar.translatesAutoresizingMaskIntoConstraints = false
        
        let top = NSLayoutConstraint(item: calendarVar, attribute: .top, relatedBy: .equal, toItem: topLayoutGuide, attribute: .bottom, multiplier: 1, constant: 0)
        let leading = NSLayoutConstraint(item: calendarVar, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1, constant: 0)
        let trailing = NSLayoutConstraint(item: calendarVar, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .trailing, multiplier: 1, constant: 0)
        
        calendar.addConstraints([top, leading, trailing])
    }
   
    
    
}


    extension CalendarVC: DTCalendarDataSource {
        
        func calendar(_ calendar: DTCalendar, badgeForDate date: Date) -> DTBadge? {
            let dateComponents = Calendar.current.dateComponents([.weekday], from: date)
            if let weekday = dateComponents.weekday {
                if weekday == 2 || weekday == 4 || weekday == 6 {
                    return DTCircleBadge()
                }
            }
            return nil
        }
        
    }
    
    extension CalendarVC: DTCalendarDelegate {
        
        func calendar(_ calendar: DTCalendar, didSelectedDate date: Date, isDifferentMonth: Bool) {
            monthLabel.text = formatter.string(from: date)
            if isDifferentMonth {
                calendar.reloadBadges()
            }
        }
        
}
