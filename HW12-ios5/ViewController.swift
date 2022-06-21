//
//  ViewController.swift
//  HW12-ios5
//
//  Created by  Nataly on 20.06.22.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var playPauseButton: UIButton!
    @IBAction func playPauseAction(_ sender: Any) {
        if isStartedTime {
            timer.invalidate()
            playPauseButton.setImage(UIImage(systemName: "play"), for: .normal)
            isStartedTime = false
        } else {
            isStartedTime = true
            startTime()
            playPauseButton.setImage(UIImage(systemName: "pause"), for: .normal)
        }
    }
    @IBOutlet weak var viewAround: UIStackView!
    
    
    private var timer = Timer()
    private var isWorkTime = true
    private var isStartedTime = false // таймер запущен - true, на стопе - false
    private var totalTime = Metric.timeForWork
    
    override func viewDidLoad() {
        super.viewDidLoad()
        timerLabel.text = timeFormatted(totalTime)
        viewAround.layer.cornerRadius = viewAround.frame.width/2
        viewAround.layer.borderWidth = 3
        viewAround.layer.borderColor = UIColor.green.cgColor
        timerLabel.textColor = UIColor.green
        playPauseButton.tintColor = UIColor.green
        // Do any additional setup after loading the view.
    }

    func startTime() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }

    @objc private func updateTimer() {
        timerLabel.text = timeFormatted(totalTime)
            if totalTime != 0 {
                totalTime -= 1
            } else {
                timer.invalidate()
                isStartedTime = false
        
                if isWorkTime {
                    totalTime = Metric.timeForRest
                    viewAround.layer.borderColor = UIColor.red.cgColor
                    timerLabel.textColor = UIColor.red
                    playPauseButton.tintColor = UIColor.red
                } else {
                    totalTime = Metric.timeForWork
                    viewAround.layer.borderColor = UIColor.green.cgColor
                    timerLabel.textColor = UIColor.green
                    playPauseButton.tintColor = UIColor.green
                }
                isWorkTime = !isWorkTime
                playPauseButton.setImage(UIImage(systemName: "play"), for: .normal)
            }
    }
    
    private func timeFormatted(_ totalSeconds: Int) -> String {
        let seconds: Int = totalSeconds % 60
        let minutes: Int = (totalSeconds / 60) % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
}

extension ViewController {
    enum Metric {
        static let timeForWork = 5
        static let timeForRest = 3
    }
}

