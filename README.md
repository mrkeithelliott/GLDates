# GLDates ![GitHub license](https://img.shields.io/badge/license-MIT-lightgrey.svg)
Swift Date utilities
GLDates is a small library of date utilities to handle lots of common date operations.  It is implemented as an extension on NSDate.
#  [![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage) ![Swift 2.0](https://img.shields.io/badge/swift-2.0-orange.svg) ![Release 0.1](https://img.shields.io/badge/release-0.1-blue.svg)

## Requirements

* A version of [Xcode][xcode] (7.x) capable of building the project you wish to document.
* iOS 8.x, Swift 1.2 or 2.0

##Installation

####[Carthage](http://github.com/Carthage/Carthage)
```ruby 
github "mrkeithelliott/GLDates" ~> 0.1
```

## Usage
####Import `GLDates` module
```swift
import GLDates
```

#### Getting yesterday
```swift
let yesterday = NSDate.yesterday()   
```

#### Date operations
```swift
// Getting Last Year
let today = NSDate()
let lastYear = today.previousDate(1, monthsBack: 0, daysBack: 0)
```

```swift
// Getting Last month
let lastMonth = today.previousDate(0, monthsBack: 1, daysBack: 0)
```
```swift
// Getting the first day of the month
let firstOfMonth = NSDate().firstOfMonth()
```

```swift
// Getting the last day of the month, given a starting date
let lastDayOfCurrentMonth = today.lastDayOfMonth()
let lastDayOfLastMonth = lastMonth.lastDayOfMonth()
```

```swift
// Getting the first day of the year
let firstOfYear = lastYear.firstOfYear()
```

```swift
// Getting the last day of the year
let lastDayOfCurrentYear = today.lastDayOfYear()
let lastDayOfLastYear = lastYear.lastDayOfYear()
```
#### Social Date Formatting

```swift
 let _5hours: NSTimeInterval = Double(60 * 60 * -5)
        
 var date = NSDate(timeInterval: _5hours, sinceDate: today)
 var dateString = date.formattedSocialTime()
 // prints "5 hours ago"
```

```swift
let _4hours: NSTimeInterval = Double(60 * 60 * -4)
date = NSDate(timeInterval:_4hours, sinceDate: today)
dateString = date.formattedSocialTime()
// prints "4 hours ago"
```

```swift
let _10hours: NSTimeInterval = Double(60 * 60 * -10)
date = NSDate(timeInterval:_10hours, sinceDate: today)
dateString = date.formattedSocialTime()
// prints "today"
```

```swift
let _30mins: NSTimeInterval = Double(60 * -30)
date = NSDate(timeInterval: _30mins, sinceDate: today)
dateString = date.formattedSocialTime()
// prints "30 mins ago"
```

```swift
let _30seconds: NSTimeInterval = Double(-30)
date = NSDate(timeInterval:_30seconds, sinceDate: today)
dateString = date.formattedSocialTime()
// prints "30 seconds ago"
```

```swift
let _5seconds: NSTimeInterval = Double(-5)
date = NSDate(timeInterval:_5seconds, sinceDate: today)
dateString = date.formattedSocialTime()
// prints "moments ago"
```
## License

	The MIT License (MIT)

	Copyright © 2016 GittieLabs

	Permission is hereby granted, free of charge, to any person obtaining a copy
	of this software and associated documentation files (the "Software"), to deal
	in the Software without restriction, including without limitation the rights
	to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
	copies of the Software, and to permit persons to whom the Software is
	furnished to do so, subject to the following conditions:

	The above copyright notice and this permission notice shall be included in
	all copies or substantial portions of the Software.

	THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
	IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
	FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
	AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
	LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
	OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
	THE SOFTWARE.

This project is released under the [MIT license](https://github.com/mrkeithelliott/GLDates/blob/master/LICENSE).

[xcode]: https://developer.apple.com/xcode "Xcode"

