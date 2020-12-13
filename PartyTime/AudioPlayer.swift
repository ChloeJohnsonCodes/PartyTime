//
//  AudioPlayer.swift
//  HelloWorld
//
//  Created by Chloe Johnson on 11/27/20.
//

import Foundation
import AVFoundation

public class AudioPlayer: NSObject {
    
    var audioPlayer:AVAudioPlayer?

    @objc func createAudioPlayer() {
        let sound = Bundle.main.path(forResource: "RaveSound", ofType: "m4a")
        audioPlayer = try! AVAudioPlayer(contentsOf: URL(fileURLWithPath: sound!))
        audioPlayer?.prepareToPlay()
        audioPlayer?.setVolume(1.0, fadeDuration: 0.0)
        audioPlayer?.numberOfLoops = -1
    }
    
    @objc func playSound() {
        audioPlayer?.play()
    }
    
    @objc func pauseSound() {
        audioPlayer?.pause()
    }
    
    @objc func stopSound() {
        audioPlayer?.stop()
    }
}


