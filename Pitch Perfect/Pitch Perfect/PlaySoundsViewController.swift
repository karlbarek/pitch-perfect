//
//  PlaySoundsViewController.swift
//  Pitch Perfect
//
//  Created by Karl Barek on 3/7/15.
//  Copyright (c) 2015 pixels2bytes. All rights reserved.
//

import UIKit
import AVFoundation

class PlaySoundsViewController: UIViewController {
    
    //MARK: - Variables
    var audioPlayer = AVAudioPlayer()
    var receivedAudio:RecordedAudio!
    
    var audioEngine:AVAudioEngine!
    var audioFile:AVAudioFile!
    
    //MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        audioPlayer = AVAudioPlayer(contentsOfURL: receivedAudio.filePathUrl, error: nil)
        audioPlayer.enableRate = true
        
        audioEngine = AVAudioEngine()
        audioFile = AVAudioFile(forReading: receivedAudio.filePathUrl, error: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Functions
    func playSoundAtSpeed (speed: CFloat) {
        audioPlayer.stop()
        audioPlayer.rate = speed
        audioPlayer.currentTime = 0.0
        audioPlayer.play()
    }
    
    func playAudioWithVariablePitch (pitch:Float) {
        audioPlayer.stop()
        audioEngine.stop()
        audioEngine.reset()
        
        var audioPlayerNode = AVAudioPlayerNode()
        audioEngine.attachNode(audioPlayerNode)
        
        var changePitchEffect = AVAudioUnitTimePitch()
        changePitchEffect.pitch = pitch
        audioEngine.attachNode(changePitchEffect)
        
        audioEngine.connect(audioPlayerNode, to: changePitchEffect, format: nil)
        audioEngine.connect(changePitchEffect, to: audioEngine.outputNode, format: nil)
        
        audioPlayerNode.scheduleFile(audioFile, atTime: nil, completionHandler: nil)
        audioEngine.startAndReturnError(nil)
        
        audioPlayerNode.play()
    }
    
    // MARK: - Actions
    @IBAction func playSlowSound(sender: UIButton) {
        audioEngine.stop()
        audioEngine.reset()
        playSoundAtSpeed(0.5)
    }
    
    @IBAction func playFastSound(sender: UIButton) {
        audioEngine.stop()
        audioEngine.reset()
        playSoundAtSpeed(1.5)
    }
    
    @IBAction func playChipmunkSound(sender: UIButton) {
        playAudioWithVariablePitch(1000)
    }

    @IBAction func playDarthVaderAudio(sender: UIButton) {
        playAudioWithVariablePitch(-1000)
    }
    
    @IBAction func stopAllSounds(sender: UIButton) {
        audioEngine.stop()
        audioEngine.reset()
        audioPlayer.stop()
    }
}
