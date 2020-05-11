//
//  RecordSoundsViewController.swift
//  PitchPerfect
//
//  Created by Kriti Agarwal on 12/05/20.
//  Copyright © 2020 Udacity. All rights reserved.
//

import UIKit
import AVFoundation

class RecordSoundsViewController: UIViewController, AVAudioRecorderDelegate {

    //MARK:- @IBOutlets
    @IBOutlet weak var btnRecord: UIButton!
    @IBOutlet weak var lblRecord: UILabel!
    @IBOutlet weak var btnStopRecording: UIButton!
    
    //MARK:- Properties
    var audioRecorder: AVAudioRecorder!
    
    //MARK:- Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        btnStopRecording.isEnabled = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
    }
    
    
    //MARK:- Extra Methods
    func configuringUI(appState: Bool) {
        if appState {
            btnStopRecording.isEnabled = true
            btnRecord.isEnabled = false
        } else {
            btnRecord.isEnabled = true
            btnStopRecording.isEnabled = false
        }
    }
    
    
    //MARK:- @IBActions
    @IBAction func didTapRecordBtn(_ sender: UIButton) {
        configuringUI(appState: true)
        let dirPath = NSSearchPathForDirectoriesInDomains(.documentDirectory,.userDomainMask, true)[0] as String
        let recordingName = "recordedVoice.wav"
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
    
    @IBAction func didTapStopRecording(_ sender: UIButton) {
        configuringUI(appState: false)
        audioRecorder.stop()
        let audioSession = AVAudioSession.sharedInstance()
        try! audioSession.setActive(false)
        
    }
    
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        if flag {
            performSegue(withIdentifier: "stopRecording", sender: audioRecorder.url)
        } else {
            print("Recording audio failed")
        }
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "stopRecording" {
            let playSoundsVC = segue.destination as! PlaySoundsViewController
            let recordedAudioUrl = sender as! URL
            playSoundsVC.recordedAudioURL = recordedAudioUrl
        }
    }

}

