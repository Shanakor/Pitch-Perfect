//
//  RecordSoundsViewController.swift
//  PitchPerfect
//
//  Created by Niklas Rammerstorfer on 24/07/2017.
//  Copyright © 2017 rammerstorfer. All rights reserved.
//

import UIKit
import AVFoundation

class RecordSoundsViewController: UIViewController{
    // MARK: Outlets
    @IBOutlet weak var recordingLabel: UILabel!
    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var stopRecordingButton: UIButton!

    var audioRecorder: AVAudioRecorder!

    struct Segues{
        static let stopRecordingSegue = "stopRecording"
    }
    
    struct Alerts{
        static let recordingErrorTitle = "Recording failed!"
        static let recordingErrorMsg = "For some reason, the recording failed."
        static let recordingErrorActionName = "Ok"
    }
    
    // MARK: UI Actions
    @IBAction func recordAudio(_ sender: Any) {
        configureUI(isRecording: true)
        
        recordAudio()
    }
    
    private func recordAudio(){
        let dirPath = NSSearchPathForDirectoriesInDomains(.documentDirectory,.userDomainMask, true)[0] as String
        let recordingName = "recordedVoice.wav"
        let pathArray = [dirPath, recordingName]
        let filePath = URL(string: pathArray.joined(separator: "/"))
        
        let session = AVAudioSession.sharedInstance()
        try! session.setCategory(AVAudioSessionCategoryPlayAndRecord, with:AVAudioSessionCategoryOptions.defaultToSpeaker)
        
        try! audioRecorder = AVAudioRecorder(url: filePath!, settings: [:])
        audioRecorder.delegate = self
        audioRecorder.isMeteringEnabled = true
        audioRecorder.prepareToRecord()
        audioRecorder.record()
    }

    @IBAction func stopRecording(_ sender: Any) {
        configureUI(isRecording: false)
        
        stopRecording()
    }
    
    private func stopRecording(){
        audioRecorder.stop()
        let audioSession = AVAudioSession.sharedInstance()
        try! audioSession.setActive(false)
    }
    
    // MARK: UI Functions
    func configureUI(isRecording: Bool){
        recordingLabel.text = isRecording ? "Recording in Progress" : "Tap to Record"
        recordButton.isEnabled = !isRecording
        stopRecordingButton.isEnabled = isRecording
    }
    
    fileprivate func showRecordingErrorAlert(){
        let alertController = UIAlertController(title: Alerts.recordingErrorTitle, message: Alerts.recordingErrorMsg, preferredStyle: .alert)
        
        let action = UIAlertAction(title: Alerts.recordingErrorActionName, style: .default, handler: nil)
        alertController.addAction(action)
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    // MARK: Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Segues.stopRecordingSegue {
            let playSoundsVC = segue.destination as! PlaySoundsViewController
            let recordedAudioURL = sender as! URL
            playSoundsVC.recordedAudioURL = recordedAudioURL
        }
    }
}

// MARK: Audio Recorder Delegate
extension RecordSoundsViewController : AVAudioRecorderDelegate{
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        if flag{
            performSegue(withIdentifier: Segues.stopRecordingSegue, sender: audioRecorder.url)
        }
        else{
            showRecordingErrorAlert()
        }
    }
}

