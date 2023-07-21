//
//  PlaySound.swift
//  ZanyaFirst
//
//  Created by Kimjaekyeong on 2023/07/18.
//

import Foundation
import AVFoundation

var audioPlayer: AVAudioPlayer? = AVAudioPlayer()

//Play sound with a default value
//set to 1.0

func playSound(sound: String, type: String = "", volume: Float = 1.0) {
    if let path = Bundle
        .main
        .path(forResource: sound, ofType: type) {
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
            
            //Set the volume
            audioPlayer?.setVolume(volume, fadeDuration: 0.1)
            
            //Play the sound
            audioPlayer?.play()
        } catch {
            print("AUDIO ERROR")
        }
    }
}

func stopPlaying() {
    audioPlayer?.stop()
}
