//
//  GLDatesUtils.swift
//  GLDates
//
//  Created by Keith Elliott on 1/7/16.
//  Copyright © 2016 GittieLabs. All rights reserved.
//

import Foundation

public extension Date{
    /** yesterday() Returns the yesterday
        returns: NSDate
    */
    public static func yesterday()->Date{
        let calendar = Calendar.current
        return (calendar as NSCalendar).date(byAdding: .day, value: -1, to: Date(), options: .matchStrictly)!.dateWithNoTime()
    }
    
    
    /**
     previouseDate - returns the previous date from the current date
     parameter yearsBack: the number of years to subtract
     parameter monthsBack: the number of months to subtract
     parameter daysBack: the number days to subtract
     returns: NSDate
    */
    public func previousDate(_ yearsBack: Int = 0, monthsBack: Int = 0, daysBack: Int)->Date{
        let calendar = Calendar.current
        var dateComps = DateComponents()
        dateComps.year = -yearsBack
        dateComps.month = -monthsBack
        dateComps.day = -daysBack
        let date = (calendar as NSCalendar).date(byAdding: dateComps, to: self, options: [])
        return date!.dateWithNoTime()
    }
    
    /// Returns the first day of the month
    public func firstOfMonth()->Date{
        let calendar = Calendar.current
        var dateComps = (calendar as NSCalendar).components([.year,.month], from: self)
        dateComps.day = 1
        let date = calendar.date(from: dateComps)
        return date!.dateWithNoTime()
    }
    
    /// Returns the first of the Year
    public func firstOfYear()->Date{
        let calendar = Calendar.current
        var dateComps = (calendar as NSCalendar).components([.year], from: self)
        dateComps.day = 1
        dateComps.month = 1
        let date = calendar.date(from: dateComps)
        return date!.dateWithNoTime()
    }
    
    /// Returns the last day of the Month
    public func lastDayOfMonth()->Date{
        let calendar = Calendar.current
        let firstDayNextMonth = (calendar as NSCalendar).date(byAdding: .month, value: 1, to: self, options: .matchStrictly)!.firstOfMonth()
        let lastDay = firstDayNextMonth.previousDate(daysBack: 1)
        return lastDay.dateWithNoTime()
    }
    
    /// Returns the last day of the Year
    public func lastDayOfYear()->Date{
        let calendar = Calendar.current
        var dateComps = calendar.dateComponents([.year,.month], from: Date())
        dateComps.day = 1
        dateComps.month = 1
        dateComps.year = dateComps.year! + 1
        let nextMonth = calendar.date(from: dateComps)
        let lastDayOfYear = calendar.date(byAdding: .day, value: -1, to: nextMonth!)

        
        return lastDayOfYear!
    }
    
    /// Returns the start of the Day for user' current calendar - Midnight in the US
    public func dateWithNoTime()->Date{
        let calendar = Calendar.current
        let date = calendar.startOfDay(for: self)
        return date
    }
    
    
    public func nextDateSkippingDays(_ daysBetween: Int, currentDate: Date)->Date{
        let calendar = Calendar.current
        
        let now = calendar.startOfDay(for: currentDate)
        let begin = calendar.startOfDay(for: self)
        
        let nextDate = (calendar as NSCalendar).date(byAdding: .day, value: daysBetween, to: begin, options: .matchNextTimePreservingSmallerUnits)
        
        if calendar.isDate(nextDate!, inSameDayAs: now){
            return calendar.startOfDay(for: nextDate!)
        }
        
        if (calendar as NSCalendar).compare(nextDate!, to: now, toUnitGranularity: .day) == .orderedAscending{
            return nextDate!.nextDateSkippingDays(daysBetween, currentDate: currentDate)
        }
            
        else{
            return calendar.startOfDay(for: nextDate!)
        }
    }
    
    public func nextDateSkippingWeeks(_ weeksBetween: Int, currentDate: Date)->Date{
        return nextDateSkippingDays(weeksBetween*7, currentDate: currentDate)
    }
    
    public func nextDateSkippingMonths(_ monthsBetween: Int, currentDate: Date)->Date{
        let calendar = Calendar.current
        
        let now = calendar.startOfDay(for: currentDate)
        let begin = calendar.startOfDay(for: self)
        
        let nextDate = (calendar as NSCalendar).date(byAdding: .month, value: monthsBetween, to: begin, options: .matchNextTimePreservingSmallerUnits)
        
        if calendar.isDate(nextDate!, inSameDayAs: now){
            return calendar.startOfDay(for: nextDate!)
        }
        
        if (calendar as NSCalendar).compare(nextDate!, to: now, toUnitGranularity: .day) == .orderedAscending{
            return nextDate!.nextDateSkippingMonths(monthsBetween, currentDate: currentDate)
        }
            
        else{
            return calendar.startOfDay(for: nextDate!)
        }
    }
    
    public func getDatesSkippingWeeks(_ weeksBetween: Int, currentDate: Date,
        currentlist: [Date]? = nil)->[Date]?{
            return getDatesSkippingDays(weeksBetween*7, currentDate: currentDate)
    }
    
    public func getDatesSkippingDays(_ daysBetween: Int, currentDate: Date, currentlist: [Date]? = nil)->[Date]?{
        let calendar = Calendar.current
        var dates = currentlist ?? [Date]()
        
        let now = calendar.startOfDay(for: currentDate)
        let begin = calendar.startOfDay(for: self)
        
        let nextDate = (calendar as NSCalendar).date(byAdding: .day, value: daysBetween, to: begin, options: .matchNextTimePreservingSmallerUnits)
        
        if calendar.isDate(nextDate!, inSameDayAs: now){
            dates.append(calendar.startOfDay(for: nextDate!))
            return dates
        }
        
        if (calendar as NSCalendar).compare(nextDate!, to: now, toUnitGranularity: .day) == .orderedAscending{
            dates.append(calendar.startOfDay(for: nextDate!))
            return nextDate!.getDatesSkippingDays(daysBetween, currentDate: currentDate, currentlist: dates)
        }
            
        else{
            return dates
        }
    }
    
    public func getDatesSkippingMonths(_ monthsBetween: Int, currentDate: Date, currentlist: [Date]? = nil)->[Date]?{
        let calendar = Calendar.current
        var dates = currentlist ?? [Date]()
        
        let now = calendar.startOfDay(for: currentDate)
        let begin = calendar.startOfDay(for: self)
        
        let nextDate = (calendar as NSCalendar).date(byAdding: .month, value: monthsBetween, to: begin, options: .matchNextTimePreservingSmallerUnits)
        
        if calendar.isDate(nextDate!, inSameDayAs: now){
            dates.append(calendar.startOfDay(for: nextDate!))
            return dates
        }
        
        if (calendar as NSCalendar).compare(nextDate!, to: now, toUnitGranularity: .day) == .orderedAscending{
            dates.append(calendar.startOfDay(for: nextDate!))
            return nextDate!.getDatesSkippingMonths(monthsBetween, currentDate: currentDate, currentlist: dates)
        }
            
        else{
            return dates
        }
    }
    
    public func formattedSocialTime() -> String {
        let calendar = Calendar.current
        let dateformatter = DateFormatter()
        dateformatter.dateStyle = .short
        let today = Date()
        let days = today.timeIntervalSince(self).days
        
        if calendar.isDateInToday(self){
            let hours = today.timeIntervalSince(self).hours
            let mins = today.timeIntervalSince(self).mins
            let secs = today.timeIntervalSince(self)
            
            if hours > 5 {
                return "today"
            }
            if hours > 1 && hours <= 5{
               return "\(hours) hours ago"
            }
            else if mins > 1 {
                return "\(mins) mins ago"
            }
            else if secs < 10 {
                return "moments ago"
            }
            else {
                let intSeconds = Int(secs)
                return "\(intSeconds) seconds ago"
            }
        }
        else if calendar.isDateInYesterday(self){
            return "yesterday"
        }
        else if days <= 7{
            return "\(days) days ago"
        }
        else{
            return dateformatter.string(from: self)
        }
    }
}

extension TimeInterval {
    var mins: Int {
        return Int(floor(self/60.0))
    }
    
    var hours: Int {
        let one_hour: Int = Int(60 * 60)
        return Int(floor(self / Double(one_hour)))
    }
    
    var days: Int {
        let one_day: Int = Int(60 * 60 * 24)
        return Int(floor(self / Double(one_day)))
    }
    
    var weeks: Int {
        let one_week: Int = Int(60 * 60 * 24 * 7)
        return Int(floor(self / Double(one_week)))
    }
}

