//
//  MenuController.swift
//  Pong
//
//  Created by Jordan Medlock on 2/23/16.
//  Copyright © 2016 SnowyWatermelon. All rights reserved.
//

import WatchKit
import Foundation


class MenuController: WKInterfaceController {

  @IBOutlet var scoreLabel: WKInterfaceLabel!
  @IBOutlet var highScoreLabel: WKInterfaceLabel!
  var context: GameContext = GameContext()
  
  override func awakeWithContext(context: AnyObject?) {
    super.awakeWithContext(context)
    
  
    // Configure interface objects here.
  }

  override func willActivate() {
    // This method is called when watch view controller is about to be visible to user
    super.willActivate()
    scoreLabel.setText("\(context.score)")
    highScoreLabel.setText("\(context.highScore)")
  }

  override func didDeactivate() {
    // This method is called when watch view controller is no longer visible
    super.didDeactivate()
  }
  
  override func contextForSegueWithIdentifier(segueIdentifier: String) -> AnyObject? {
    return context
  }
}
