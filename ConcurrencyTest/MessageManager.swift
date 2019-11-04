//
//  MessageManager.swift
//  ConcurrencyTest
//


import Foundation

class MessageManager {
    
    let group = DispatchGroup()
    
    func loadMessage(intervalOne: DispatchTimeInterval = DispatchTimeInterval.milliseconds(0),
                     intervalTwo: DispatchTimeInterval = DispatchTimeInterval.milliseconds(0),
                     completion: @escaping (String) -> Void) {
        
        var firstWord: String = ""
        var secondWord: String = ""
        let intervalOne = intervalOne != DispatchTimeInterval.milliseconds(0) ? intervalOne : generateRandomInterval()
        let intervalTwo = intervalTwo != DispatchTimeInterval.milliseconds(0) ? intervalTwo : generateRandomInterval()
        
        group.enter()
        self.fetchMessageOne(interval: intervalOne) { (messageOne) in
            firstWord = messageOne
            self.group.leave()
        }
        
        group.enter()
        self.fetchMessageTwo(interval: intervalTwo) { (messageTwo) in
            secondWord = messageTwo
            self.group.leave()
        }
        
        DispatchQueue.global().async() {
            if self.group.wait(timeout: .now() + .milliseconds(Constants.TimeIntervals.timeOut)) == .timedOut {
                self.group.notify(queue: .main) {
                    completion(Constants.Messages.timeOutErrorMessage)
                }
            } else {
                self.group.notify(queue: .main) {
                    completion(firstWord + " " + secondWord)
                }
            }
        }
    }
    
    func generateRandomInterval() -> DispatchTimeInterval {
        let random = Int.random(in: Constants.TimeIntervals.intervalMin...Constants.TimeIntervals.intervalMax)
        return DispatchTimeInterval.milliseconds(random)
    }
    
    func fetchMessageOne(interval: DispatchTimeInterval, completion: @escaping (String) -> Void) {
        DispatchQueue.global().asyncAfter(deadline: .now() + interval) {
            completion(Constants.Messages.messageOne)
        }
    }
    
    func fetchMessageTwo(interval: DispatchTimeInterval, completion: @escaping (String) -> Void) {
        DispatchQueue.global().asyncAfter(deadline: .now() + interval) {
            completion(Constants.Messages.messageTwo)
        }
    }
}
