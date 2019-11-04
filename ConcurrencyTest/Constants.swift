//
//  Constants.swift
//  ConcurrencyTest
//


import Foundation

struct Constants {
    
    struct Messages {
        static let messageOne = "Hello"
        static let messageTwo = "world"
        static let completeMessage = "\(messageOne) \(messageTwo)"
        static let timeOutErrorMessage = "Unable to load message - Time out exceeded"
        static let completeMessageWrong = "Received complete message is wrong"
        static let timeOutMessageWrong = "Timeout message is wrong"
    }
    
    struct TimeIntervals {
        static let intervalMin = 200
        static let intervalFive = 500
        static let intervalTen = 1000
        static let intervalFifteen = 1500
        static let timeOut = 2000
        static let afterTimeOut = 2200
        static let intervalMax = 2500
    }
    
    struct Expectations {
        static let loadMessageOneBeforeTwoSuccess = "load message one before message two success"
        static let loadMessageTwoBeforeOneSuccess = "load message two before message one success"
        static let loadMessageOneAndTwoAtTheSameTimeSuccess = "load message one and two at the same time success"
        static let loadMessageOneAfterTimeOut = "load message one after timeout"
        static let loadMessageTwoAfterTimeOut = "load message two after timeout"
        static let loadMessageOneAndTwoAfterTimeOut = "load message one and two after timeout"
    }
}
