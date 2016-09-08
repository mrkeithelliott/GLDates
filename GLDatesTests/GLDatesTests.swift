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
    var today: Date!
    var calendar: Calendar!
    var test_yesterday: Date!
    
    override func setUp() {
        super.setUp()
        today = Date()
        calendar = Calendar.current
        test_yesterday = calendar.date(byAdding: .day, value: -1, to: today)
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    
    func testGettingYesterday() {
        let yesterday = Date.yesterday()
        XCTAssertTrue(calendar.compare(yesterday, to: test_yesterday!, toGranularity: .day) == .orderedSame)
    }
    
    func testPreviousDay(){
        let _1dayAgo = today.previousDate(0, monthsBack: 0, daysBack: 1)
        let _2MonthsAgo = today.previousDate(0, monthsBack: 2, daysBack: 0)
        let _2YearsAgo = today.previousDate(2, monthsBack: 0, daysBack: 0)
        
        let test_2MonthsBack = calendar.date(byAdding: .month, value: -2, to: today)
        let test_2YearsBack = calendar.date(byAdding: .year, value: -2, to: today)
        
        XCTAssertTrue(calendar.compare(_1dayAgo, to: test_yesterday!, toGranularity: .day) == .orderedSame)
        XCTAssertTrue(calendar.compare(_2MonthsAgo, to: test_2MonthsBack!, toGranularity: .day) == .orderedSame)
        XCTAssertTrue(calendar.compare(_2YearsAgo, to: test_2YearsBack!, toGranularity: .day) == .orderedSame)
    }
    
    func testFirstDayOfMonth(){
        let firstDayOfMonth = today.firstOfMonth()
        var dateComps = calendar.dateComponents([.year,.month], from: today)
        dateComps.day = 1
        let testFirstOfMonth = calendar.date(from: dateComps)
        
        XCTAssertTrue(calendar.compare(firstDayOfMonth, to: testFirstOfMonth!, toGranularity: .day) == .orderedSame)
    }
    
    func testFirstDayofYear() {
        let firstOfYear = today.firstOfYear()
        var dateComps = calendar.dateComponents([.year], from: today)
        dateComps.day = 1
        dateComps.month = 1
        let testFirstOfYear = calendar.date(from: dateComps)
        
        XCTAssertTrue(calendar.compare(firstOfYear, to: testFirstOfYear!, toGranularity: .day) == .orderedSame)
    }
    
    func testLastDayOfMonth() {
        let lastDayOfMonth = today.lastDayOfMonth()
        var dateComps = calendar.dateComponents([.year,.month], from: today)
        dateComps.day = 1
        dateComps.month = dateComps.month! + 1
        let nextMonth = calendar.date(from: dateComps)
        let test_lastDay = calendar.date(byAdding: .day, value: -1, to: nextMonth!)
        
        XCTAssertTrue(calendar.compare(lastDayOfMonth, to: test_lastDay!, toGranularity: .day) == .orderedSame)
    }
    
    func testLastDayOfYear() {
        let lastDayOfYear = today.lastDayOfYear()
        var dateComps = calendar.dateComponents([.year,.month], from: today)
        dateComps.day = 1
        dateComps.month = 1
        dateComps.year = dateComps.year! + 1
        let nextMonth = calendar.date(from: dateComps)
        let test_lastDay = calendar.date(byAdding: .day, value: -1, to: nextMonth!)
        
        XCTAssertTrue(calendar.compare(lastDayOfYear, to: test_lastDay!, toGranularity: .day) == .orderedSame)
    }
    
    func testDateWithNoTime() {
        let startofday = today.dateWithNoTime()
        let test_startOfDay = calendar.startOfDay(for: today)
        
        XCTAssertTrue(calendar.compare(startofday, to: test_startOfDay, toGranularity: .day) == .orderedSame)
    }
    
    func testFormattedSocialTime() {
        let _5hours: TimeInterval = Double(60 * 60 * -5)
        
        var date = Date(timeInterval: _5hours, since: today)
        var dateString = date.formattedSocialTime()
        XCTAssertEqual(dateString, "5 hours ago")
        
        let _4hours: TimeInterval = Double(60 * 60 * -4)
        date = Date(timeInterval:_4hours, since: today)
        dateString = date.formattedSocialTime()
        XCTAssertEqual(dateString, "4 hours ago")
        
        let _10hours: TimeInterval = Double(60 * 60 * -10)
        date = Date(timeInterval:_10hours, since: today)
        dateString = date.formattedSocialTime()
        XCTAssertEqual(dateString, "today")
        
        let _30mins: TimeInterval = Double(60 * -30)
        date = Date(timeInterval: _30mins, since: today)
        dateString = date.formattedSocialTime()
        XCTAssertEqual(dateString, "30 mins ago")
        
        let _30seconds: TimeInterval = Double(-30)
        date = Date(timeInterval:_30seconds, since: today)
        dateString = date.formattedSocialTime()
        XCTAssertEqual(dateString, "30 seconds ago")
        
        let _5seconds: TimeInterval = Double(-5)
        date = Date(timeInterval:_5seconds, since: today)
        dateString = date.formattedSocialTime()
        XCTAssertEqual(dateString, "moments ago")
    }
    
}
