//
//  GameContext.swift
//  Pong
//
//  Created by Jordan Medlock on 2/23/16.
//  Copyright © 2016 SnowyWatermelon. All rights reserved.
//

import WatchKit

class GameContext: NSObject {
  var score: Int = 0 {
    willSet {
      if newValue > highScore {
        highScore = newValue
      }
    }
  }
  var ballLoc: (x: Double, y: Double) = (7,7)
  var ballVel: (x: Double, y: Double) {
    return (cos(direction), sin(direction))
  }
  var direction: Double = 0
  var ballSpeed: Int = 1
  
  
  var highScore: Int {
    get {
      if NSUserDefaults.standardUserDefaults().objectForKey("high_score") != nil {
        return NSUserDefaults.standardUserDefaults().integerForKey("high_score")
      } else {
        NSUserDefaults.standardUserDefaults().setInteger(0, forKey: "high_score")
        return 0
      }
    }
    set {
      NSUserDefaults.standardUserDefaults().setInteger(newValue, forKey: "high_score")
    }
  }
  
  func reset() {
    ballLoc = (7,7)
    direction = 0
    ballSpeed = 1
  }
}
