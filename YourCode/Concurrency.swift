//
//  Concurrency.swift


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
    
    group.notify(queue: .main) {
        completion(firstWord + " " + secondWord)
    }
}
