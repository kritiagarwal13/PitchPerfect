//
//  PlaySoundsViewController.swift
//  PitchPerfect
//
//  Created by Kriti Agarwal on 12/05/20.
//  Copyright © 2020 Udacity. All rights reserved.
//

import UIKit
import AVFoundation

enum ButtonType: Int {
    case slow = 0, fast, chipmunk, vader, echo, reverb
}

class PlaySoundsViewController: UIViewController {

    //MARK:- @IBOutlets
    @IBOutlet weak var snailButton: UIButton!
    @IBOutlet weak var chipmunkButton: UIButton!
    @IBOutlet weak var rabbitButton: UIButton!
    @IBOutlet weak var vaderButton: UIButton!
    @IBOutlet weak var echoButton: UIButton!
    @IBOutlet weak var reverbButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    
    
    //MARK:- Properties
    var recordedAudioURL: URL!
    var audioFile:AVAudioFile!
    var audioEngine:AVAudioEngine!
    var audioPlayerNode: AVAudioPlayerNode!
    var stopTimer: Timer!
    
    //MARK:- Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(recordedAudioURL!)
        setupAudio()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        configureUI(.notPlaying)
    }

    
    //MARK:- @IBActions
   @IBAction func playSoundForButton(_ sender: UIButton) {
       switch(ButtonType(rawValue: sender.tag)!) {
       case .slow:
           playSound(rate: 0.5)
       case .fast:
           playSound(rate: 1.5)
       case .chipmunk:
           playSound(pitch: 1000)
       case .vader:
           playSound(pitch: -1000)
       case .echo:
           playSound(echo: true)
       case .reverb:
           playSound(reverb: true)
       }

       configureUI(.playing)
   }

   @IBAction func stopButtonPressed(_ sender: AnyObject) {
        print("Stop Audio Button Pressed")
        stopAudio()
   }

}
