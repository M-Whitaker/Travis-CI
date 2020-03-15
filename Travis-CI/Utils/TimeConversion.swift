//
//  TimeConversion.swift
//  Travis-CI
//
//  Created by Matt Whitaker on 23/02/2020.
//  Copyright © 2020 Matt Whitaker. All rights reserved.
//

import Foundation

extension Date {
    func timeAgoDisplay() -> String {
        let secondsAgo = Int(Date().timeIntervalSince(self))
        
        let minute = 60
        let hour = minute * 60
        let day = hour * 24
        let week = day * 7
        let month = Int(Double(week) * 4.34524)
//        let year = month * 12
        
        if secondsAgo < 60 {
            return "\(secondsAgo)" + (secondsAgo > 1 ? "Seconds Ago" : "Second Ago")
        } else if secondsAgo < hour {
            return "\(secondsAgo / minute) " + ((secondsAgo / minute) > 1 ? "Minutes Ago" : "Minute Ago")
        } else if secondsAgo < day {
            return "\(secondsAgo / hour) " + ((secondsAgo / hour) > 1 ? "Hours Ago" : "Hour Ago")
        } else if secondsAgo < week {
            return "\(secondsAgo / day) " + ((secondsAgo / day) > 1 ? "Days Ago" : "Day Ago")
        } else if secondsAgo < month {
            return "\(secondsAgo / week) " + ((secondsAgo / week) > 1 ? "Weeks Ago" : "Week Ago")
        }
        
        return "\(secondsAgo / month) " + ((secondsAgo / month) > 1 ? "Months Ago" : "Month Ago")
    }
}

func convertTime(isoDate: String) -> Date {

    let dateFormatter = DateFormatter()
    dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
    let date = dateFormatter.date(from:isoDate)!
    
    return date
}

/// This function turns seconds into hours, minutes and seconds
///
/// Usage:
///
///     convertDuration(timeInSeconds: 60) // 0,1,0
///
/// - Returns: Three integers of the hours, minutes and seconds of a given input.
func convertDuration(timeInSeconds: Int) -> (Int, Int, Int) {
    
    return (timeInSeconds / 3600, (timeInSeconds % 3600) / 60, (timeInSeconds % 3600) % 60)
}

func printSecondsToHoursMinutesSeconds (seconds:Int) -> String {
    
    let (h, m, s) = convertDuration(timeInSeconds: seconds)
    if (h != 0) {
        return ("\(h) h, \(m) m, \(s) s")
    } else if (m != 0) {
        return ("\(m) m, \(s) s")
    } else {
        return ("\(s) s")
    }
}
