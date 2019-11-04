//
//  ConcurrencyTestTests.swift
//  ConcurrencyTestTests
//


import XCTest
@testable import ConcurrencyTest

class ConcurrencyTests: XCTestCase {
    
    let messageManager = MessageManager()
    
    override func setUp() {
    }
    
    override func tearDown() {
    }
    
    func testLoadMessageOneBeforeTwoSuccess() {
        
        let exp = expectation(description: Constants.Expectations.loadMessageOneBeforeTwoSuccess)
        
        // Given: loading messages
        
        // When: both messages are received within 2000 milliseconds,
        // first message received in 500 milliseconds and the second message in 1000 milliseconds
        let intervalOne = DispatchTimeInterval.milliseconds(Constants.TimeIntervals.intervalFive)
        let intervalTwo = DispatchTimeInterval.milliseconds(Constants.TimeIntervals.intervalTen)
        messageManager.loadMessage(intervalOne: intervalOne, intervalTwo: intervalTwo) { (completeMessage) in
            
            // Then: the complete message should be equal to messageOne + " " + messageTwo
            XCTAssertEqual(completeMessage, Constants.Messages.completeMessage, Constants.Messages.completeMessageWrong)
            exp.fulfill()
        }
        
        waitForExpectations(timeout: 3.0, handler: nil)
    }
    
    func testLoadMessageTwoBeforeOneSuccess() {
        
        let exp = expectation(description: Constants.Expectations.loadMessageTwoBeforeOneSuccess)
        
        // Given: loading messages
        
        // When: both messages are received within 2000 milliseconds,
        // second message received in 500 milliseconds and the first message in 1000 milliseconds
        let intervalOne = DispatchTimeInterval.milliseconds(Constants.TimeIntervals.intervalTen)
        let intervalTwo = DispatchTimeInterval.milliseconds(Constants.TimeIntervals.intervalFive)
        messageManager.loadMessage(intervalOne: intervalOne, intervalTwo: intervalTwo) { (completeMessage) in
            
            // Then: the complete message should be equal to messageOne + " " + messageTwo
            XCTAssertEqual(completeMessage, Constants.Messages.completeMessage, Constants.Messages.completeMessageWrong)
            exp.fulfill()
        }
        
        waitForExpectations(timeout: 3.0, handler: nil)
    }
    
    func testLoadMessageOneAndTwoAtTheSameTimeSuccess() {
        
        let exp = expectation(description: Constants.Expectations.loadMessageOneAndTwoAtTheSameTimeSuccess)
        
        // Given: loading messages
        
        // When: both messages are received within 2000 milliseconds,
        // both, first and second message, received in 500 milliseconds
        let intervalOne = DispatchTimeInterval.milliseconds(Constants.TimeIntervals.intervalFive)
        let intervalTwo = DispatchTimeInterval.milliseconds(Constants.TimeIntervals.intervalFive)
        messageManager.loadMessage(intervalOne: intervalOne, intervalTwo: intervalTwo) { (completeMessage) in
            
            // Then: the complete message should be equal to messageOne + " " + messageTwo
            XCTAssertEqual(completeMessage, Constants.Messages.completeMessage, Constants.Messages.completeMessageWrong)
            exp.fulfill()
        }
        
        waitForExpectations(timeout: 3.0, handler: nil)
    }
    
    func testLoadMessageOneAfterTimeOut() {
        
        let exp = expectation(description: Constants.Expectations.loadMessageOneAfterTimeOut)
        
        // Given: loading messages
        
        // When: the first message is received after 2000 milliseconds timeout,
        // the second message is received in 1500 milliseconds
        let intervalOne = DispatchTimeInterval.milliseconds(Constants.TimeIntervals.afterTimeOut)
        let intervalTwo = DispatchTimeInterval.milliseconds(Constants.TimeIntervals.intervalFifteen)
        messageManager.loadMessage(intervalOne: intervalOne, intervalTwo: intervalTwo) { (completeMessage) in
            
            // Then: the complete message should be equal to "Unable to load message - Time out exceeded"
            XCTAssertEqual(completeMessage, Constants.Messages.timeOutErrorMessage, Constants.Messages.timeOutMessageWrong)
            exp.fulfill()
        }
        
        waitForExpectations(timeout: 5.0, handler: nil)
    }
    
    func testLoadMessageTwoAfterTimeOut() {
        
        let exp = expectation(description: Constants.Expectations.loadMessageTwoAfterTimeOut)
        
        // Given: loading messages
        
        // When: the second message is received after 2000 milliseconds timeout,
        // the first message is received in 1500 milliseconds
        let intervalOne = DispatchTimeInterval.milliseconds(Constants.TimeIntervals.intervalFifteen)
        let intervalTwo = DispatchTimeInterval.milliseconds(Constants.TimeIntervals.afterTimeOut)
        messageManager.loadMessage(intervalOne: intervalOne, intervalTwo: intervalTwo) { (completeMessage) in
            
            // Then: the complete message should be equal to "Unable to load message - Time out exceeded"
            XCTAssertEqual(completeMessage, Constants.Messages.timeOutErrorMessage, Constants.Messages.timeOutMessageWrong)
            exp.fulfill()
        }
        
        waitForExpectations(timeout: 5.0, handler: nil)
    }
    
    func testLoadBothMessagesAfterTimeOut() {
        
        let exp = expectation(description: Constants.Expectations.loadMessageOneAndTwoAfterTimeOut)
        
        // Given: loading messages
        
        // When: the both messages are received after 2000 milliseconds timeout
        let intervalOne = DispatchTimeInterval.milliseconds(Constants.TimeIntervals.afterTimeOut)
        let intervalTwo = DispatchTimeInterval.milliseconds(Constants.TimeIntervals.afterTimeOut)
        messageManager.loadMessage(intervalOne: intervalOne, intervalTwo: intervalTwo) { (completeMessage) in
            
            // Then: the complete message should be equal to "Unable to load message - Time out exceeded"
            XCTAssertEqual(completeMessage, Constants.Messages.timeOutErrorMessage, Constants.Messages.timeOutMessageWrong)
            exp.fulfill()
        }
        
        waitForExpectations(timeout: 5.0, handler: nil)
    }
    
}
