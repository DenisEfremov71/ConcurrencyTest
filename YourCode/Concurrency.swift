//
//  Concurrency.swift
//


import Foundation

func loadMessage(completion: @escaping (String) -> Void) {
    
    let group = DispatchGroup()
    var firstWord: String = ""
    var secondWord: String = ""
        
    group.enter()
    fetchMessageOne { (messageOne) in
        firstWord = messageOne
        group.leave()
    }
    
    group.enter()
    fetchMessageTwo { (messageTwo) in
        secondWord = messageTwo
        group.leave()
    }
    
    DispatchQueue.global().async() {
        if group.wait(timeout: .now() + .milliseconds(Constants.TimeIntervals.timeOut)) == .timedOut {
            group.notify(queue: .main) {
                completion(Constants.Messages.timeOutErrorMessage)
            }
        } else {
            group.notify(queue: .main) {
                completion(firstWord + " " + secondWord)
            }
        }
    }
}
