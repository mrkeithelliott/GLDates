//
//  GLDatesUtils.swift
//  GLDates
//
//  Created by Keith Elliott on 1/7/16.
//  Copyright © 2016 GittieLabs. All rights reserved.
//

import Foundation

public extension NSDate{
    /** yesterday() Returns the yesterday
        returns: NSDate
    */
    public class func yesterday()->NSDate{
        let calendar = NSCalendar.currentCalendar()
        return calendar.dateByAddingUnit(.Day, value: -1, toDate: NSDate(), options: .MatchStrictly)!.dateWithNoTime()
    }
    
    
    /**
     previouseDate - returns the previous date from the current date
     parameter yearsBack: the number of years to subtract
     parameter monthsBack: the number of months to subtract
     parameter daysBack: the number days to subtract
     returns: NSDate
    */
    public func previousDate(yearsBack: Int = 0, monthsBack: Int = 0, daysBack: Int)->NSDate{
        let calendar = NSCalendar.currentCalendar()
        let dateComps = NSDateComponents()
        dateComps.year = -yearsBack
        dateComps.month = -monthsBack
        dateComps.day = -daysBack
        let date = calendar.dateByAddingComponents(dateComps, toDate: self, options: [])
        return date!.dateWithNoTime()
    }
    
    /// Returns the first day of the month
    public func firstOfMonth()->NSDate{
        let calendar = NSCalendar.currentCalendar()
        let dateComps = calendar.components([.Year,.Month], fromDate: self)
        dateComps.day = 1
        let date = calendar.dateFromComponents(dateComps)
        return date!.dateWithNoTime()
    }
    
    /// Returns the first of the Year
    public func firstOfYear()->NSDate{
        let calendar = NSCalendar.currentCalendar()
        let dateComps = calendar.components([.Year], fromDate: self)
        dateComps.day = 1
        dateComps.month = 1
        let date = calendar.dateFromComponents(dateComps)
        return date!.dateWithNoTime()
    }
    
    /// Returns the last day of the Month
    public func lastDayOfMonth()->NSDate{
        let calendar = NSCalendar.currentCalendar()
        let firstDayNextMonth = calendar.dateByAddingUnit(.Month, value: 1, toDate: self, options: .MatchStrictly)!.firstOfMonth()
        let lastDay = firstDayNextMonth.previousDate(daysBack: 1)
        return lastDay.dateWithNoTime()
    }
    
    /// Returns the last day of the Year
    public func lastDayOfYear()->NSDate{
        let calendar = NSCalendar.currentCalendar()
        let nextYear = calendar.dateByAddingUnit(.Year, value: 1, toDate: self, options: [])!.firstOfMonth()
        let lastDayOfYear = nextYear.previousDate(daysBack: 1).dateWithNoTime()
        
        return lastDayOfYear
    }
    
    /// Returns the start of the Day for user' current calendar - Midnight in the US
    public func dateWithNoTime()->NSDate{
        let calendar = NSCalendar.currentCalendar()
        let date = calendar.startOfDayForDate(self)
        return date
    }
    
    
    public func nextDateSkippingDays(daysBetween: Int, currentDate: NSDate)->NSDate{
        let calendar = NSCalendar.currentCalendar()
        
        let now = calendar.startOfDayForDate(currentDate)
        let begin = calendar.startOfDayForDate(self)
        
        let nextDate = calendar.dateByAddingUnit(.Day, value: daysBetween, toDate: begin, options: .MatchNextTimePreservingSmallerUnits)
        
        if calendar.isDate(nextDate!, inSameDayAsDate: now){
            return calendar.startOfDayForDate(nextDate!)
        }
        
        if calendar.compareDate(nextDate!, toDate: now, toUnitGranularity: .Day) == .OrderedAscending{
            return nextDate!.nextDateSkippingDays(daysBetween, currentDate: currentDate)
        }
            
        else{
            return calendar.startOfDayForDate(nextDate!)
        }
    }
    
    public func nextDateSkippingWeeks(weeksBetween: Int, currentDate: NSDate)->NSDate{
        return nextDateSkippingDays(weeksBetween*7, currentDate: currentDate)
    }
    
    public func nextDateSkippingMonths(monthsBetween: Int, currentDate: NSDate)->NSDate{
        let calendar = NSCalendar.currentCalendar()
        
        let now = calendar.startOfDayForDate(currentDate)
        let begin = calendar.startOfDayForDate(self)
        
        let nextDate = calendar.dateByAddingUnit(.Month, value: monthsBetween, toDate: begin, options: .MatchNextTimePreservingSmallerUnits)
        
        if calendar.isDate(nextDate!, inSameDayAsDate: now){
            return calendar.startOfDayForDate(nextDate!)
        }
        
        if calendar.compareDate(nextDate!, toDate: now, toUnitGranularity: .Day) == .OrderedAscending{
            return nextDate!.nextDateSkippingMonths(monthsBetween, currentDate: currentDate)
        }
            
        else{
            return calendar.startOfDayForDate(nextDate!)
        }
    }
    
    public func getDatesSkippingWeeks(weeksBetween: Int, currentDate: NSDate,
        currentlist: [NSDate]? = nil)->[NSDate]?{
            return getDatesSkippingDays(weeksBetween*7, currentDate: currentDate)
    }
    
    public func getDatesSkippingDays(daysBetween: Int, currentDate: NSDate, currentlist: [NSDate]? = nil)->[NSDate]?{
        let calendar = NSCalendar.currentCalendar()
        var dates = currentlist ?? [NSDate]()
        
        let now = calendar.startOfDayForDate(currentDate)
        let begin = calendar.startOfDayForDate(self)
        
        let nextDate = calendar.dateByAddingUnit(.Day, value: daysBetween, toDate: begin, options: .MatchNextTimePreservingSmallerUnits)
        
        if calendar.isDate(nextDate!, inSameDayAsDate: now){
            dates.append(calendar.startOfDayForDate(nextDate!))
            return dates
        }
        
        if calendar.compareDate(nextDate!, toDate: now, toUnitGranularity: .Day) == .OrderedAscending{
            dates.append(calendar.startOfDayForDate(nextDate!))
            return nextDate!.getDatesSkippingDays(daysBetween, currentDate: currentDate, currentlist: dates)
        }
            
        else{
            return dates
        }
    }
    
    public func getDatesSkippingMonths(monthsBetween: Int, currentDate: NSDate, currentlist: [NSDate]? = nil)->[NSDate]?{
        let calendar = NSCalendar.currentCalendar()
        var dates = currentlist ?? [NSDate]()
        
        let now = calendar.startOfDayForDate(currentDate)
        let begin = calendar.startOfDayForDate(self)
        
        let nextDate = calendar.dateByAddingUnit(.Month, value: monthsBetween, toDate: begin, options: .MatchNextTimePreservingSmallerUnits)
        
        if calendar.isDate(nextDate!, inSameDayAsDate: now){
            dates.append(calendar.startOfDayForDate(nextDate!))
            return dates
        }
        
        if calendar.compareDate(nextDate!, toDate: now, toUnitGranularity: .Day) == .OrderedAscending{
            dates.append(calendar.startOfDayForDate(nextDate!))
            return nextDate!.getDatesSkippingMonths(monthsBetween, currentDate: currentDate, currentlist: dates)
        }
            
        else{
            return dates
        }
    }
}
