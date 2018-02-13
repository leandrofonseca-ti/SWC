//
//  ScheduleItem.swift
//  SWC
//
//  Created by Leandro Fonseca on 29/01/18.
//  Copyright © 2018 LF. All rights reserved.
//

import Foundation

class ScheduleItem {
    
    var ID = 0
    var SCHEDULE_ID = 0
    var SCHEDULE_NAME = ""
    var PLAN_TASK_ID = 0
    var PLAN_NAME = ""
    var PERIOD_TYPE_ID = 0
    var PERIOD_TYPE_NAME = ""
    var TIME_BEGIN = ""
    var DATE_BEGIN = ""
    var TASKS : Array<Tasks> = []
    var PICTURES : Array<Picture> = []
}


