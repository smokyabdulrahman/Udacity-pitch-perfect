//
//  PlayViewController.swift
//  Pitch Perfect
//
//  Created by ABDULRAHMAN ALRAHMA on 10/18/18.
//  Copyright © 2018 ABDULRAHMAN ALRAHMA. All rights reserved.
//

import UIKit
import AVFoundation

class PlayViewController: UIViewController {
    
    @IBOutlet weak var stopButton: UIButton!
    @IBOutlet weak var reverbButton: UIButton!
    @IBOutlet weak var rabbitButton: UIButton!
    @IBOutlet weak var snailButton: UIButton!
    @IBOutlet weak var chipmunkButton: UIButton!
    @IBOutlet weak var vaderButton: UIButton!
    @IBOutlet weak var echoButton: UIButton!
    
    var audioURL: URL!
    var audioFile:AVAudioFile!
    var audioEngine:AVAudioEngine!
    var audioPlayerNode: AVAudioPlayerNode!
    var stopTimer: Timer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupAudio()
        setButtonsContentMode()
    }
    
    func setButtonsContentMode() {
        snailButton.imageView?.contentMode = .scaleAspectFit
        reverbButton.imageView?.contentMode = .scaleAspectFit
        chipmunkButton.imageView?.contentMode = .scaleAspectFit
        rabbitButton.imageView?.contentMode = .scaleAspectFit
        vaderButton.imageView?.contentMode = .scaleAspectFit
        echoButton.imageView?.contentMode = .scaleAspectFit
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureUI(.notPlaying)
    }
    
    enum Sound: Int {
        case fast = 0, slow, high, low, echo, reverb
    }
        
    @IBAction func playSound(_ sender: UIButton) {
        switch Sound(rawValue: sender.tag)! {
        case .fast:
            playSound(rate: 1.5)
        case .slow:
            playSound(rate: 0.5)
        case .high:
            playSound(pitch: 1000)
        case .low:
            playSound(pitch: -1000)
        case .echo:
            playSound(echo: true)
        case .reverb:
            playSound(reverb: true)
        }
        
        configureUI(.playing)
    }
        
    @IBAction func stopSound(_ sender: UIButton) {
        stopAudio()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
