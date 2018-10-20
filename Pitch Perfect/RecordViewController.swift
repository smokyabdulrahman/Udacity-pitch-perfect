//
//  RecordViewController.swift
//  Pitch Perfect
//
//  Created by ABDULRAHMAN ALRAHMA on 10/18/18.
//  Copyright © 2018 ABDULRAHMAN ALRAHMA. All rights reserved.
//

import UIKit
import AVFoundation
class RecordViewController: UIViewController, AVAudioRecorderDelegate {

    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var stopRecordingButton: UIButton!
    @IBOutlet weak var recordingLabel: UILabel!
    
    var audioRecorder: AVAudioRecorder!
    
    enum RecordingState { case recording, notRecording }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI(state: .notRecording)
    }
    
    @IBAction func startRecording(_ sender: UIButton) {
        configureUI(state: .recording)
        
        let dirPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String
        let recordingName = "pitch.wav"
        let pathArray = [dirPath, recordingName]
        let filePath = URL(string: pathArray.joined(separator: "/"))
        
        let session = AVAudioSession.sharedInstance()
        try! session.setCategory(AVAudioSession.Category.playAndRecord, mode: AVAudioSession.Mode.default, options: AVAudioSession.CategoryOptions.defaultToSpeaker)
        
        try! audioRecorder = AVAudioRecorder(url: filePath!, settings: [:])
        audioRecorder.delegate = self
        audioRecorder.isMeteringEnabled = true
        audioRecorder.prepareToRecord()
        audioRecorder.record()
    }
    
    @IBAction func stopRecording(_ sender: UIButton) {
        configureUI(state: .notRecording)
        audioRecorder.stop()
        let session = AVAudioSession.sharedInstance()
        try! session.setActive(false)
    }
    
    func configureUI(state: RecordingState) {
        switch state {
        case .recording:
            recordButton.isEnabled = false
            stopRecordingButton.isEnabled = true
            recordingLabel.text = "Recording ..."
        case .notRecording:
            recordButton.isEnabled = true
            stopRecordingButton.isEnabled = false
            recordingLabel.text = "Ready to record"
        }
    }
    
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        if flag {
            performSegue(withIdentifier: "stopRecording", sender: audioRecorder.url)
        } else {
            let alert = UIAlertController(title: "Recording Error", message: "Awkward, the app failed to record your beautiful voice. Please, give it another try.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "stopRecording" {
            let playVC = segue.destination as! PlayViewController
            let audioURL = sender as! URL
            playVC.audioURL = audioURL
        }
    }
    
}

