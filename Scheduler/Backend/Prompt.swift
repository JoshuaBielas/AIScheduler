//
//  Prompt.swift
//  Scheduler
//
//  Created by Joshua Bielas on 2/17/26.
//

import Foundation

func buildPrompt(for tasks: [Item]) -> String {
    //    return """
//        Create a schedule for these items: 
//        \(tasks[0].name) (Takes \(tasks[0].time) and is due \(tasks[0].date),
//        \(tasks[1].name) (Takes \(tasks[1].time) and is due \(tasks[1].date). 
//        It is currently \(Date()). 
//        Don't give any description. Just give the schedule.
//        Return JSON with a task name called name, start time called start, and end time called end for each.
//        Return dates in the same time zone that the user is in based on the included date for today.
//        Make sure to schedule all items.
//        Don't schedule them for the day they are due if it can be avoided.
//        """
//    return "Create a schedule for these items: Math Homework (Takes two hours and is due 2/19),History Studying (Takes one hour and is due 2/20). It is currently \(Date()). Don't give any description. Just give the schedule."
    
    return """
        Create a schedule for these items: \(tasks)
        It is currently \(Date()). 
        Don't give any description. Just give the JSON.
        Return JSON with a task name called name, start time called start, and end time called end for each.
        Return dates in the same time zone that the user is in based on the included date for today.
        Make sure to schedule all items.
        Don't schedule them for the day they are due if it can be avoided.
        If there are no tasks provided to give a schedule for just return an EMPTY JSON list.
        DONT MAKE UP ANY ITEMS.
        only use the provided items
        """
}
