//
//  GLDatesTests.swift
//  GLDatesTests
//
//  Created by Keith Elliott on 1/7/16.
//  Copyright © 2016 GittieLabs. All rights reserved.
//

import XCTest
import GLDates
@testable import GLDates

class GLDatesTests: XCTestCase {
    var today: NSDate!
    var calendar: NSCalendar!
    var test_yesterday: NSDate!
    
    override func setUp() {
        super.setUp()
        today = NSDate()
        calendar = NSCalendar.currentCalendar()
        test_yesterday = calendar.dateByAddingUnit(.Day, value: -1, toDate: today, options: .MatchStrictly)
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    
    func testGettingYesterday() {
        let yesterday = NSDate.yesterday()
        XCTAssertTrue(calendar.compareDate(yesterday, toDate: test_yesterday!, toUnitGranularity: .Day) == .OrderedSame)
    }
    
    func testPreviousDay(){
        let _1dayAgo = today.previousDate(0, monthsBack: 0, daysBack: 1)
        let _2MonthsAgo = today.previousDate(0, monthsBack: 2, daysBack: 0)
        let _2YearsAgo = today.previousDate(2, monthsBack: 0, daysBack: 0)
        
        let test_2MonthsBack = calendar.dateByAddingUnit(.Month, value: -2, toDate: today, options: [])
        let test_2YearsBack = calendar.dateByAddingUnit(.Year, value: -2, toDate: today, options: [])
        
        XCTAssertTrue(calendar.compareDate(_1dayAgo, toDate: test_yesterday!, toUnitGranularity: .Day) == .OrderedSame)
        XCTAssertTrue(calendar.compareDate(_2MonthsAgo, toDate: test_2MonthsBack!, toUnitGranularity: .Day) == .OrderedSame)
        XCTAssertTrue(calendar.compareDate(_2YearsAgo, toDate: test_2YearsBack!, toUnitGranularity: .Day) == .OrderedSame)
    }
    
    func testFirstDayOfMonth(){
        let firstDayOfMonth = today.firstOfMonth()
        let dateComps = calendar.components([.Year,.Month], fromDate: today)
        dateComps.day = 1
        let testFirstOfMonth = calendar.dateFromComponents(dateComps)
        
        XCTAssertTrue(calendar.compareDate(firstDayOfMonth, toDate: testFirstOfMonth!, toUnitGranularity: .Day) == .OrderedSame)
    }
    
    func testFirstDayofYear() {
        let firstOfYear = today.firstOfYear()
        let dateComps = calendar.components([.Year], fromDate: today)
        dateComps.day = 1
        dateComps.month = 1
        let testFirstOfYear = calendar.dateFromComponents(dateComps)
        
        XCTAssertTrue(calendar.compareDate(firstOfYear, toDate: testFirstOfYear!, toUnitGranularity: .Day) == .OrderedSame)
    }
    
    func testLastDayOfMonth() {
        let lastDayOfMonth = today.lastDayOfMonth()
        let dateComps = calendar.components([.Year,.Month], fromDate: today)
        dateComps.day = 1
        dateComps.month = dateComps.month + 1
        let nextMonth = calendar.dateFromComponents(dateComps)
        let test_lastDay = calendar.dateByAddingUnit(.Day, value: -1, toDate: nextMonth!, options: [])
        
        XCTAssertTrue(calendar.compareDate(lastDayOfMonth, toDate: test_lastDay!, toUnitGranularity: .Day) == .OrderedSame)
    }
    
    func testLastDayOfYear() {
        let lastDayOfYear = today.lastDayOfYear()
        let dateComps = calendar.components([.Year,.Month], fromDate: today)
        dateComps.day = 1
        dateComps.month = 1
        dateComps.year = dateComps.year + 1
        let nextMonth = calendar.dateFromComponents(dateComps)
        let test_lastDay = calendar.dateByAddingUnit(.Day, value: -1, toDate: nextMonth!, options: [])
        
        XCTAssertTrue(calendar.compareDate(lastDayOfYear, toDate: test_lastDay!, toUnitGranularity: .Day) == .OrderedSame)
    }
    
    func testDateWithNoTime() {
        let startofday = today.dateWithNoTime()
        let test_startOfDay = calendar.startOfDayForDate(today)
        
        XCTAssertTrue(calendar.compareDate(startofday, toDate: test_startOfDay, toUnitGranularity: .Day) == .OrderedSame)
    }
    
}
