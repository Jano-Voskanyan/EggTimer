//
//  ViewController.swift
//  EggTimer
//
//  Created by Janibek Voskanyan on 25.01.23.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var progressView: UIProgressView!
    
    var player: AVAudioPlayer!
    
    let eggTimes = ["Soft": 3,
                    "Medium": 4,
                    "Hard": 7]
    
    var totalTime: Float = 0
    var secondsPassed: Float = 0
    
    var timer = Timer()
    
    @IBAction func hardnessSelected(_ sender: UIButton) {
         
        
        timer.invalidate()
        let hardness = sender.titleLabel!.text! //Soft, Medium, Hard
        totalTime = Float(eggTimes[hardness]!)
        
        progressView.progress = 0.0
        secondsPassed = 0
        titleLabel.text = hardness
        
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
        }
    
    @objc func updateTimer() {
        if secondsPassed < totalTime {
            secondsPassed += 1
            progressView.progress = secondsPassed / totalTime

        } else {
            timer.invalidate()
            titleLabel.text = "DONE!"
            
            let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3")
            player = try! AVAudioPlayer(contentsOf: url!)
            player.play()
            
        }
    }
}

