//
//  InterfaceController.swift
//  Pong WatchKit Extension
//
//  Created by Jordan Medlock on 1/11/16.
//  Copyright © 2016 SnowyWatermelon. All rights reserved.
//

import WatchKit
import Foundation


class GameController: WKInterfaceController {

  @IBOutlet var middleImage: WKInterfaceImage!
  @IBOutlet var leftPaddle: WKInterfacePicker!
  @IBOutlet var rightPaddle: WKInterfacePicker!
  var context: GameContext!
  let numPaddles: Int = 28
  let paddleWidth: Int = 6
  let numBalls: Int = 28
  var rightPaddleLoc: Int = 0
  var paddleNames: [String] = []
  var paddleImages: [WKImage] = []
  var paddlePickerItems: [WKPickerItem] = []
  func ballName(x: Int, y: Int) -> String? {
    let newX = min(max(x, 0), numBalls-1)
    let newY = min(max(y, 0), numBalls-1)
    return String(format: "BALL_%02d_%02d.png", newX, newY)
  }
  func coveredByPaddle(ball: Double, paddle: Int) -> Bool {
    let convBall = ((10 - 1) / Double(numBalls)) * ball
    let convPaddle = ((10 - 2) / Double(numPaddles)) * Double(numPaddles-1-paddle)
    print("ball: \(convBall), paddle: \(convPaddle)")
    return convBall > convPaddle - 1 && convPaddle + 2 > convBall
  }
  override func awakeWithContext(context: AnyObject?) {
    super.awakeWithContext(context)
    self.context = context as! GameContext
    for i in 0..<numPaddles {
      paddleNames.append(String(format: "PADDLE_%02d.png",numPaddles-1-i))
      paddleImages.append(WKImage(imageName: paddleNames[i]))
      let item = WKPickerItem()
      item.contentImage = paddleImages[i]
      paddlePickerItems.append(item);
    }
    
    rightPaddle.setItems(paddlePickerItems)
    rightPaddle.focus()
    
    leftPaddle.setItems(paddlePickerItems)
    leftPaddle.setEnabled(false)
    middleImage.setImage(UIImage(named: "BALL_00_00.png"))
    // Configure interface objects here.
    print("Starting timer")
    NSTimer.scheduledTimerWithTimeInterval(0.1, target: self, selector: "timerTick", userInfo: nil, repeats: true)
  }
  
  @IBAction func pickerChanged(value: Int) {
    rightPaddleLoc = value
  }
  
//  func timerTick() {
//    print("\(ballLoc)")
//    ballLoc.x += 1;
//    ballLoc.y += 1;
//    let name = ballName(Int(ballLoc.x), y: Int(ballLoc.y))!
//    print(name)
//    middleImage.setImage(UIImage(named: name))
//    leftPaddle.setSelectedItemIndex((numPaddles - 1 - Int(ballLoc.y)) % numPaddles)
//    
//  }
  
  func updateScore(newScore: Int) {
    context.score = newScore;
    self.setTitle("Score: \(context.score)")
  }
  func timerTick() {
    print("\(context.ballVel)")
    context.ballLoc.x += context.ballVel.x / 2
    context.ballLoc.y += context.ballVel.y / 2
    leftPaddle.setSelectedItemIndex(numPaddles - 1 - Int(context.ballLoc.y))
    middleImage.setImage(UIImage(named: ballName(Int(context.ballLoc.x), y: Int(context.ballLoc.y))!))
    if (context.ballLoc.x >= Double(numBalls - 1)) {
      if (coveredByPaddle(context.ballLoc.y, paddle: rightPaddleLoc)) {
        context.ballVel.x = -context.ballVel.x*(1 + Double(arc4random_uniform(100))/500.0)
        context.ballVel.y = context.ballVel.y*(1 + Double(arc4random_uniform(100))/500.0)
        updateScore(context.score + 1)
      } else {
        print("You lost!!!")
        updateScore(0)
        context.ballLoc = (1,2)
        context.ballVel = (1,1)
      }
    }
    if (context.ballLoc.x < 1) {
      context.ballVel.x = -context.ballVel.x
    }
    if (context.ballLoc.y >= Double(numBalls - 1) || context.ballLoc.y < 1) {
      context.ballVel.y = -context.ballVel.y
    }
  }

  override func willActivate() {
    // This method is called when watch view controller is about to be visible to user
    super.willActivate()
  }

  override func didDeactivate() {
    // This method is called when watch view controller is no longer visible
    super.didDeactivate()
  }

}
