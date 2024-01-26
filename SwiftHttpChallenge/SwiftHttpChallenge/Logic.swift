//
//  Logic.swift
//  SwiftHttpChallenge
//
//  Created by Thomas Ditman on 26/01/2024.
//

import Foundation


func subStringCounter(fullString: String, subString: String) -> Int {
    
    //Initial plan was to replace all instances of the topic with something unique, then split on that something. Realized you can just split on the inital value instead. This will count due to the amount of splits being equal to the count of occurences minus 1
    //This will also contain pluralized versions of the string, but i think that should be included according to the question text
    return fullString.split(separator: subString).count-1
    
}
